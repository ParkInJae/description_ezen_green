<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
String bno     = request.getParameter("no");
String kind    = request.getParameter("kind");
String nowpage = request.getParameter("page");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
if(kind == null)	{ kind = "C"; }
if(nowpage == null)	{ nowpage = "1"; }

//게시물 정보를 조회한다.
BoardDTO bdto  = new BoardDTO();
BoardVO  bvo   = bdto.Read(bno, true);
if(bvo.getRno() == null) { bvo.setRno("0"); }

if(login == null) 
{
    login = new UserVO(); 
}
%>
<script>
function enterkey(event)
{
	if(window.event.keyCode == 13)
	{
		reply();
    }
}

function lists()
{
	document.getElementById('view').action = 'index.jsp?page=<%= nowpage %>';
	document.getElementById('view').submit();
}


function modi()
{
	if( <%= bvo.getUname().equals(login.getUname()) %> )
	{	
		let confirmSubmit = confirm("수정하시겠습니까?");
		if(confirmSubmit) 
		{
			document.getElementById('view').action = "modify.jsp?no=<%= bno %>&page=<%= nowpage %>";
			document.getElementById('view').submit();
		}
		return confirmSubmit
	}else
	{	
		alert("글 수정 권한이 없습니다.");
		return false;
	}
}

function del()
{	
	if( <%= bvo.getUname().equals(login.getUname()) %> || <%= login.getAdmin().equals("1") %>)
	{	
		let confirmSubmit = confirm("삭제하시겠습니까?");
		
		if(confirmSubmit) 
		{
	        document.getElementById('view').action = 'deleteok.jsp?page=<%= nowpage %>';
	        document.getElementById('view').submit();
		}
		return confirmSubmit
	}else
	{	
		alert("글 삭제 권한이 없습니다.");
		return false;
	}
}
function reply() 
{

    if ( <%= login.getUname().equals("") %> ) 
    {
        alert("로그인한 유저만 댓글작성이 가능합니다.");
        return false;
    }
    else
    {
        let replyText = document.getElementById('replyText').value;
        if (replyText.trim() === "") {
            alert("댓글 내용을 입력해주세요.");
            document.getElementById('replyText').focus();
            return false;
        }
        let confirmSubmit = confirm("작성하시겠습니까?");
        if (confirmSubmit) {
            document.getElementById('view').action = 'replyok.jsp?page=<%= nowpage %>';
            document.getElementById('view').submit();
            return true;
        }
        // 확인이 false인 경우 form 제출 방지
        return false;
    }
}

function replydel(replyno,bno,nowpage)
{
	if(confirm("댓글을 삭제하시겠습니까?"))
	{
		document.getElementById('view').action = "replydeleteok.jsp?rno=" + replyno + "&no=" + bno + "&page=<%= nowpage %>";
		document.getElementById('view').submit();
	}
}
</script>
<style>

.maintable > *
{
	font-size : 10pt;
	background-color : white;
}

