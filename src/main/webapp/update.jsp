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

String sql = "select custno, custname, phone, address, to_char(joindate, 'yyyymmdd'), grade, city from member_tbl_02 where custno="+Integer.parseInt(request.getParameter("custno"));

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
String[] view = new String[7];

if(rs.next()){
	view[0] = rs.getString(1);
	view[1] = rs.getString(2);
	view[2] = rs.getString(3);
	view[3] = rs.getString(4);
	view[4] = rs.getString(5);
	view[5] = rs.getString(6);
	view[6] = rs.getString(7);
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
<script type="text/javascript">
	function checkVal(){
		if(!document.u_data.custname.value){
			alert("이름을 입력하세요!");
			document.u_data.custname.focus();
			return false;
		}else if(!document.u_data.phone.value){
			alert("전화번호를 입력하세요!");
			document.u_data.phone.focus();
			return false;
		}else if(document.getElementsByName("address")[0].checked == false &&
				document.getElementsByName("address")[1].checked == false &&
				document.getElementsByName("address")[2].checked == false){
			alert("통신사를 선택하세요!");
			return false;
		}else if(!document.u_data.joindate.value){
			alert("가입일자를 입력하세요!");
			document.u_data.joindate.focus();
			return false;
		}else if(!document.u_data.grade.value){
			alert("고객등급을 입력하세요!");
			document.u_data.grade.focus();
			return false;
		}else if(!document.u_data.city.value){
			alert("도시코드를 입력하세요!");
			document.u_data.city.focus();
			return false;
		}else{
			alert("회원정보수정이 완료되었습니다!");
			document.getElementById("u_data").submit();
		}
	}
</script>
</head>
<body>
	<jsp:include page="include/header.jsp"></jsp:include>
	<jsp:include page="include/nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">회원목록조회/수정</h3>
		<form id="u_data" name="u_data" method="post" action="update_p.jsp" onsubmit="return false">
			<table class="table" border="1">
				<tr>
					<th>회원번호(자동발생)</th>
					<td>
						<input type="text" name="custno" value="<%=view[0] %>" readonly>
					</td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td>
						<input type="text" name="custname" value="<%=view[1] %>">
					</td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td>
						<input type="text" name="phone" value="<%=view[2] %>">
					</td>
				</tr>
				<tr>
					<th>통신사</th>
					<td>
						<%if(view[3].equals("SK")){ %>
							<input type="radio" name="address" value="SK" checked>SK
						<%}else { %>
							<input type="radio" name="address" value="SK">SK	
						<% } %>
						<%if(view[3].equals("KT")){ %>
							<input type="radio" name="address" value="KT" checked>KT
						<%}else { %>
							<input type="radio" name="address" value="KT">KT	
						<% } %>
						<%if(view[3].equals("LG")){ %>
							<input type="radio" name="address" value="LG" checked>LG
						<%}else { %>
							<input type="radio" name="address" value="LG">LG	
						<% } %>
					</td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td>
						<input type="text" name="joindate" value="<%=view[4] %>">
					</td>
				</tr>
				<tr>
					<th>고객등급[A:VIP,B:일반,C:직원]</th>
					<td>
						<input type="text" name="grade" value="<%=view[5] %>">
					</td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td>
						<input type="text" name="city" value="<%=view[6] %>">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button onclick="checkVal()">수정</button>
						<button onclick="location.href='member_list.jsp'">조회</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>