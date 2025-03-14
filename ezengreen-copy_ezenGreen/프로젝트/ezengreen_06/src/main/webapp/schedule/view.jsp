<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
String bno     = request.getParameter("no");
String kind    = request.getParameter("kind");
String year    = request.getParameter("year");
String month   = request.getParameter("month");
String day     = request.getParameter("day");

/* if(login== null)
{
	login = new UserVO();
	login.setUid("");
} */
if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
if(kind == null)	{ kind = "S"; }
BoardDTO bdto  = new BoardDTO();
BoardVO  bvo   = bdto.Read(bno, true);
ReplyDTO rdto  = new ReplyDTO();
FileDTO  fdto  = new FileDTO();
if(bvo.getRno() == null) { bvo.setRno("0"); }

/* 로그인 정보를 JS변수로 변환 */
if(login == null) 
{
    login = new UserVO(); // Assuming LoginDTO is your login object
}

%>
<style>

.maintable > *
{
	font-size : 10pt;
	background-color : white;
}

</style>
<script>

/* 자바식을 이용한 문자열을 JS 문자열로 변환 */
var date_str = 'year=<%=year%>&month=<%=month%>&day=<%=day%>';

function enterkey(event)
{
	if(window.event.keyCode==13)
	{
		reply();
	}
}

function lists()
{
	document.getElementById('view').action = 'index.jsp?'+date_str;
	document.getElementById('view').submit();
}

function modi()
{
	let confirmSubmit = confirm("수정하시겠습니까?");
	if(confirmSubmit)
	{
		document.getElementById('view').action = "modify.jsp?no=<%= bno %>&" + date_str;
		document.getElementById('view').submit();
	}
	return confirmSubmit;
}
	
function del() 
{
	let confirmSubmit = confirm("삭제하시겠습니까?");
    if (confirmSubmit) 
    {
    	document.getElementById('view').action = 'deleteok.jsp?no=<%= bno %>&'+date_str;
           document.getElementById('view').submit();
    }
    return confirmSubmit;
}

function reply() 
{
	if ( <%= login.getUname().equals("") %> ) 
    {
        alert("로그인한 유저만 댓글작성이 가능합니다.");
        return false;
    }else
    {
    	let replyText = document.getElementById('replyText').value;
      	if (replyText.trim() === "") 
      	{
           alert("댓글 내용을 입력해주세요.");
           document.getElementById('replyText').focus();
           return false;
      	}else
      	{
			let confirmSubmit = confirm("작성하시겠습니까?");
			if (confirmSubmit) 
			{
			    document.getElementById('view').action = 'replyok.jsp?no=<%= bno %>&'+date_str;
			    document.getElementById('view').submit();
			    return true;
			}
      	}
		// 확인이 false인 경우 form 제출 방지
		return false;
	}
}

function replydel(replyno, bno,year,month,day) 
{
    if (confirm("댓글을 삭제하시겠습니까?")) 
    {
        document.location = "replydeleteok.jsp?rno=" + replyno + "&no=" + bno +"&year=" + year +"&month=" + month +"&day=" + day;
    }
}

</script>
<!--  action="deleteok.jsp?no=<%=bno%>" -->
<form name="view" id="view" method="post">
    <input type="hidden" name="kind" value="<%= kind %>">
    <input type="hidden" name="no" value="<%= bno %>">
    <input type="hidden" name="year" value="<%=year%>">
	<input type="hidden" name="month" value="<%=month%>">
	<input type="hidden" name="day" value="<%=day%>">
	<table border="0" width="100%" height="430px" style="text-align:center" class="maintable">
		<tr>
			<td colspan="5" style="text-align:left; height:25px; font-size: 14pt">&nbsp;&nbsp;<%=bvo.getBtitle() %></td>
		</tr>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr>               			
		<tr class="gray">
			<td colspan="5" height="20px" style="padding: 0;">
				<table border="0" style="height:10px; width:100%; border-spacing: 0;">
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
				ArrayList<FileVO> list = fdto.FileRead(bno);
				for(FileVO item : list)
				{
				%>
				&nbsp;&nbsp;<img src="downfile.jsp?fno=<%= item.getFno() %>" class="gsize_v"><br>
					<input type="hidden" id="pna" name="pna" value="<%= item.getPname() %>">	
				<%
				}
			%>
				&nbsp;&nbsp;<%= bvo.getBcontent() %>
			</td>	
		</tr>
				<%
		if(login != null && login.getAdmin().equals("1"))
		{ 
			%>
			<tr>
				<td colspan="2" height="30px" style="font-size:10pt; text-align:left">
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
				<td style="font-size:10pt" width="12%"><input type="button" value="글수정" onClick="modi()"></td>
				<td style="font-size:10pt" width="12%"><input type="button" value="글삭제" onClick="del()"></td>
			<tr>
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
				<tr>
				<%
			}
			%>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr>
		<tr>
		<% 
		ArrayList<ReplyVO> rlist = rdto.GetList(bno);
		for (ReplyVO item : rlist)
		{
				%>
				<tr>
					<td style="font-size:10pt; width:80px"><%= item.getUname() %></td>
					<td style="font-size:10pt" colspan="3" height="20px" align="left"><%= item.getRcontent() %>
						<%
						if(login.getUno() != null && login.getUname().equals(item.getUname()) || login.getAdmin().equals("1"))
						{
							%>
							[<a href="#" onClick="replydel('<%= item.getRno() %>','<%= bno %>','<%= year %>','<%= month %>','<%= day %>')">삭제</a>]
							<%
						}
						%>
					</td>
					<td style="font-size:10pt; width:120px;"><%= item.getRwdate() %></td>
				</tr>
				<%
			
		}
		%>
		</tr>
		<tr>
			<td colspan="5" height="1px">								
				<hr size="1" style="width: 100%; height: 1px; background-color: dimgrey">
			</td>
		</tr>	                
		<tr>
			<td style="font-size:10pt; width:100px">
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
				<input type="text" id="replyText" name="replyText" onkeyup="enterkey(event);" style="width:95%" placeholder="내용을 입력해주세요.">
			</td>
			<td><input type="button" id="btnReply" value="댓글작성" onClick="reply()"></td>
		</tr>
	</table>
</form>

<%@ include file="include/tail.jsp" %>