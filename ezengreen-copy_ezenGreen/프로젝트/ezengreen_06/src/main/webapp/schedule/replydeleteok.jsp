<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%

String rno     = request.getParameter("rno");
String bno     = request.getParameter("no");
String bkind   = request.getParameter("kind");
String year    = request.getParameter("year");
String month   = request.getParameter("month");
String day     = request.getParameter("day");

ReplyDTO rdto = new ReplyDTO();
rdto.Delete(rno);
%>        
<script>
window.onload = function()
{
	alert("삭제 되었습니다");
	
	<%-- window.location.href = "view.jsp?no=<%= bno %>&kind=<%= bkind %>"; --%>
	window.location.href = "view.jsp?no=<%=bno%>&year=<%=year%>&month=<%=month%>&day=<%=day%>";

}
</script>