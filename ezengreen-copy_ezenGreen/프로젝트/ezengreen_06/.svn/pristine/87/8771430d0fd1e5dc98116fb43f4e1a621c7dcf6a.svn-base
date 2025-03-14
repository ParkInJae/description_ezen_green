<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%

request.setCharacterEncoding("utf-8");

String uid     = request.getParameter("uid");
String upw     = request.getParameter("upw");
String uname   = request.getParameter("uname");
String uemail  = request.getParameter("umail");

if( uid == null || upw == null )
{
	//회원가입 정보가 올바르게 전송되지 않음.
	response.sendRedirect("join.jsp");
	return;
}

UserDTO dto = new UserDTO();
if(dto.CheckID(uid) == true)
{
	%>
	<script>
		alert("사용할수 없는 아이디입니다");
		 window.location.href = "join.jsp";
	</script>
	<%
}else
{
	//UserVO에 값을 설정한다.
	UserVO vo = new UserVO();
	vo.setUid(uid);
	vo.setUpw(upw);
	vo.setUname(uname);
	vo.setUemail(uemail);
	
	//회원가입을 진행한다.
	dto.Join(vo);
}
%>
<script>
window.onload = function()
{
	alert("회원가입이 완료되었습니다");
	
	window.location.href = "login.jsp";
}
</script>
