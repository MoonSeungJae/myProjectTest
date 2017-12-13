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
				return; //function은 return 나오면 종료
			}
			var subject = $('#subject').val();
			if (subject.trim() == "") {
				$('#subject').focus();
				return; //function은 return 나오면 종료
			}
			var content = $('#content').val();
			if (content.trim() == "") {
				$('#content').focus();
				return; //function은 return 나오면 종료
			}
			var pwd = $('#pwd').val();
			if (pwd.trim() == "") {
				$('#pwd').focus();
				return; //function은 return 나오면 종료
			}
			$('#frm').submit();
			/*
			1) Jquery => tag를 제어하는 프로그램 : DOM(DOCUMENT OBJECT M)
			2) 태그를 읽어올때
			   1. 태그 => $('tag명')
			   2. 아이디 => $('#id명')
			   3. 클래스 => $('.class명') ==> Selector
			3) 값 읽기
			   1. 태그와 태그사이 값<a>aaa</a> => $('a').test()
			   2. input, select, textarea => $('tag명').val()
			   3. <img src=""> 속성값 가져오기 =>$('img').attr("src")
			   4. <a><span>aaa</span></a>
			      $('a').html() => <span>aaa</span>
			      $('a').text() => aaa
			   5. 값채우기 text(""), val(""), attr("src","")
			 */

		})

	})
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3>글쓰기</h3>
			<form method="post" action="insert_ok.jsp" id=frm>
				<!-- post로 보내야함 action은 누구한테 보낼꺼냐?입니다.
          -->
				<table class="table table-hover">
					<tr>
						<td width=15% class="text-right">이름</td>
						<td width=85% class="text-left"><input type=text
							class="input" size=13 name=name id="name"></td>
					</tr>
					<tr>
						<td width=15% class="text-right">제목</td>
						<td width=85% class="text-left"><input type=text
							class="input" size=45 name=subject id="subject"></td>
					</tr>
					<tr>
						<td width=15% class="text-right">내용</td>
						<td width=85% class="text-left"><textarea rows="7" cols="50"
								name=content id="content"></textarea></td>
					</tr>
					<tr>
						<td width=15% class="text-right">비밀번호</td>
						<td width=85% class="text-left"><input type="password"
							size=10 name=pwd id="pwd"></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="button"
							value="글쓰기" class="btn btn-warning btn-sm" id="writeBtn">
							<input type="button" value="취소" class="btn btn-warning btn-sm"
							onclick="javascript:history.back()"> <!-- btn-xs, btn-sm, btn-md, btn-lg -->
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>

</body>
</html>