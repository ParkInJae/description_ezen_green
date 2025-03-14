<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>

<script>
function findID()
{
	if( document.findid.uname.value == "" )
	{
		alert("이름을 입력하세요.");
		document.findid.uname.focus();
		return false;
	}
	if( document.findid.uemail.value == "" )
	{
		alert("이메일주소를 입력하세요.");
		document.findid.uemail.focus();
		return false;
	}
	if( document.findid.emailcheck.value == "" )
	{
		alert("인증번호를 입력하세요.");
		document.findid.uemailcheck.focus();
		return false;
	}
	
    $.ajax({
        type: "get",
        url: "findPWEmail.jsp",
        dataType: "html",
        data: {
            uname: document.findid.uname.value,
            uemail: document.findid.uemail.value
        },
        success: function (result) 
        {
            result = result.trim();
            switch(result) 
            {
                case "00":
                    alert("잘못된 입력입니다.");
                    break;
                case "02":
                    alert("회원가입한 아이디가 없습니다.");
                    break;
                default:
                    $.ajax({
                        type: "get",
                        url: "getemail.jsp",
                        dataType: "html",
                        success: function(result) {
                            result = result.trim();
                            if ($("#emailcheck").val() != result) 
                            {
                                alert("이메일 인증번호가 일치하지 않습니다.");
                                $("#emailcheck").focus();
                            }else
                            {
                            	if (confirm("아이디 찾기를 진행하시겠습니까?")==true) 
                                {
                                    $("#findid").submit();
                                }
                            }
                        }
                    });
                    break;
            }
        }
    });

    return true;
}

function email()
{
    var umail = $("#uemail").val();
    if( umail.indexOf("@") <= 0 )
    {
        alert("올바른 메일주소가 아닙니다.");
        $("#uemail").focus();
        return;
    }
    $.ajax({
        type : "get",
        url: "sendmail.jsp?mail=" + umail,
        dataType: "html",
        success : function(result) 
        {
            result = result.trim();
            alert(result);
        }            
    });     
}
</script>
<form name="findid" id="findid" method="post" action="findIDok.jsp">
	<table border="0" width="100%" height="430px" class="n-table" style="background-color: #f0f0f0;">
		<tr style="height: 20px;">
			<td colspan="3"></td>
		</tr>
		<tr height="25px">
			<td colspan="4" style="font-weight: bold;">&nbsp;아이디 찾기 </td>
		</tr>
		<tr>
			<td colspan="4" height="1px">								
				<hr size="1" style="width: 98%; height: 1px; background-color: dimgrey">
			</td>
		</tr>
		<tr class="aaaa">
			<td colspan="4"></td>
		</tr>
		<tr class="aaaa">
			<td width="100px"></td>
			<td colspan="3" style="font-weight: bold; font-size: 13px;">아이디 이메일 전송</td>
		</tr>
		<tr class="aaaa" >
			<td width="100px"></td>
			<td colspan="3" style="font-size: 10px;">가입하신 이메일 주소로 인증번호가 발송됩니다.</td>
		</tr>
		<tr class="aaaa">
			<td colspan="4"></td>
		</tr>
		<tr class="aaaa">
			<td></td>
			<td style="font-weight: bold; font-size: 13px; width:90px"> 이름</td>
			<td colspan="2">
				<input id="uname" name="uname" align="left" style="font-weight: bold; font-size: 13px; width:280px" placeholder="이름을 입력해주세요.">
			</td>
		</tr>
		<tr class="aaaa">
			<td></td>
			<td style="font-weight: bold; font-size: 13px;"> 이메일주소</td>
			<td colspan="2">
				<input id="uemail" name="uemail" align="left" style="font-weight: bold; font-size: 13px;" placeholder="ezen@ezen.com"> 
				<input type="button" value="인증번호 받기" onClick="email();">
				
			</td>
		</tr>
		<tr class="aaaa">
			<td></td>
			<td style="font-weight: bold; font-size: 13px; width:90px"> 인증번호</td>
			<td colspan="2">
				<input type="text" id="emailcheck" name="emailcheck" style="width:280px">
			</td>
		</tr>
		<tr class="aaaa">
			<td colspan="4" align="center">
				<font style="font-size:10pt">비밀번호가 기억나시지 않는다면? <a href="findPW.jsp">비밀번호 찾기</a></font>
			</td>
		</tr>
		<tr style="height:40px;">
			<td colspan="5" align="center">
				<input type="button" value="완료" onClick="findID();">&nbsp;
				<input type="button" value="취소" onClick="history.back()">
			</td>
		</tr>
		<tr>
			<td colspan="5"></td>
		</tr>
	</table>
</form>		    
<%@ include file="include/tail.jsp" %>