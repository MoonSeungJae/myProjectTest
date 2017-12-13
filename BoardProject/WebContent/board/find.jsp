
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
	String fs=request.getParameter("fs");
	String ss= request.getParameter("ss");
	BoardDAO dao = new BoardDAO();
	List<BoardVO> list = dao.boardFindData(fs, ss);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style type="text/css">
.row {
	margin: 0px auto;
	width: 650px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3>검색 결과</h3>
			<table class="table">
				<tr>
					<td class="text-left"><a href="list.jsp"
						class="btn btn-primary btn-xs">목록</a>
						</td>
				</tr>
			</table>
			<table class="table table-hover">
			<%
				if(list.size()>0){
					
				
			%>
				<tr class="info">
					<th width=10% class="text-center">번호</th>
					<th width=45% class="text-center">제목</th>
					<th width=15% class="text-center">이름</th>
					<th width=20% class="text-center">작성일</th>
					<th width=10% class="text-center">조회수</th>
				</tr>
				<%
					for (BoardVO vo : list) {
				%>
				<tr>
					<td width=10% class="text-center"><%=vo.getNo()%></td>
					<td width=45% class="text-left"><a
						href="content.jsp?no=<%=vo.getNo()%>"><%=vo.getSubject()%></a> <%
 	String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
 		String dbday = vo.getRegdate().toString();
 		if (today.equals(dbday)) {
 %> <sup><font color=red>new</font></sup> <%
 	}
 %></td>
					<td width=15% class="text-center"><%=vo.getName()%></td>
					<td width=20% class="text-center"><%=vo.getRegdate().toString()%></td>
					<td width=10% class="text-center"><%=vo.getHit()%></td>
				</tr>

				<%
					}
				}else{
					%>
					<tr>
					 <td class="text-center">
					 검색결과가 없습니다.
					 </td>
					</tr>
					<% 
				}
				%>
			</table>

		</div>
	</div>
</body>
</html>