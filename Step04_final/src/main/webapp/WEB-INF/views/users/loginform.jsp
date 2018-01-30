<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/loginform.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/floating-labels.css" />
</head>
<body>
<div class="container">
	<form class="form-signin" action="login.do" method="post">
		<!-- 로그인 후 url 정보 -->
		<input type="hidden" name="url" value="${url }" />
		<h2 class="form-signin-heading">Please sign in</h2>
		<div class="form-label-group">
			<input type="text" name="id" id="id" class="form-control" placeholder="아이디" required autofocus />
			<label for="id">아이디</label>
		</div>
		<div class="form-label-group">
			<input type="password" name="pwd" id="pwd" class="form-control" placeholder="비밀번호" required/>
			<label for="pwd">비밀번호</label>
		</div>
		<div class="checkbox">
			<label>
				<input type="checkbox" id="isSave"/> 아이디 비밀번호 저장
			</label>
		</div>
		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
	</form>
</div>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.2.1.js"></script>
<script>
	
	// localStorage 에 저장된 아이디 비밀번호가 있으면 복구시켜준다.
	if(localStorage.id){//null 과 undefined 가 아니면, if(localStorage.id != undefined){}
		$("#id").val(localStorage.id);
		$("#pwd").val(localStorage.pwd);
		//체크박스 체크해주기
		$("#isSave").prop("checked", true);
	}
		
	//폼 전송 이벤트가 발생했을 때 실행할 함수 등록
	$(".form-signin").on("submit", function(){
		//아이디 비밀번호 저장여부
		var isSave = $("#isSave").is(":checked");
		if(isSave){
			//입력한 아이디 비밀번호를 읽어와서
			var inputId = $("#id").val();
			var inputPwd = $("#pwd").val();
			//localStorage 에 저장한다. (localStorage에 함수, 객체를 저장할 수 없다. 오직 문자열만 저장할 수 있는 Object이다!!)
			// cookie에는 한글을 저장할 수 없고, 제약이 많아서 요즘에 잘 쓰이지 않고, localStorage, sessionStorage를 사용한다.
			localStorage.id = inputId;
			localStorage.pwd = inputPwd;
		}else{
			//localStorage 에 id, pwd 삭제하기
			delete localStorage.id;
			delete localStorage.pwd;
		}
	});
</script>
</body>
</html>