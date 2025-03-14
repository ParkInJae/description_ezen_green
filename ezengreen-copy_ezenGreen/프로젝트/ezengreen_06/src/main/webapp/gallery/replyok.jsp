<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../../include/common.jsp" %>   
<%
String bno     = request.getParameter("bno");
String bkind   = request.getParameter("kind");
String rcontent   = request.getParameter("replyText");
String nowpage   = request.getParameter("page");
rcontent        = rcontent.replace("<", "&lt;").replace(">", "&gt;");
if(bno == null)
{
	out.println("게시물 번호 오류입니다.");
	return;
}

ReplyVO rvo = new ReplyVO();
rvo.setBno(bno);
rvo.setUno(login.getUno());
rvo.setRcontent(rcontent);

ReplyDTO rdto = new ReplyDTO();
rdto.Insert(rvo);

out.println("댓글 등록이 완료되었습니다.");
%>
<script>
window.onload = function()
{
	alert("댓글작성 되었습니다");
	
	window.location.href = "view.jsp?no="+ <%= bno %> + "&page=<%= nowpage %>";
}
</script>