<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/signup_form.jsp</title>
</head>
<body>
<h3>회원가입 폼입니다.</h3>
<form action="signup.do" method="post" id="myForm">
	<label for="id">아이디</label>
	<input type="text" name="id" id="id" />
	<button id="checkBtn">중복확인</button>
	<span id="checkResult"></span>
	<br />
	<label for="pwd">비밀번호</label>
	<input type="password" name="pwd" id="pwd" />
	<br />
	<label for="email">이메일</label>
	<input type="text" name="email" id="email" />
	<br />
	<button type="submit">가입</button>
	<button type="reset">취소</button>
</form>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.2.1.js"></script>
<script>
	// 1)페이지가 로딩되었을 때, 실행되는 함수
	$(function(){
		//입력한 아이디가 유효한지 여부
		var idValid = false;

		$("#checkBtn").click(function(){
			//입력한 아이디를 읽어와서
			var inputId = $("#id").val();
			//ajax 를 이용해서 서버에 전송
			$.ajax({
				url:"checkid.do",
				method:"GET",
				data:{"inputId":inputId},
				success:function(data){
					if(data.canUse){//사용가능
						$("#checkResult").text("사용 가능").css("color", "green");
						idValid = true;
					}else{//사용불가
						$("#checkResult").text("사용 불가").css("color", "red");
											
					}
				}
			});
			
			return false; //중복확인 버트을 눌렀을때 폼 전송 막기
		});
		
		//폼 전송 이벤트가 발생했을 때
		$("#myForm").submit(function(){
			if(!idValid){
				alert("아이디 중복확인을 하세요.");
				$("#id").val("").focus();
				return false;
			}
		});
		
		//id 입력란에 keydown 이벤트가 일어났을 때
		$("#id").keydown(function(){
			idValid = false;
			$("#checkResult").text("");
		});		
	});
	
	// 2)함수를 만들자 마자 호출하는 함수
	(function(){
		
	})();
	
	// => 사용자가 자바환경에 접근하여 전역변수를 바꾸지 못하도록 1), 2) 함수 형태 안에 코드를 집어넣는다
</script>
</body>
</html>