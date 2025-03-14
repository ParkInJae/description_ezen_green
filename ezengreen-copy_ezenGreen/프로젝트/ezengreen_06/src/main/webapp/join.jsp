<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
if(login != null) // 로그인 상태 확인
{
    // 이미 로그인된 사용자는 회원가입 불가능, 메인 페이지로 리다이렉트
    response.sendRedirect("index.jsp");
}
%>
<script>
window.onload = function () 
{
    document.join.uid.focus(); // 페이지 로드 시 ID 입력란에 포커스 설정

    // 비밀번호 확인 필드의 키 입력 이벤트 처리
    $("#upwcheck").keyup(function () 
    {
        IsDuplicate = false; // 중복 확인 상태 초기화

        userpw = $("#upw").val(); // 비밀번호 입력값 가져오기
        userpwcheck = $("#upwcheck").val(); // 비밀번호 확인 입력값 가져오기

        if(userpwcheck == "") // 비밀번호 확인란이 비어있는 경우
        {
            $("#spanMsg").html("비밀번호를 입력하세요.");
            return;
        }

        // 비밀번호와 비밀번호 확인값 비교하기
        if (userpw === userpwcheck) // 비밀번호 일치할 경우
        {
            $("#spanMsg").html("비밀번호가 일치합니다.");
            $("#spanMsg").css("color", "blue");
        }else { // 비밀번호 불일치할 경우
            $("#spanMsg").html("비밀번호가 일치하지 않습니다.");
            $("#spanMsg").css("color", "red");
        }
    });

    // 페이지 로드 시 비밀번호 확인 이벤트 트리거하여 초기화
    $("#upwcheck").trigger("keyup");
}
    
function Duplicate() // ID 중복 확인 함수
{    
    userid = $("#uid").val(); // 사용자 입력 ID 가져오기
    //console.log(userid);
    $.ajax({
        type : "get",
        url: "idcheck.jsp?uid=" + userid, // ID 체크 요청 URL
        dataType: "html",
        success : function(result) // 응답 성공 처리
        {
            result = result.trim(); // 결과값 공백 제거
            
            // 결과 코드에 따른 처리
            switch(result)
            {
            case "00": // ID 미입력
                alert("아이디를 입력해주세요.");
                break;
            case "01": // 중복된 ID
                alert("중복된 아이디입니다.");
                IsDuplicate = true; // 중복 상태 플래그 설정
                break;                    
            case "02": // 사용 가능한 ID
                alert("사용 가능한 아이디입니다.");
                break;
            }
        }
    });
}
    
function SendMail() // 이메일 인증 메일 발송 함수
{
    var umail = $("#umail").val(); // 사용자 입력 이메일 가져오기
    if(umail.indexOf("@") <= 0) // 이메일 형식 기본 검증 (@ 포함 여부)
    {
        alert("올바른 메일주소가 아닙니다.");
        $("#umail").focus();
        return;
    }
    $.ajax({
        type : "get",
        url: "sendmail.jsp?mail=" + umail, // 메일 발송 요청 URL
        dataType: "html",
        success : function(result) // 응답 성공 처리
        {
            result = result.trim(); // 결과값 공백 제거
            alert(result); // 결과 메시지 알림
        }            
    });        
}
    
// 회원가입 항목 유효성 검사 함수
function DoJoin()
{
    // 각 입력 필드 검사
    if(document.join.uid.value == "") // ID 입력 확인
    {
        alert("아이디를 입력하세요.");
        document.join.uid.focus();
        return;
    }
    if(document.join.upw.value == "") // 비밀번호 입력 확인
    {
        alert("비밀번호를 입력하세요.");
        document.join.upw.focus();
        return;
    }
    if(document.join.upwcheck.value == "") // 비밀번호 확인 입력 확인
    {
        alert("비밀번호를 입력하세요.");
        document.join.upwcheck.focus();
        return;
    }
    if(document.join.upw.value != document.join.upwcheck.value) // 비밀번호 일치 확인
    {
        alert("비밀번호가 일치하지 않습니다.");
        document.join.upw.focus();
        return;
    }        
    if(document.join.uname.value == "") // 이름 입력 확인
    {
        alert("이름을 입력하세요.");
        document.join.uname.focus();
        return;
    }
    if(document.join.umail.value == "") // 이메일 입력 확인
    {
        alert("이메일을 입력하세요.");
        document.join.uemail.focus();
        return;
    }
    if(document.join.emailcheck.value == "") // 이메일 인증번호 입력 확인
    {
        alert("이메일 인증번호를 입력하세요.");
        document.join.emailcheck.focus();
        return;
    }        
    if(document.join.sign.value == "") // 가입방지코드 입력 확인
    {
        alert("가입방지코드를 입력하세요.");
        document.join.sign.focus();
        return;
    }
    if(document.join.agree.value == "disagree") // 약관 동의 확인
    {
        alert("약관에 동의해주세요.");
        return;
    }
    
    // 이메일 인증번호 확인 (AJAX)
    $.ajax({
        type: "get",
        url: "getemail.jsp", // 서버에 저장된 인증번호 요청
        dataType: "html",
        success: function (result) {
            result = result.trim();
            if ($("#emailcheck").val() != result) { // 인증번호 불일치
                alert("이메일 인증번호가 일치하지 않습니다.");
                $("#emailcheck").focus();
            } else {
                // 이메일 인증 성공 시 가입방지코드 확인 (AJAX)
                $.ajax({
                    type: "get",
                    url: "getsign.jsp", // 서버에 저장된 가입방지코드 요청
                    dataType: "html",
                    success: function (result) {
                        result = result.trim();
                        if ($("#sign").val() != result) { // 가입방지코드 불일치
                            alert("가입방지코드가 일치하지 않습니다.");
                            $("#sign").focus();
                        } else {
                            // 모든 검사 통과 시 확인 대화상자 표시
                            if (confirm("회원가입을 진행하시겠습니까?") == true) {
                                $("#join").submit(); // 폼 제출
                            }
                        }
                    }
                });
            }
        }
    });

    // 기본적으로 false를 반환하여 폼이 제출되지 않도록 함
    return false;
}

