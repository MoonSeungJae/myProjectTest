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

<!-- css, js ���� -->
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
			var name = $('#name').val(); //�Է°� ������
			if (name.trim() == "") {
				$('#name').focus();
				return;
			}

			var subject = $('#subject').val(); //�Է°� ������
			if (subject.trim() == "") {
				$('#subject').focus();
				return;
			}

			var content = $('#content').val(); //�Է°� ������
			if (content.trim() == "") {
				$('#content').focus();
				return;
			}

			var pwd = $('#pwd').val(); //�Է°� ������
			if (pwd.trim() == "") {
				$('#pwd').focus();
				return;
			}

			$('#frm').submit(); //������ ����

		});
	});
</script>

</head>
<body>
	<div class="container">
		<div class="row">
			<h3>�����ϱ�</h3>
			<!-- action : �������� ���������� insert_ok.jsp db������ �ϴ¾� -->
			<form method="post" action="update_ok.jsp" id="frm">
				<table class="table table_hover">
					<tr>
						<td width=15% class="text-right">�̸�</td>
						<td width=85% class="text-left"><input type="text"
							class="input" size=13 name=name id="name" value=<%=vo.getName() %>>
							<input type=hidden name=no value="<%=no%>">
							</td>
					</tr>
					<tr>
						<td width=15% class="text-right">����</td>
						<td width=85% class="text-left"><input type="text"
							class="input" size=45 name=subject id="subject" value=<%=vo.getSubject() %>></td>
					</tr>
					<tr>
						<td width=15% class="text-right">����</td>
						<td width=85% class="text-left"><textarea rows="7" cols="50"
								name=content id="content" ><%=vo.getContent() %></textarea></td>
					</tr>
					<tr>
						<td width=15% class="text-right">��й�ȣ</td>
						<td width=85% class="text-left"><input type="password"
							size=10 name=pwd id="pwd" /></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="button"
							class="btn btn-warning btn-sm" value="����" id="writeBtn" > <!-- btn-xs, btn-sm, btn-md, btn-lg -->
							<input type="button" class="btn btn-warning btn-sm" value="���"
							onclick="javascript:history.back()" > <!-- javascript:history.back() �� ȭ������ �Ѿ -->
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>