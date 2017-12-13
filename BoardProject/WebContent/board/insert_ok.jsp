<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="com.sist.dao.*"%>
<%--
    	web
    	 => JSP(Model1) => MVC (Model2) => Framework(Spring)
    	 				  =============
    	 => JDBC => DBCP => ORM(MyBatis)
    	 				   =============
     --%>
<%
	request.setCharacterEncoding("EUC-KR"); // 한글번역먼저
	String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pwd = request.getParameter("pwd");
	// DB연동 => insert 요청
	// 화면이동
	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();
	vo.setName(name);
	vo.setSubject(subject);
	vo.setContent(content);
	vo.setPwd(pwd);
	dao.boardInsert(vo);
	response.sendRedirect("list.jsp");
%>