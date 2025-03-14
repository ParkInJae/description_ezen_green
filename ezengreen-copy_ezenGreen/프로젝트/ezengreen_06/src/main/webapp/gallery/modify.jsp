<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%

String bno     = request.getParameter("no");
String kind    = request.getParameter("kind");
String nowpage = request.getParameter("page");

if(login == null)
{
	response.sendRedirect("index.jsp");
	return;
}

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}
if(kind == null) kind = "G";
if(nowpage == null) nowpage = "1";

if(kind == null)	{ kind = "S"; }

BoardDTO bdto = new BoardDTO();
BoardVO bvo = bdto.Read(bno, false);
FileDTO fdto = new FileDTO();
%>
<script>
//스마트 에디터
let oEditors = []
	
smartEitor = function()
{
 	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "content",
		sSkinURI: "../SmartEditor2/SmartEditor2Skin.html",
		fCreator: "createSEditor2",
		htParams : 
		{
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true, 
 	      }
	});
};
	
$(document).ready(function(){
	smartEitor();
	
	$(":checkbox[name=fno]").click(function(e){
		
		var total = $(":checkbox[name=fno]").length; //전체 체크박스 갯수
		var check = $(':checkbox[name=fno]:checked').length; //체크된 갯수 
		
		if(total == check)
		{
			alert("모든 첨부파일을 삭제 할 수 없습니다.");
			$(this).prop("checked",false); //체크해제
		}
	});
});

function submitPost()
{
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD",[]);
	let content = document.getElementById("content").value ;
	let title = $("#title").val();
	let fileInput = document.getElementById("attach");
	let files = fileInput.files;
		
	if(title == "")
	{
		alert("제목을 입력해주세요.");
		return false;
	} 
	if(content == "<p>&nbsp;</p>")
	{ 
		alert("내용을 입력해주세요.");
		oEditors.getById["content"].exec("FOCUS");
		return false;
	}
	
	/*
	var kind = "<%= kind %>";
	
	if(kind == "G")
	{
		if ( files.length === 0)
		{
			alert("갤러리게시판은 이미지 첨부가 필수입니다.");
			return false;
		} 
	}
	
    // 파일데이터 담기
    for (var i = 0; i < filesArr.length; i++) 
    {
        // 삭제되지 않은 파일만 폼데이터에 담기
        if (!filesArr[i].is_delete) 
        {
            formData.append("attach_file", filesArr[i]);
        }
    }
    */
	let confirmSubmit = confirm("수정하시겠습니까?");
	return confirmSubmit;
}
function cancel()
{
	let confirmSubmit = confirm("수정을 취소하시겠습니까?");
	
	if(confirmSubmit) 
	{
		history.back();
	}
	return confirmSubmit
	
}

//--------------------------------------------------------------------------------

	
	window.onload = function()
	{
		//첨부파일 추가 버튼 이벤트 리스너
		$("#btnAdd").click(function(){
			AddAttach();
		});
		
		AddAttach();
	}
	
	//첨부파일 추가
	function AddAttach()
	{
		$.ajax({
			url : "attach_mo.jsp",
			type : "get",
			dataType : "html",
			success : function(response){
				response = response.trim();
				$("#tblUpload").append(response);
			}
		});				
	}
	
	//첨부파일 삭제 
	function RemoveAttach(obj)
	{
		var tr = $(obj).parent().parent();
		tr.remove();
	}
</script>
<style>
.maintable > *
{
	font-size : 10pt;
	background-color : white;
}
</style>
<form id="select_form" name="select_form" action="modifyok.jsp?no=<%= bno %>&page=<%= nowpage %>" method="post" enctype="multipart/form-data" onsubmit="return submitPost();">
	<table border="0" width="100%" height="430px" style="text-align:center" class="maintable">
	<input type="hidden" id="bkind" name="bkind" value="G">
		<tr>
			<td colspan="5" align="left">
				<b style="float:left; font-size: 14pt; font-weight: 900;">&nbsp;갤러리 - 글수정</b>
			</td>
		</tr>
		<tr>
			<td colspan="3" height="1px">								
				<hr size="1" style="width: 99%; height: 1px; background-color: dimgrey">
			</td>
		</tr>
		<tr>
			<td width="75px">제목 :</td>
			<td colspan="4" align="left"><input type="text" id="title" name="title" style="width: 98%" value="<%= bvo.getBtitle() %>"></td>
		</tr>
		<tr>
			<td width="75px">내용 :</td>
			<td colspan="4" height="200px" align="left">
				<textarea name="content" id="content" rows="15" cols="77"><%= bvo.getBcontent() %></textarea>
			</td>	                			
		</tr>
		<tr>
			<td style="font-size:10pt" width="75px"><input type="button" id="btnAdd" name="btnAdd" value="파일추가"></td> 
			<td id="tblUpload" style="text-align: left;"></td>   				
		</tr>
		<tr>
			<td style="font-size: 9pt;">기존 파일</td>
			<td colspan="4" align="left">
				<table border="0" style="width:100%;background-color:#cccccc" cellpadding="3" cellspacing="1">
					<tr style="background-color:#f4f4f4;">
						<th style="width:50px;">삭제</th>
						<th>파일명</th>
					</tr>
					<%
					ArrayList<FileVO> list = fdto.FileRead(bno);

					for(FileVO item : list)
					{	
						%>
						<tr style="background-color:white;">
							<td align="center"><input type="checkbox" id="fno" name="fno" value="<%= item.getFno() %>"></td>						
							<td align="left"><a href="down.jsp?fno=<%= item.getFno() %>"><%= item.getFname()%></a></td>
						</tr>
						<%
					}
					%>
				</table>
			</td>
		</tr>			
		<tr>
			<td colspan="10" height="50px" style="background-color:white;" align="center">
	 			<input type="submit" value="수정하기" id="writeAction_btn" style="width:80px;height:30px;">
				<input type="button" value="취소" onClick="cancel()" style="width:80px;height:30px;">
			</td>
		</tr>
	</table>
</form>
<%@ include file="include/tail.jsp" %>