<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/updateform.jsp</title>
</head>
<body>
<form action="update.do" method="post">
	<input type="hidden" name="id" value="${dto.id }" />	
	<table>
		<tbody>
			<tr>
				<td>아이디</td>
				<td><input type="text" id="id" value="${dto.id }" disabled /></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="pwd" id="pwd" value="${dto.pwd }" /></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" id="email" value="${dto.email }" /></td>
			</tr>
			<tr>
				<td><button type="submit">수정</button></td>
			</tr>
		</tbody>
	</table>
</form>
</body>
</html>