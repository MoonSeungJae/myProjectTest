<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="com.sist.dao.*"%>
<%
	String no = request.getParameter("no");
	String pwd = request.getParameter("pwd");

	BoardDAO dao = new BoardDAO();
	// ���� => delete ��û
	boolean bCheck = dao.boardDelete(Integer.parseInt(no), pwd);
	// ȭ���̵�
	if (bCheck == true) {
		response.sendRedirect("list.jsp");
	} else {
		%>
		<script>
		alert("��й�ȣ�� Ʋ���ϴ�");
		history.back();
		</Script>
	<%
	}
%>