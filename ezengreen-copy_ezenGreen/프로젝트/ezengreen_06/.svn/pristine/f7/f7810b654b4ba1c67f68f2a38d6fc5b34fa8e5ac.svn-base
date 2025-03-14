<%@ page language="java" contentType="image/jpeg; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.*" %>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="nl.captcha.Captcha" %>
<%@page import="nl.captcha.Captcha.Builder" %>
<%@page import="nl.captcha.backgrounds.FlatColorBackgroundProducer" %>
<%@page import="java.awt.Color" %>
<%@page import="java.io.*" %>

<%
//자동등록방지 코드를 이미지로 출력한다.
Captcha mCaptcha;
Builder mBuilder;
String  mAnswer;

mBuilder= new Captcha.Builder(160, 50);
mBuilder.addText();
mBuilder.addBackground(new FlatColorBackgroundProducer(Color.WHITE));
mBuilder.addBorder();
mBuilder.addNoise();
mCaptcha = mBuilder.build();
mAnswer = mCaptcha.getAnswer();

OutputStream mOut = response.getOutputStream();
ImageIO.write(mCaptcha.getImage(),"jpg", mOut);
mOut.close();

request.getSession().setAttribute("sign",mAnswer);
%>

   