<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../../include/common.jsp" %>    
<%
String bno = request.getParameter("bno");
String nowpage = request.getParameter("page");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//본인 게시글이 맞는지 확인
BoardDTO bdto = new BoardDTO();

//게시글을 삭제한다.
bdto.Delete(bno);
%>
<script>
window.onload = function()
{
	alert("삭제 되었습니다");
	
	window.location.href = "index.jsp?page=<%= nowpage %>";
}
</script>