</style>
<form name="view" id="view" method="post">
	<input type="hidden" name="bno" value="<%= bno %>">
    <input type="hidden" name="kind" value="<%= kind %>">
    <input type="hidden" name="page" value="<%= nowpage %>">
	<table border="0" width="100%" height="430px" style="text-align:center" class="maintable">
		<tr>
			<td colspan="5" align="left" height="25px" style="font-size: 14pt;">&nbsp;&nbsp;<%= bvo.getBtitle() %></td>
		</tr>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr> 	                
		<tr class="gray">
			<td colspan="5" height="20px" style="padding: 0;">
				<table border="0" style="width:100%; border-spacing: 0;">
					<tr>
						<td class="asd" width="80px" style="text-align:left;">&nbsp;&nbsp;<%= bvo.getUname() %></td>
						<td class="asd" colspan="2" style="text-align:right;"><%= bvo.getBwdate() %></td>
						<td class="asd" width="90px" style="text-align:right;">조회수 <%= bvo.getBhit() %></td>
						<td class="asd" width="70px" style="text-align:center;">댓글 <%= bvo.getRno() %></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr>
		<tr>
			<td colspan="5" height="250px" align="left" style="vertical-align: top;">
			<%
			FileDTO  fdto  = new FileDTO();
			ArrayList<FileVO> list = fdto.FileRead(bvo.getBno());
		
			for( FileVO file : list )
			{	
				%>
				<br>&nbsp;&nbsp;<img src="downfile.jsp?fno=<%= file.getFno() %>" class="gsize_v"><br>
				<input type="hidden" id="pna" name="pna" value="<%= file.getPname() %>">
				<%	
			}
			%>
			<br>&nbsp;&nbsp;<%= bvo.getBcontent() %>
			</td>	
		</tr>
		<%
		if( bvo.getUname().equals(login.getUname()) || login.getAdmin().equals("1") )
		{ 
			%>
			<tr>
				<td colspan="2" height="30px" style="font-size:10pt; text-align:left">
					<%
					if( list.size() != 0)
					{
						%>
						&nbsp;&nbsp; 첨부파일 :
						<%
						for( FileVO file : list )
						{	
							%>
							<a href="downfile.jsp?fno=<%= file.getFno() %>"><%= file.getFname() %></a>&nbsp;&nbsp;
							<%	
						}	
					}
					%>
				</td>
				<td style="font-size:10pt" width="12%"><input type="button" value="글목록" onClick="lists()"></td>
				<td style="font-size:10pt" width="12%"><input type="button" value="글수정" onClick="modi()"></td>
				<td style="font-size:10pt" width="12%"><input type="button" value="글삭제" onClick="del()"></td>
			</tr>
				<%
		}else
		{
			%>
			<tr>
				<td colspan="4" height="30px" style="font-size:10pt; text-align:left">
					&nbsp;&nbsp;첨부파일 :
					<%
						if( list == null || list.size() == 0 )
						{
							%>
							첨부파일이 없습니다.
							<%
						}
						
						for( FileVO file : list )
						{	
							%>
							<a href="downfile.jsp?fno=<%= file.getFno() %>"><%= file.getFname() %></a>&nbsp;&nbsp;
							<%	
						}	
					%>
				</td>
				<td style="font-size:10pt" width="12%"><input type="button" value="글목록" onClick="lists()"></td>
			</tr>
			<%
		}
		%>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr>
		<% 
		ReplyDTO rdto  = new ReplyDTO();
		ArrayList<ReplyVO> rlist = rdto.GetList(bno);
		for (ReplyVO repl : rlist)
		{
		%>
			<tr>
				<td style="font-size:10pt; width:80px; height:25px;"><%= repl.getUname() %></td>
				<td style="font-size:10pt" colspan="3" align="left"><%= repl.getRcontent() %>
					<%
						if(login.getUno() != null && login.getUname().equals(repl.getUname()) || login.getAdmin().equals("1"))
						{
							%>
							[<a href="#" onClick="replydel('<%= repl.getRno() %>','<%= bno %>')">삭제</a>]
							<%
						}
					%>
				</td>
				<td style="font-size:10pt; width:120px;"><%= repl.getRwdate() %></td>
			</tr>
		<%
		}
		%>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr>	                
		<tr>
			<td width="100px" height="20px" style="font-size:10pt;">
	        	<%
		        if(login == null || login.getUid().equals(""))
				{
					%>
					GUEST 
					<%
				}else
		        {
			        %>
			        	<%= login.getUname() %>
			        <%
		        }
	        	%>
			</td>
			<td colspan="3">
				<input type="text" id="replyText" name="replyText" onkeyup="enterkey(event)" style="width:98%" placeholder="내용을 입력해주세요.">
			</td>
			<td><input type="button" value="댓글작성" onClick="reply()"></td>
		</tr>
	</table>
</form>
<%@ include file="include/tail.jsp" %>
