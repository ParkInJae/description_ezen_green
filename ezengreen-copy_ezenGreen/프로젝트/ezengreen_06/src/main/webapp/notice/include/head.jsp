<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../../include/common.jsp" %>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이젠 그린</title>
	<link rel="stylesheet" href="../CSS/board.css">
	<script type="text/javascript" src="../SmartEditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script src="../jquery-3.7.0.js"></script>
</head>
<script>
function Mypage()
{	
	document.mypage.submit();
};
</script> 
<body>
	<table border="0" width="900px" align="center" class="outer-table">
		<tr>
			<td colspan="7">
				<a href="../index.jsp"><p style="font-size: 25pt; font-weight: bold; color: #35F385; text-shadow: 1px 1px 1.2px midnightblue; margin: 5px;">EZENGREEN</p></a>
			</td>				
		</tr>
		<tr>
			<td rowspan="3" valign="top" width="150px">
				<form name="mypage" id="mypage" method="post" action="../mypage.jsp">
					<%
					if(login == null)
					{	
						String nowpage = request.getParameter("page");
					%>
					<table border="0" width="100%">
						<tr>
							<td class="login-buttons" style="text-align:center;"><a href="../login.jsp?kind=N&page=<%= nowpage %>"><font color="#FAFBFB">로그인</font></a></td>
	                        <td class="login-buttons" style="text-align:center;"><a href="../join.jsp?kind=N&page=<%= nowpage %>"><font color="#FAFBFB">회원가입</font></a></td>
	                    </tr>
					</table>
					<% 
					}else
					{
					%>
					<table border="0" width="100%">
						<tr>
							<td class="login-buttons" colspan="2" style="font-size:9pt; text-align:center; width:30px; height:25px;"><font color="#FAFBFB">[ <%= login.getUname() %> ]님 환영합니다.</font></td>
						</tr>
						<tr>
							<td class="login-buttons" style="text-align:center; font-size:10pt; width:15px"><a href="javascript:Mypage();"><font color="#FAFBFB">마이페이지</font></a></td>
	                        <td class="login-buttons" style="text-align:center; font-size:10pt; width:15px"><a href="../logoutok.jsp"><font color="#FAFBFB">로그아웃</font></a></td>
	                    </tr>
	                </table>    	
					<% 	
					}
					%>
				</form>
			</td>	
			<td rowspan="3" width="10px"></td>	
			<td colspan="3">
				<table border="0" width="100%">
					<tr>
						<td class="menu-item-clicked" style="text-align:center;"><a href="index.jsp"><font color="#FAFBFB">공지사항</font></a></td>        
						<td class="menu-item" style="text-align:center;"><a href="../schedule/index.jsp">경기일정</a></td>
						<td class="menu-item" style="text-align:center;"><a href="../coummunity/index.jsp">자유게시판</a></td>		
						<td class="menu-item" style="text-align:center;"><a href="../gallery/index.jsp">갤러리</a></td>	
					</tr>
				</table>
			</td>
		<td rowspan="3" width="50px"></td>	<!-- 왼쪽 공백 -->
	</tr>
	<tr>		
	</tr>
      	<tr>    
       	<td align="center">
           <!-- 컨텐츠 출력되는곳 -->