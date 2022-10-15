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

String sql = "select custno, custname, phone, address, to_char(joindate, 'yyyymmdd'), grade, city from member_tbl_02";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
ArrayList<String[]> viewList = new ArrayList<String[]>();

while(rs.next()){
	String[] view = new String[7];
	view[0] = rs.getString(1);
	view[1] = rs.getString(2);
	view[2] = rs.getString(3);
	view[3] = rs.getString(4);
	String joindate = rs.getString(5);
	String join = joindate.substring(0, 4);
	join += "년";
	join += joindate.substring(4, 6);
	join += "월";
	join += joindate.substring(6, joindate.length());
	join += "일";
	view[4] = join;
	String grade = rs.getString(6);
	if(grade.equals("A")){
		grade = "VIP";
	}else if(grade.equals("B")){
		grade = "일반";
	}else if(grade.equals("C")){
		grade = "직원";
	}
	view[5] = grade;
	String city = rs.getString(7);
	if(city.equals("01")){
		city = "서울";
	}else if(city.equals("10")){
		city = "인천";
	}else if(city.equals("20")){
		city = "성남";
	}else if(city.equals("30")){
		city = "대전";
	}else if(city.equals("40")){
		city = "광주";
	}else if(city.equals("60")){
		city = "부산";
	}
	view[6] = city;
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
				<th>전화번호</th>
				<th>통신사</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
			<%
				for(int i = 0; i < viewList.size(); i++){
			%>
			<tr>
				<td>
				<a href="update.jsp?custno=<%=viewList.get(i)[0] %>"><%=viewList.get(i)[0] %></a>
				</td>
				<td><%=viewList.get(i)[1] %></td>
				<td><%=viewList.get(i)[2] %></td>
				<td><%=viewList.get(i)[3] %></td>
				<td><%=viewList.get(i)[4] %></td>
				<td><%=viewList.get(i)[5] %></td>
				<td><%=viewList.get(i)[6] %></td>
			</tr>
			<% } %>
		</table>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>