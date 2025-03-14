<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
/* head.jsp에서 login 변수를 가져옴 */
String referer = request.getHeader("referer"); // 이전 페이지 URL 가져오기

if(login != null) // 이미 로그인된 상태인 경우
{
    // 이미 로그인 된 사용자는 메인 페이지로 리다이렉트
    response.sendRedirect("index.jsp");
    return;
}
%>
<script>
window.onload = function()
{
    document.login.uid.focus(); // 페이지 로드 시 ID 입력란에 포커스 설정
}

function enterkey()
{
    if(window.event.keyCode == 13) // Enter 키 눌렀을 때
    {
        DoLogin(); // 로그인 함수 호출
    }
}

function viewpw()
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

function DoLogin()
{
    // 폼 유효성 검사
    if(document.login.uid.value == "") // ID 입력 여부 확인
    {
        alert("아이디를 입력하세요.");
        document.login.uid.focus();
        return false;
    }
    if(document.login.upw.value == "") // 비밀번호 입력 여부 확인
    {
        alert("비밀번호를 입력하세요.");
        document.login.upw.focus();
        return false;
    }
    document.login.submit(); // 모든 검사 통과시 폼 제출
    return true;
}
</script>
<!-- 로그인 폼 - 사용자 아이디와 비밀번호 입력 -->
<form name="login" id="login" method="post" action="loginok.jsp?refer=<%= referer %>">
    <table border ="0" width="100%" height="430px" class="maintable">  
        <tr>
            <td>
                <table border="0" align="center">
                    <tr>
                        <td>로그인</td> <!-- 로그인 타이틀 -->
                    </tr>
                </table>
                <br>
                <table border="0" align="center" margin="0">
                    <tr style="height: 40px;">
                        <td style="display: flex; justify-content: center; align-items: center; ">
                            <img src="img/IDimage.png" style="width: auto; height: 40px;" class="radius_img">
                            <!-- ID 아이콘 이미지 -->
                        </td>
                        <td>
                            <input type="text" id="uid" name="uid" style="width: 96%; height: 34px" placeholder="아이디를 입력해주세요 ">
                            <!-- 아이디 입력 필드 -->
                        </td>
                        <td width="44px"></td>
                    </tr>
                </table>
                <br>
                <table border="0" align="center" margin="0">
                    <tr style="height: 40px;">
                        <td style="display: flex; justify-content: center; align-items: center; ">
                            <img src="img/PWimage.png;" style="width: auto; height: 40px;" class="radius_img">
                            <!-- 비밀번호 아이콘 이미지 -->
                        </td>
                        <td>
                            <input type="password" id="upw" name="upw" onkeyup="enterkey()" style="width: 96%; height: 34px" placeholder="비밀번호를 입력해주세요 ">
                            <!-- 비밀번호 입력 필드, 엔터키 이벤트 처리 -->
                        </td>
                        <td>
                            <input type="button" value="보기" id="eye" name="eye" style="height: 30px" onClick="viewpw()">
                            <!-- 비밀번호 보기 버튼 -->
                        </td>
                    </tr>
                </table>
                <br>
                <table border="0" align="center">
                    <tr>
                        <td style="text-align:center; background-color:#BEBEBE;" >
                            <a href="join.jsp"><font color="#FAFBFB">회원가입</font></a>
                            <!-- 회원가입 버튼 -->
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td style="text-align:center; background-color: #5E5E5E;">
                            <a href="javascript:DoLogin();"><font color="#FAFBFB">로그인</font></a>
                            <!-- 로그인 버튼 -->
                        </td>
                    </tr>
                </table>
                <br>
                <table border="0" align="center">
                    <tr>
                        <td><a href="findID.jsp">아이디찾기</a></td> <!-- 아이디 찾기 링크 -->
                        <td>&nbsp; | &nbsp;</td>
                        <td><a href="findPW.jsp">비밀번호 찾기</a></td> <!-- 비밀번호 찾기 링크 -->
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<%@ include file="include/tail.jsp" %> <!-- 푸터 파일 포함 -->