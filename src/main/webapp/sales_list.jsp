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

String sql = "select e.custno, e.custname, e.grade, sum(o.price) from member_tbl_02 e, money_tbl_02 o where e.custno=o.custno group by e.custno, e.custname, e.grade order by sum(o.price) desc";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
ArrayList<String[]> viewList = new ArrayList<String[]>();

while(rs.next()){
	String[] view = new String[4];
	view[0] = rs.getString(1);
	view[1] = rs.getString(2);
	String grade = rs.getString(3);
	if(grade.equals("A")){
		grade = "VIP";
	}else if(grade.equals("B")){
		grade = "일반";
	}else if(grade.equals("C")){
		grade = "직원";
	}
	view[2] = grade;
	view[3] = rs.getString(4);
	viewList.add(view);
}
pstmt.close();
conn.close();
rs.close();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.title{
	text-align : center;
}
.table td {
	text-align : center;
}
.table{
	margin : auto;
}
</style>
</head>
<body>
	<jsp:include page="include/header.jsp"></jsp:include>
	<jsp:include page="include/nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">회원목록조회/수정</h3>
		<table class="table" border="1">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>고객등급</th>
				<th>매출</th>
			</tr>
			<%
				for(int i = 0; i < viewList.size(); i++){
			%>
			<tr>
				<td><%=viewList.get(i)[0] %></td>
				<td><%=viewList.get(i)[1] %></td>
				<td><%=viewList.get(i)[2] %></td>
				<td><%=viewList.get(i)[3] %></td>
			</tr>
			<% } %>
		</table>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>