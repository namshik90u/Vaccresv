<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB 연동</title>
</head>

<form action="vcjjyyjh.jsp">
<%
	String RESVNO = request.getParameter("RESVNO");
%>
<style>
	h1{
		text-align:center;
	}
	table{
		margin:Auto;
		Text-align:Center;
	}
</style>

<body>

	<h1>예약번호: <%=RESVNO %>의 접종예약조회</h1>
<table border="1">
	<tr>
		<td>이름</td>
		<td>주민번호</td>
		<td>성별</td>
		<td>전화번호</td>
		<td>예약일자</td>
		<td>예약시간</td>
		<td>병원명</td>
		<td>대표전화</td>
		<td>병원주소</td>
		<td>백신종류</td>
	</tr>
	<% /* 자바 DB 연동 프로그램 */
	if(RESVNO != null && !RESVNO.isEmpty()){
		try{
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe","system","1234");
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT M.PNAME,M.JUMIN,DECODE(SUBSTR(M.JUMIN, 8, 1), '1', '남', '여'),M.TEL, V.RESVDATE,V.RESVYIME,DECODE(V.HOSPCODE,'H001','가-병원','H002','나-병원','다-병원'),DECODE(V.HOSPCODE,'H001','1588-0001','H002','1555-1555','1333-1333'),DECODE(V.HOSPCODE,'H001','서울','H002','대전','대구'),DECODE(V.VCODE,'V001','가 백신','V002','나 백신','다 백신')FROM member_tbl M, vaccresv_tbl V WHERE M.JUMIN=V.JUMIN AND V.resvno='" + RESVNO + "' GROUP BY M.PNAME,	M.JUMIN,DECODE(SUBSTR(M.JUMIN, 8, 1), '1', '남', '여'),M.TEL,	V.RESVDATE,	V.RESVYIME,	DECODE(V.HOSPCODE,'H001','가-병원','H002','나-병원','다-병원'),DECODE(V.HOSPCODE,'H001','1588-0001','H002','1555-1555','1333-1333'),DECODE(V.HOSPCODE,'H001','서울','H002','대전','대구'),DECODE(V.VCODE,'V001','가 백신','V002','나 백신','다 백신')");
			if(rs.next()){
				out.println("<tr>");
				out.println("<td>" + rs.getString(1) + "</td>");
				out.println("<td>" + rs.getString(2) + "</td>");
				out.println("<td>" + rs.getString(3) + "</td>");
				out.println("<td>" + rs.getString(4) + "</td>");
				out.println("<td>" + rs.getString(5) + "</td>");
				out.println("<td>" + rs.getString(6) + "</td>");
				out.println("<td>" + rs.getString(7) + "</td>");
				out.println("<td>" + rs.getString(8) + "</td>");
				out.println("<td>" + rs.getString(9) + "</td>");
				out.println("<td>" + rs.getString(10) + "</td>");
				out.println("</tr>");
						}
			else{
				response.sendRedirect("vcjjyyjh3.jsp");
			}	
			stmt.close();
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	else{
		response.sendRedirect("vcjjyyjh3.jsp");
	}
	%>
	</table>
	<div>
		<p><button>돌아가기</button></p>
	</div>
</body>
</form>
</html>