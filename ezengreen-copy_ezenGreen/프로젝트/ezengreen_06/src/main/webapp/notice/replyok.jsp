<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %> 
<%

request.setCharacterEncoding("UTF-8");

String bno     = request.getParameter("bno");
String bkind   = request.getParameter("kind");
String rcontent   = request.getParameter("replyText");
String nowpage   = request.getParameter("page");
rcontent        = rcontent.replace("<", "&lt;").replace(">", "&gt;");

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
//댓글을 저장한다.
rdto.Insert(rvo);

%>
<script>
window.onload = function()
{
	alert("댓글작성 되었습니다");
	
	window.location.href = "view.jsp?no="+ <%= bno %> + "&page=<%= nowpage %>";
}
</script>
