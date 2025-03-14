<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="ezengreen.dto.*" %>     
<%
String uid = request.getParameter("uid");
if(uid == null || uid.equals(""))
{
	out.println("00");
	return;
}
UserDTO dto = new UserDTO();
if( dto.CheckID(uid) == true)
{
	//중복된 ID
	out.println("01");
	System.out.println("01");
}else
{
	//등록 가능한 ID
	out.println("02");
	System.out.println("02");
}
%>
