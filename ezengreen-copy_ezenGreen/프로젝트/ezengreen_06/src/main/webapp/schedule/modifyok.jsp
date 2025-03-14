<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="include/head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;
MultipartRequest multi;
try
{
	multi = 
		new MultipartRequest(request,uploadPath,size,
			"UTF-8",new DefaultFileRenamePolicy());
}catch(Exception e)
{
	response.sendRedirect("index.jsp");
	return;
}


String bno      = request.getParameter("no");
String bkind    = request.getParameter("bkind");
String btitle   = multi.getParameter("title");
btitle = btitle.replace("<", "&lt;").replace(">", "&gt;");
String bcontent = multi.getParameter("content");
bcontent        = bcontent.replace("<p>", "").replace("</p>", "");
String year     = multi.getParameter("year");
String month    = multi.getParameter("month");
String day      = multi.getParameter("day");
String[] fno    = multi.getParameterValues("fno");
// bno,btitle,bcontent 유효성 체크

if(bkind == null)	{ bkind = "S"; }
BoardVO bvo = new BoardVO(bno,btitle,bcontent,bkind);
BoardDTO bdto = new BoardDTO();
// bvo에 파라메타로 받은 데이터를 넣는다

if(bdto.Update(bvo)!=false)
{
	bvo = bdto.Read(bno, false);
}
FileDTO fdto = new FileDTO();
fdto.FileRead(bvo.getBno());

//업로드된 파일명을 얻는다.
Enumeration files = multi.getFileNames();

//삭제 요청한 첨부파일을 지운다.
if( fno != null)
{
	for(String f : fno)
	{
		fdto.FileDelete(f);
	}
}
	
while(files.hasMoreElements()) 
{
	String name     = (String) files.nextElement();
	String filename = (String) multi.getFilesystemName(name);
	//첨부파일을 등록한다.
	if(filename == null)
	{ //업로드 된 파일명이 null
		continue;
	}
	
	String phyname    = UUID.randomUUID().toString();
	String srcName    = uploadPath + "/" + filename;
	String targetName = uploadPath + "/" + phyname;
	File srcFile      = new File(srcName);
	File targetFile   = new File(targetName);
	srcFile.renameTo(targetFile);

	// 첨부파일을 등록한다.		
	if(filename != null)
	{
		FileVO fvo = new FileVO();
		fvo.setBno(bvo.getBno());
		fvo.setFname(filename);
		fvo.setPname(phyname);	
		fdto.FileUpload(fvo, bvo.getBno());
	}
}
%>         
<script>
window.onload = function()
{
	alert("수정 되었습니다");
	
	window.location.href = "view.jsp?no=<%=bno%>&year=<%=year%>&month=<%=month%>&day=<%=day%>";
}
</script>