<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/common.jsp" %>
<%

UserDTO dto = new UserDTO();
String uname = request.getParameter("uname");
String uemail = request.getParameter("uemail");
String uid = request.getParameter("uid");

if(uid == null || uid == "")
{
	if(uname == null || uname == "")
	{
		out.print("00");
		return;
	}
	if(dto.findPWEmail(uname,uemail) == true)
	{
		out.print("01");
	}else
	{
		out.print("02");
	}
}else if(uname == null || uname == "")
{
	
	if(uid == null || uid == "")
	{
		out.print("00");
		return;
	}
	if(dto.findPWok(uid,uemail) == true)
	{
		out.print("01");
	}else
	{
		out.print("02");
	}
}
%>