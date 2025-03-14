<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp" %>    
<%
UserDTO dto = new UserDTO();
String person    = request.getParameter("person");

if(login.getUno() == null || person == null)
{
	out.print("00");
	return;
}
if(dto.checknowpw(login.getUno(),person) == true)
{
	out.print("01");
	return;
}
if(dto.checknowpw(login.getUno(),person) == false)
{
	out.print("02");
	return;
}
%>