<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String reupw  = request.getParameter("reupw");
String uid    = request.getParameter("uid");
//1.  uid, uemail이 맞는지 유효성을 검사
if(reupw == null || reupw == ""   ) 
{
	response.sendRedirect("resetPW.jsp");
	return;
}


UserDTO udto = new UserDTO();
UserVO vo = new UserVO();
if(login != null)
{
	vo = udto.resetPW(login.getUno(), reupw);
}else
{
	vo = udto.resetPW2(uid, reupw);
}


session.setAttribute("login"  , null);

%>       
<script>
window.onload = function()
{
	alert("비밀번호가 변경 되었습니다");
	
	window.location.href = "login.jsp";
}

</script>

