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

String sql = "select max(custno) from member_tbl_02";

PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

int num = 0;
if(rs.next()){
	num = Integer.parseInt(rs.getString(1)) + 1;
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
		if(!document.data.custname.value){
			alert("이름을 입력하세요!");
			document.data.custname.focus();
			return false;
		}else if(!document.data.phone.value){
			alert("전화번호를 입력하세요!");
			document.data.phone.focus();
			return false;
		}else if(document.getElementsByName("address")[0].checked == false &&
				document.getElementsByName("address")[1].checked == false &&
				document.getElementsByName("address")[2].checked == false){
			alert("통신사를 선택하세요!");
			return false;
		}else if(!document.data.joindate.value){
			alert("가입일자를 입력하세요!");
			document.data.joindate.focus();
			return false;
		}else if(!document.data.grade.value){
			alert("고객등급을 입력하세요!");
			document.data.grade.focus();
			return false;
		}else if(!document.data.city.value){
			alert("도시코드를 입력하세요!");
			document.data.city.focus();
			return false;
		}else{
			alert("회원등록이 완료되었습니다.");
			document.getElementById("data").submit();
		}
	}
</script>
</head>
<body>
	<jsp:include page="include/header.jsp"></jsp:include>
	<jsp:include page="include/nav.jsp"></jsp:include>
	<div class="section">
		<h3 class="title">회원목록조회/수정</h3>
		<form id="data" name="data" method="post" action="join_p.jsp" onsubmit="return false">
			<table class="table" border="1">
				<tr>
					<th>회원번호(자동발생)</th>
					<td>
						<input type="text" name="custno" value="<%=num %>" readonly>
					</td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td>
						<input type="text" name="custname">
					</td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td>
						<input type="text" name="phone">
					</td>
				</tr>
				<tr>
					<th>통신사</th>
					<td>
						<input type="radio" name="address" value="SK">SK
						<input type="radio" name="address" value="KT">KT
						<input type="radio" name="address" value="LG">LG
					</td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td>
						<input type="text" name="joindate">
					</td>
				</tr>
				<tr>
					<th>고객등급[A:VIP,B:일반,C:직원]</th>
					<td>
						<input type="text" name="grade">
					</td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td>
						<input type="text" name="city">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button onclick="checkVal()">등록</button>
						<button onclick="location.href='member_list.jsp'">조회</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="include/footer.jsp"></jsp:include>
</body>
</html>