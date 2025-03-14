<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>         
<%
String bno = request.getParameter("bno");
String nowpage = request.getParameter("page");
String bkind = request.getParameter("kind");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
// 게시글 삭제 DTO
BoardDTO bdto 	= new BoardDTO();
//본인의 게시물이 맞는지 유효성 검사 .
BoardVO bvo 	= bdto.Read(bno, false);
if(login == null || !login.getUno().equals(bvo.getUno())) {
    response.sendRedirect("index.jsp");
    return;
}
bdto.Delete(bno);
%>
<script>
window.onload = function()
{
	alert("삭제 되었습니다");
	
	window.location.href = "index.jsp?page=<%= nowpage %>"; 
}
</script>