<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
<%
	// content.jsp?no=2
	String no = request.getParameter("no");
	BoardDAO dao = new BoardDAO();
	BoardVO vo = dao.boardContentData(Integer.parseInt(no));
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
<script type="text/javascript">
	var i = 0;
	$(function() {
		$('#delBtn').click(function() {
			if (i == 0) {
				$('#delBtn').text("취소");
				$('#del').show();
				i = 1;
			} else {
				$('#delBtn').text("삭제");
				$('#del').hide();
				i = 0;
			}
		});
	});
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3>내용보기</h3>
			<table class="table">
				<tr>
					<td class="info text-center" width=20%>번호</td>
					<td class="text-center" width=30%><%=vo.getNo()%></td>
					<td class="info text-center" width=20%>작성일</td>
					<td class="text-center" width=30%><%=vo.getRegdate().toString()%></td>
				</tr>
				<tr>
					<td class="info text-center" width=20%>이름</td>
					<td class="text-center" width=30%><%=vo.getName()%></td>
					<td class="info text-center" width=20%>조회수</td>
					<td class="text-center" width=30%><%=vo.getHit()%></td>
				</tr>
				<tr>
					<td class="info text-center" width=20%>제목</td>
					<td class="text-left" colspan="3"><%=vo.getSubject()%></td>
				</tr>
				<tr>
					<td class="text-left" valign="top" height=400 colspan="4"><%=vo.getContent()%></td>

				</tr>
			</table>
			<table class="table">
				<tr>
					<td class="text-right"><a href="update.jsp?no=<%=vo.getNo() %>" class="btn btn-success">수정</a>&nbsp;
						<a href="#" class="btn btn-warning" id="delBtn">삭제</a>&nbsp; <a
						href="list.jsp" class="btn btn-primary">목록</a></td>
				</tr>
				<tr id="del" style="display: none">
					<td class="text-right">
						<form action="delete_ok.jsp" method="post" id="frm">
							비밀번호:<input type="password" name=pwd size=10> <input
								type="hidden" name=no value="<%=vo.getNo()%>">
							<%-- hidden 은 게시물을 보여주지않을때 값을 넘길때 쓰는 것 입니다. --%>
							<input type=submit class="btn btn-warning btn-sm" value="삭제">
						</form>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>