<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.dao.*" %>
    <%
     request.setCharacterEncoding("EUC-KR");
    String name = request.getParameter("name");
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	String pwd = request.getParameter("pwd");
	String no = request.getParameter("no");
	// DB���� => insert ��û
	// ȭ���̵�
	BoardDAO dao = new BoardDAO();
	BoardVO vo = new BoardVO();
	vo.setNo(Integer.parseInt(no));
	vo.setName(name);
	vo.setSubject(subject);
	vo.setContent(content);
	vo.setPwd(pwd);
	
	//DAO����
	boolean bCheck=dao.boardUpdate(vo);
	//�̵� sendRedirect()
	if(bCheck==true){
		response.sendRedirect("content.jsp?no="+no);
	}else {
%>
		
		<script>
		alert("��й�ȣ�� Ʋ���ϴ�!!");
		history.back();
		</script>
		
		
		<%
	}
    %>
