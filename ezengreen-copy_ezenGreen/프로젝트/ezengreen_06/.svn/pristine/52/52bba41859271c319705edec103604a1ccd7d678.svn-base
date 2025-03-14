<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
String bno = request.getParameter("no");
String year     = request.getParameter("year");
String month    = request.getParameter("month");
String day      = request.getParameter("day");
if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
BoardDTO bdto = new BoardDTO();
BoardVO  vo   = bdto.Read(bno, false);
if(!login.getUno().equals(vo.getUno()))
{
	response.sendRedirect("index.jsp");
	return;	
}

//게시글을 삭제한다.
bdto.Delete(bno);
%>
<script>
window.onload = function()
{
	alert("삭제 되었습니다");
	
	window.location.href = "index.jsp?year=<%=year%>&month=<%=month%>&day=<%=day%>";
}
</script>