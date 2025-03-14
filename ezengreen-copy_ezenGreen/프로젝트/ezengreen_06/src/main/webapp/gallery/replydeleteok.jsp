<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../../include/common.jsp" %>
<%

String rno     = request.getParameter("rno");
String bno     = request.getParameter("no");
String bkind   = request.getParameter("kind");
String nowpage = request.getParameter("page");
if(rno == null)
{
	out.println("잘못된 댓글 번호입니다.");
	return;
}

ReplyDTO rdto = new ReplyDTO();
rdto.Delete(rno);
%>        
<script>
window.onload = function()
{
	alert("삭제 되었습니다");
	
	window.location.href = "view.jsp?no="+ <%= bno %> + "&page=" + <%= nowpage %>;
}
</script>