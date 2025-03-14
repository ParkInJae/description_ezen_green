<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
session.setAttribute("login", null);
%>	

<script>
window.onload = function()
{
	var referrer = document.referrer;
	alert("로그아웃 되었습니다");
	window.location.href=referrer;
}
</script>