<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR" import="com.sist.dao.*" %>
	<%
	String no=request.getParameter("no");
	BoardDAO dao = new BoardDAO();
	BoardVO vo = dao.boardUpData(Integer.parseInt(no));
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<!-- css, js 연결 -->
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<style>
.row {
	margin: 0px auto;
	width: 500px;
}
</style>

<script type="text/javascript">
	$(function() {
		$('#writeBtn').click(function() {
			var name = $('#name').val(); //입력값 가져옴
			if (name.trim() == "") {
				$('#name').focus();
				return;
			}

			var subject = $('#subject').val(); //입력값 가져옴
			if (subject.trim() == "") {
				$('#subject').focus();
				return;
			}

			var content = $('#content').val(); //입력값 가져옴
			if (content.trim() == "") {
				$('#content').focus();
				return;
			}

			var pwd = $('#pwd').val(); //입력값 가져옴
			if (pwd.trim() == "") {
				$('#pwd').focus();
				return;
			}

			$('#frm').submit(); //데이터 전송

		});
	});
</script>

</head>
<body>
	<div class="container">
		<div class="row">
			<h3>수정하기</h3>
			<!-- action : 누구한테 보낼것인지 insert_ok.jsp db연동만 하는애 -->
			<form method="post" action="update_ok.jsp" id="frm">
				<table class="table table_hover">
					<tr>
						<td width=15% class="text-right">이름</td>
						<td width=85% class="text-left"><input type="text"
							class="input" size=13 name=name id="name" value=<%=vo.getName() %>>
							<input type=hidden name=no value="<%=no%>">
							</td>
					</tr>
					<tr>
						<td width=15% class="text-right">제목</td>
						<td width=85% class="text-left"><input type="text"
							class="input" size=45 name=subject id="subject" value=<%=vo.getSubject() %>></td>
					</tr>
					<tr>
						<td width=15% class="text-right">내용</td>
						<td width=85% class="text-left"><textarea rows="7" cols="50"
								name=content id="content" ><%=vo.getContent() %></textarea></td>
					</tr>
					<tr>
						<td width=15% class="text-right">비밀번호</td>
						<td width=85% class="text-left"><input type="password"
							size=10 name=pwd id="pwd" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="button"
							class="btn btn-warning btn-sm" value="수정" id="writeBtn" > <!-- btn-xs, btn-sm, btn-md, btn-lg -->
							<input type="button" class="btn btn-warning btn-sm" value="취소"
							onclick="javascript:history.back()" > <!-- javascript:history.back() 전 화면으로 넘어감 -->
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>