<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezengreen.dao.*" %>
<%@ page import="ezengreen.dto.*" %>
<%@ page import="ezengreen.vo.*" %>
<%@ page import="ezen.mail.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>  
<%@ page import="java.net.*" %>  
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>   

<%
//첨부파일 저장 경로
String uploadPath = "D:\\smc\\project\\ezengreen_06\\src\\main\\webapp\\img";


//데이터베이스 처리 클래스

request.setCharacterEncoding("UTF-8");

//로그인 여부를 세션을 통해 검사한다.
UserVO login = (UserVO)session.getAttribute("login");
%>