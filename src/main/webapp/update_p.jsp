<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Connection conn = null;

String url = "jdbc:oracle:thin:@localhost:1521:xe";
String id = "system";
String pw = "1234";

try{
	Class.forName("oracle.jdbc.OracleDriver");
	conn = DriverManager.getConnection(url, id, pw);
	System.out.println("DB 접속");
}catch(Exception e){
	e.printStackTrace();
}

request.setCharacterEncoding("UTF-8");
String sql = "update member_tbl_02 set custname=?, phone=?, address=?, joindate=?, grade=?, city=? where custno="+Integer.parseInt(request.getParameter("custno"));

PreparedStatement pstmt = conn.prepareStatement(sql);

pstmt.setString(1, request.getParameter("custname"));
pstmt.setString(2, request.getParameter("phone"));
pstmt.setString(3, request.getParameter("address"));
pstmt.setString(4, request.getParameter("joindate"));
pstmt.setString(5, request.getParameter("grade"));
pstmt.setString(6, request.getParameter("city"));

pstmt.executeUpdate();

pstmt.close();
conn.close();

response.sendRedirect("member_list.jsp");
%>
