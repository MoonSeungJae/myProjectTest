<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
	width: 500px;
}
</style>
<script type="text/javascript">
	$(function() {

		$('#writeBtn').click(function() {
			var name = $('#name').val();
			if (name.trim() == "") {
				$('#name').focus();
				return; //function�� return ������ ����
			}
			var subject = $('#subject').val();
			if (subject.trim() == "") {
				$('#subject').focus();
				return; //function�� return ������ ����
			}
			var content = $('#content').val();
			if (content.trim() == "") {
				$('#content').focus();
				return; //function�� return ������ ����
			}
			var pwd = $('#pwd').val();
			if (pwd.trim() == "") {
				$('#pwd').focus();
				return; //function�� return ������ ����
			}
			$('#frm').submit();
			/*
			1) Jquery => tag�� �����ϴ� ���α׷� : DOM(DOCUMENT OBJECT M)
			2) �±׸� �о�ö�
			   1. �±� => $('tag��')
			   2. ���̵� => $('#id��')
			   3. Ŭ���� => $('.class��') ==> Selector
			3) �� �б�
			   1. �±׿� �±׻��� ��<a>aaa</a> => $('a').test()
			   2. input, select, textarea => $('tag��').val()
			   3. <img src=""> �Ӽ��� �������� =>$('img').attr("src")
			   4. <a><span>aaa</span></a>
			      $('a').html() => <span>aaa</span>
			      $('a').text() => aaa
			   5. ��ä��� text(""), val(""), attr("src","")
			 */

		})

	})
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3>�۾���</h3>
			<form method="post" action="insert_ok.jsp" id=frm>
				<!-- post�� �������� action�� �������� ��������?�Դϴ�.
          -->
				<table class="table table-hover">
					<tr>
						<td width=15% class="text-right">�̸�</td>
						<td width=85% class="text-left"><input type=text
							class="input" size=13 name=name id="name"></td>
					</tr>
					<tr>
						<td width=15% class="text-right">����</td>
						<td width=85% class="text-left"><input type=text
							class="input" size=45 name=subject id="subject"></td>
					</tr>
					<tr>
						<td width=15% class="text-right">����</td>
						<td width=85% class="text-left"><textarea rows="7" cols="50"
								name=content id="content"></textarea></td>
					</tr>
					<tr>
						<td width=15% class="text-right">��й�ȣ</td>
						<td width=85% class="text-left"><input type="password"
							size=10 name=pwd id="pwd"></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="button"
							value="�۾���" class="btn btn-warning btn-sm" id="writeBtn">
							<input type="button" value="���" class="btn btn-warning btn-sm"
							onclick="javascript:history.back()"> <!-- btn-xs, btn-sm, btn-md, btn-lg -->
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>