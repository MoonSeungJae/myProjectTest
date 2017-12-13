
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
<%
	/*
	 list.jsp
	*/
	BoardDAO dao = new BoardDAO();
	String strPage = request.getParameter("page");
	if (strPage == null)
		strPage = "1";
	int curpage = Integer.parseInt(strPage);
	//현재페이지
	List<BoardVO> list = dao.boardListData(curpage);
	int totalpage = dao.boardTotalPage();
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
			<h3>게시판</h3>
			<table class="table">
				<tr>
					<td class="text-left"><a href="insert.jsp"
						class="btn btn-primary btn-xs">새글</a></td>
				</tr>
				<table class="table table-hover">
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
						<td width=45% class="text-left">
						<a href="content.jsp?no=<%=vo.getNo()%>"><%=vo.getSubject()%></a> 
						<%--vo.getno 는 a태그를누르면 그게시글 번호로 넘어가기 위함  --%>
						<%--vo.getSubject 는 제목글을 표시하기위한 것 --%>
						<%
 						String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
 						String dbday = vo.getRegdate().toString();
 						if (today.equals(dbday)) {
 						%> 
 						<sup><font color=red>new</font></sup> <%
 						}
						 %></td>
						<td width=15% class="text-center"><%=vo.getName()%></td>
						<td width=20% class="text-center"><%=vo.getRegdate().toString()%></td>
						<td width=10% class="text-center"><%=vo.getHit()%></td>
					</tr>

					<%
						}
					%>
				</table>
				<teble class="table">
				<tr>
					<form method="post" action="find.jsp">
					<td class="text-left">Search:<select name=fs>
							<option value="name">이름</option>
							<option value="subject">제목</option>
							<option value="content">내용</option>
					</select> 
					<input type=text class="input" size=10 name=ss> <input type=submit
						class="btn btn-warning btn-sm" value="검색">
						
					</td>
					<td><a href="list.jsp?page=<%=curpage > 1 ? curpage - 1 : curpage%>"
						class="btn btn-success btn-xs">이전</a> &nbsp; <a
						href="list.jsp?page=<%=curpage < totalpage ? curpage + 1 : curpage%>"
						class="btn btn-success btn-xs">다음</a> &nbsp;&nbsp; <%=curpage%>page
						/ <%=totalpage%> pages</td>
						</form>
				</tr>
				</teble>
				</div>
				</div>
</body>
</html>