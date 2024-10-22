<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %> 
<%
request.setCharacterEncoding("UTF-8");

String bno     = request.getParameter("no");
String bkind   = request.getParameter("kind");
String rcontent   = request.getParameter("replyText");
rcontent        = rcontent.replace("<", "&lt;").replace(">", "&gt;");
String year     = request.getParameter("year");
String month    = request.getParameter("month");
String day      = request.getParameter("day");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
ReplyVO rvo = new ReplyVO();
rvo.setBno(bno);
rvo.setUno(login.getUno());
rvo.setRcontent(rcontent);

ReplyDTO rdto = new ReplyDTO();
rdto.Insert(rvo);

%>
<script>
window.onload = function()
{
	alert("댓글작성 되었습니다");
	
	window.location.href = "view.jsp?no=<%=bno%>&year=<%=year%>&month=<%=month%>&day=<%=day%>";
}
</script>