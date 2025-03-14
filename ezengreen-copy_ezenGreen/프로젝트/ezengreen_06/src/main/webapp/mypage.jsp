<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%

request.setCharacterEncoding("utf-8");

if( login == null )
{
	//로그인 정보가 올바르게 전송되지 않음.
	response.sendRedirect("login.jsp");
	return;
}
%>
<script>
function CheckPW()
{
    let person = prompt("현재 비밀번호를 입력해주세요.");

    if(person)
	{
	    $.ajax({
	        type: "post",
	        url: "checknowpw.jsp",
	        dataType: "html",
	        data: { person : person },
	        success: function (result) 
	        {
	            result = result.trim();
	            switch(result) 
	            {
	                case "00":
	                    alert("잘못된 입력입니다.");
	                    break;
	                case "01":
	                	document.location.href = "resetPW.jsp"
	                	break;
	                case "02":
	                    alert("비밀번호가 일치하지 않습니다.");
	                    break;
	            }
	        }
	    });
	}
}
</script>
<form name="mypage" id="mypage" method="post" action="resetPW.jsp">
	<table border="0" width="100%" height="430px" class="maintable">
		<tr>
			<td colspan="5" height="20px"></td>
		</tr>
		<tr height="25px">
			<td colspan="5" style="font-weight: bold;">&nbsp;마이페이지 </td>
		</tr>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 98%; height: 1px; background-color: dimgrey">
			</td>
		</tr>
		<tr>
			<td colspan="5" height="100px"></td>
		</tr>
		<tr>
			<td width="100px"></td>
			<td width="90px" height="30px">아이디 : </td>
			<td colspan="2" >
				<input type="text" value="<%=login.getUid() %>" style="width:90%" readonly>
			</td>
			<td width="175px"></td>
		</tr>
		<tr>
			<td></td>
			<td height="30px">성명 : </td>
			<td colspan="2">
				<input type="text" value="<%=login.getUname() %>" readonly style="width:90%">
			</td>
			<td></td>
		</tr>
		<tr>
			<td></td>
			<td height="30px">이메일 : </td>
			<td colspan="2">
				<input type="text" value="<%=login.getUemail() %>" readonly style="width:90%">
			</td>
			<td></td>
		</tr>
		<tr style="height:40px;">
			<td colspan="5" align="center">
				<input type="button" value="비밀번호 변경" onClick="CheckPW();">&nbsp;
				<input type="button" value="확인" onClick="history.back();">
			</td>
		</tr>
		<tr>
			<td colspan="5"></td>
		</tr>
	</table>
</form>
<%@ include file="include/tail.jsp" %>