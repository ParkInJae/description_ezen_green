<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String uname  = request.getParameter("uname");
String uemail = request.getParameter("uemail");

//1.  uid, uemail이 맞는지 유효성을 검사
if(uname == null || uemail==null )
{
	response.sendRedirect("login.jsp");
	return;
}
UserDTO dto = new UserDTO();
UserVO vo = dto.findIDok(uname, uemail);

if(vo == null)
{
    // 아이디를 찾지 못한 경우
    %>
    <script>
        alert("존재하지 않는 아이디입니다.");
        window.location.href = "join.jsp";
    </script>
    <%
}else
{
    // 아이디를 찾은 경우
    %>
    <script>
        alert("회원님의 아이디는 <%= vo.getUid() %>입니다.");
        window.location.href = "login.jsp";
    </script>
    <%
}
%>