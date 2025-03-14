<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/common.jsp"%>  
<%
//파일 번호
String fno = request.getParameter("fno");
//파일 정보를 조회한다.
FileDTO  fdto  = new FileDTO();
FileVO fvo = fdto.FileReadOne(fno);

if( fvo != null )
{
	response.setContentType("application/octet-stream");   
	response.setHeader("Content-Disposition","attachment; filename=" + fvo.getFname() + "");   
	String fullname = uploadPath + "\\" + fvo.getPname();
	File file = new File(fullname);
	FileInputStream fileIn = new FileInputStream(file);
	ServletOutputStream ostream = response.getOutputStream();
	
	byte[] outputByte = new byte[4096];
	//copy binary contect to output stream
	while(fileIn.read(outputByte, 0, 4096) != -1)
	{
		ostream.write(outputByte, 0, 4096);
	}
	fileIn.close();
	ostream.flush();
	ostream.close();
}
%>
