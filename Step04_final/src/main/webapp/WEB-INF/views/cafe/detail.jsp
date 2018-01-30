<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cafe/insertform.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<style>
	.content{
		border: 1px dotted #cecece;
	}
	.comment textarea{
		width:80%;
		background-color: #fff;
	}
	.comment form{
		display: none;
	}
	.comment{
		position: relative;
	}
	.comment .reply_icon{
		position: absolute;
		width: 20px;
		height: 20px;
		top:0;
		left:-20px;
		border-left: 2px solid green;
		border-bottom: 2px solid green;
	}
	
	textarea{resize:none;}
   	#content{display:none;width:100%;height:300px;}
</style>
</head>
<body>
<div class="navbar navbar-default">
	<div class="container">
		<div class="navbar-header">
			<a href="${pageContext.request.contextPath }/" class="navbar-brand">Acorn</a>
		</div>
		<a class="btn btn-warning btn-xs navbar-btn pull-right" href="${pageContext.request.contextPath }/users/logout.do">로그아웃</a>
		<p class="navbar-text pull-right"><a class="navbar-link" href="${pageContext.request.contextPath }/users/info.do"><strong>${id }</strong></a>님 로그인중...</p>	
	</div>
</div>
<div class="container">
<!-- breadcrumb UI 제공하기 -->
	<ol class="breadcrumb">
		<li><a href="${pageContext.request.contextPath }/">Home</a></li>
		<li><a href="list.do">Cafe</a></li>
		<li class="active">글 상세 보기</li>
	</ol>
	<c:if test="${not empty msg }">
		<div class="alert alert-success">${msg }</div>
	</c:if>
	
	<div>
		<c:if test="${dto.prevNum ne 0 }">
			<a href="detail.do?num=${dto.prevNum }&condition=${condition}&keyword=${keyword}"> <i class="glyphicon glyphicon-menu-up"></i> 이전글</a>
		</c:if>
		<c:if test="${dto.nextNum ne 0 }">
			<a href="detail.do?num=${dto.nextNum }&condition=${condition}&keyword=${keyword}"> <i class="glyphicon glyphicon-menu-down"></i> 다음글</a>
		</c:if>
	</div>
	
	<%-- 로그인 한 회원이 작성한 글이라면 수정, 삭제 링크 제공 --%>
	<c:if test="${id eq dto.writer }">
		<a class="btn btn-info btn-xs" href="updateform.do?num=${dto.num }">수정</a>
		<a class="btn btn-warning btn-xs" href="javascript:deleteCheck()">삭제</a>
	</c:if>
	
	<h1><strong>${dto.title }</strong></h1>
	<p>${dto.regdate } <em>By</em> <strong>${dto.writer }</strong></p>
	<hr />
	<div class="content">${dto.content }</div>
	<hr />
	
	<!-- 덧글 목록 출력하기 -->
	<div class="comments">
		<c:forEach var="tmp" items="${commentList }">
			<!-- 덧글의 덧글만 들여쓰기 -->
			<div class="comment" <c:if test="${tmp.num ne tmp.comment_group }">style="margin-left:100px"</c:if> >
				<!-- 덧글의 덧글만 꺽쇄 표시 -->
				<c:if test="${tmp.num ne tmp.comment_group }">
					<div class="reply_icon"></div>
				</c:if>
				<div>
					from <strong>${tmp.writer }</strong>
					${tmp.regdate } <br />
					to <strong>${tmp.target_id }</strong>
					<a href="javascript:">답글</a>
				</div>
				<textarea rows="5" disabled>${tmp.content }</textarea>
				<form action="comment_insert.do" method="post">
					<!-- 덧글 작성자 -->
					<input type="hidden" name="writer" value="${id }"/>
					<!-- 덧글 그룹 -->
					<input type="hidden" name="ref_group" value="${dto.num }" />
					<!-- 덧글 대상 -->
					<input type="hidden" name="target_id" value="${tmp.writer }" />
					<input type="hidden" name="comment_group" value="${tmp.comment_group }" />
					<textarea name="content"></textarea>
					<button type="submit">등록</button>
				</form>
			</div>
		</c:forEach>
	</div>
	<!-- 원글에 대한 덧글 입력 폼 -->
	<div class="comment_form">
		<form action="comment_insert.do" method="post">
			<!-- 덧글 작성자 -->
			<input type="hidden" name="writer" value="${id }"/>
			<!-- 덧글 그룹 -->
			<input type="hidden" name="ref_group" value="${dto.num }" />
			<!-- 덧글 대상 -->
			<input type="hidden" name="target_id" value="${dto.writer }" />
			<textarea name="content"></textarea>
			<button type="submit">등록</button>
		</form>
	</div>
</div>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.2.1.js"></script>
<script>
	//로그인 했는지 안했는지 여부 
	var isLogin=${isLogin};
	
	//덧글 전송 이벤트가 일어 났을때 실행할 함수 등록 
	$(".comment_form > form, .comment form").submit(function(){
		if(!isLogin) {//만일 로그인 하지 않았다면 
			alert("로그인이 필요 합니다.");
			//로그인 페이지로 이동 
			location.href="${pageContext.request.contextPath}"+
			"/users/loginform.do"+
			"?url=${pageContext.request.contextPath}"+
			"/cafe/detail.do?num=${dto.num}&condition=${condition}&keyword=${keyword}";
			
			return false; //폼전송 막기 
		}
	});
	
	//덧글 달기 혹은 취소 버튼을 눌렀을때 실행할 함수 등록 
	$(".comment a").click(function(){
		if($(this).text()=="답글"){
			$(this)
			.text("취소")
			.parent()
			.parent()
			.find("form")
			.slideToggle();	
		}else{
			$(this)
			.text("답글")
			.parent()
			.parent()
			.find("form")
			.slideToggle();
		}
	});
		
	//글 삭제를 확인하는 함수
	function deleteCheck(){
		var isDelete = confirm("글을 삭제 하시겠습니까?");
		
		if(isDelete){
			location.href="delete.do?num=${dto.num}";
		}
	};
</script>
</body>
</html>