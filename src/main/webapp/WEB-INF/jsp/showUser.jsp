<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>show user</title>
<!-- 屏幕和设备的屏幕一致，初始缩放为1:1，禁止用户缩放 -->
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=no">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-2">
			<h1>showUser</h1>
		</div>
		<div class="col-md-10">
			<br>
			<button class="btn btn-success" onclick="javascript:history.back(-1);">返回上一页</button>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="col-md-2">
			<c:if test="${empty userList && empty user}">
				<p class="text-warning">未查找到用户信息！</p>
			</c:if>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<div class="table-responsive">
				<table class="table table-bordered table-hover table-striped table-condensed">
					<c:if test="${requestScope.user != null }">
						<tr>
							<td>id</td>
							<td>userName</td>
							<td>sex</td>
							<td>age</td>
						</tr>
						<tr>
							<td>${user.id }</td>
							<td>${user.userName }</td>
							<td>${user.sex }</td>
							<td>${user.age }</td>
						</tr>
					</c:if>
					<c:if test="${requestScope.userList != null }">
						<tr>
							<td>id</td>
							<td>userName</td>
							<td>sex</td>
							<td>age</td>
						</tr>
						<c:forEach items="${userList }" var="user">
							<tr>
								<td>${user.id }</td>
								<td>${user.userName }</td>
								<td>${user.sex }</td>
								<td>${user.age }</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>