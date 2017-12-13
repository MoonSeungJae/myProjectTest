<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="com.sist.dao.*"%>
<%
	String no = request.getParameter("no");
	String pwd = request.getParameter("pwd");

	BoardDAO dao = new BoardDAO();
	// 연동 => delete 요청
	boolean bCheck = dao.boardDelete(Integer.parseInt(no), pwd);
	// 화면이동
	if (bCheck == true) {
		response.sendRedirect("list.jsp");
	} else {
		%>
		<script>
		alert("비밀번호가 틀립니다");
		history.back();
		</Script>
	<%
	}
%>