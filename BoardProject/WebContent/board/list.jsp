
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
	//����������
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
			<h3>�Խ���</h3>
			<table class="table">
				<tr>
					<td class="text-left"><a href="insert.jsp"
						class="btn btn-primary btn-xs">����</a></td>
				</tr>
				<table class="table table-hover">
					<tr class="info">
						<th width=10% class="text-center">��ȣ</th>
						<th width=45% class="text-center">����</th>
						<th width=15% class="text-center">�̸�</th>
						<th width=20% class="text-center">�ۼ���</th>
						<th width=10% class="text-center">��ȸ��</th>
					</tr>
					<%
						for (BoardVO vo : list) {
					%>
					<tr>
						<td width=10% class="text-center"><%=vo.getNo()%></td>
						<td width=45% class="text-left">
						<a href="content.jsp?no=<%=vo.getNo()%>"><%=vo.getSubject()%></a> 
						<%--vo.getno �� a�±׸������� �װԽñ� ��ȣ�� �Ѿ�� ����  --%>
						<%--vo.getSubject �� ������� ǥ���ϱ����� �� --%>
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
							<option value="name">�̸�</option>
							<option value="subject">����</option>
							<option value="content">����</option>
					</select> 
					<input type=text class="input" size=10 name=ss> <input type=submit
						class="btn btn-warning btn-sm" value="�˻�">
						
					</td>
					<td><a href="list.jsp?page=<%=curpage > 1 ? curpage - 1 : curpage%>"
						class="btn btn-success btn-xs">����</a> &nbsp; <a
						href="list.jsp?page=<%=curpage < totalpage ? curpage + 1 : curpage%>"
						class="btn btn-success btn-xs">����</a> &nbsp;&nbsp; <%=curpage%>page
						/ <%=totalpage%> pages</td>
						</form>
				</tr>
				</teble>
				</div>
				</div>
</body>
</html>