function DoCancel() // 회원가입 취소 함수
{
    if(confirm("회원가입을 취소하시겠습니까?") == true)
    {
        document.location = "index.jsp"; // 메인 페이지로 이동
    }
}

function viewpw() // 비밀번호 표시 함수
{
    // 비밀번호 입력 필드를 눌렀을 때 텍스트로 보이게 설정
    eye.addEventListener('mousedown', (event) =>{
        upw.type = 'text'; // 마우스 누르면 비밀번호가 텍스트로 표시
    });
    // 마우스를 떼면 다시 비밀번호 형식으로 변경
    eye.addEventListener('mouseup', (event) =>{
        upw.type = 'password'; // 마우스 떼면 다시 비밀번호가 마스킹됨
    });
}

</script>
<!-- 회원가입 폼 -->
<form name="join" id="join" method="post" action="joinok.jsp">
    <table border="0" width="100%" height="430px" class="maintable">
        <tr height="25px">
            <td colspan="5" style="font-weight: bold;">회원가입 </td> <!-- 회원가입 헤더 -->
        </tr>
        <tr>
            <td colspan="5" height="1px">                                
                <hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
                <!-- 구분선 -->
            </td>
        </tr>
        <tr>
            <td rowspan="7" width="70px"></td>
            <td width="140px">아이디(*)</td> <!-- 필수 입력 표시 -->
            <td colspan="2" >
                <input type="text" name="uid" id="uid" placeholder="아이디는 영문자로만 입력하세요." style="width:67%">
                <input type="button" onClick="Duplicate();" id="dump" name="dump" value="중복확인">
                <!-- ID 입력 필드와 중복확인 버튼 -->
            </td>
            <td rowspan="6" width="140px"></td>
        </tr>
        <tr>
            <td>비밀번호(*)</td>
            <td colspan="2" >
                <input type="password" id="upw" name="upw" placeholder="비밀번호를 입력하세요." style="width:76%">
                <input type="button" value="보기" id="eye" name="eye" onClick="viewpw()">
                <!-- 비밀번호 입력 필드와 보기 버튼 -->
            </td>
        </tr>
        <tr>
            <td>비번확인(*)</td>
            <td colspan="2" style="font-size: 10px;">
                <input type="password" name="upwcheck" id="upwcheck" placeholder="비밀번호를 입력하세요." style="width:93%">
                <br>
                <span id="spanMsg">비밀번호를 입력해주세요</span>
                <!-- 비밀번호 확인 필드와 메시지 표시 영역 -->
            </td>
        </tr>
        <tr>
            <td>성명(*)</td>
            <td colspan="2"><input type="text" name="uname" id="uname" placeholder="성명을 입력하세요." style="width:93%"></td>
            <!-- 이름 입력 필드 -->
        </tr>
        <tr>
            <td>이메일(*)</td>
            <td colspan="2">
                <input type="text" name="umail" id="umail" placeholder="ezen@ezen.com" style="width:57%">
                <input type="button" value="인증번호 받기" onClick="SendMail();">
                <!-- 이메일 입력 필드와 인증번호 요청 버튼 -->
            </td>
        </tr>
        <tr>
            <td>이메일 인증번호(*)</td>
            <td colspan="2" style="font-size: 10px;">
                <input type="text" name="emailcheck" id="emailcheck" placeholder="인증번호를 입력하세요." style="width:93%">
                <!-- 이메일 인증번호 입력 필드 -->
            </td>
        </tr>
        <tr>
            <td height="30px">가입방지코드</td>
            <td colspan="3">
                <img src="img.jsp" style="vertical-align: bottom"> <!-- CAPTCHA 이미지 -->
                <input type="text" id="sign" name="sign" size="6">
                <!-- 가입방지코드(CAPTCHA) 입력 필드 -->
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">본인은 전북현대모터스의 팬임을 인정한다&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="radio" name="agree" id="agree" value="agree">동의
                <input type="radio" name="agree" id="disagree" value="disagree" checked>비동의
                <!-- 약관 동의 라디오 버튼 (비동의가 기본값) -->
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">
                <input type="button" value="가입완료" id="joinAction_btn" onclick="DoJoin();">
                <input type="button" value="취소" onClick="DoCancel()">
                <!-- 가입완료 및 취소 버튼 -->
            </td>
        </tr>
    </table>
</form>
<%@ include file="include/tail.jsp" %> <!-- 푸터 파일 포함 -->