<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.dao.*" %>
    <%
     request.setCharacterEncoding("EUC-KR");
    String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pwd = request.getParameter("pwd");
	String no = request.getParameter("no");
	// DB연동 => insert 요청
	// 화면이동
	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();
	vo.setNo(Integer.parseInt(no));
	vo.setName(name);
	vo.setSubject(subject);
	vo.setContent(content);
	vo.setPwd(pwd);
	
	//DAO연결
	boolean bCheck=dao.boardUpdate(vo);
	//이동 sendRedirect()
	if(bCheck==true){
		response.sendRedirect("content.jsp?no="+no);
	}else {
%>
		
		<script>
		alert("비밀번호가 틀립니다!!");
		history.back();
		</script>
		
		
		<%
	}
    %>
