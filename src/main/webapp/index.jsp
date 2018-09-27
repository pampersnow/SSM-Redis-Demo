<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>SSM-Redis</title>
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
<script type="text/javascript">
	function addUser(){
		var name = $("#userName");
		var sex = $("#sex");
		var age = $("#age");
		var msg = "";
		
		if ($.trim(name.val()) == ""){
			msg = "姓名不能为空！";
			name.focus();
		}else if ($.trim(sex.val()) == ""){
			msg = "性别不能为空！";
			sex.focus();
		}else if($.trim(age.val()) == ""){
			msg = "年龄不能为空！";
			age.focus();
		}
		
		if(msg != ""){
			alert(msg);
			return false;
		} else {
			$.post("${pageContext.request.contextPath}/UserCRUD/addUser",
					$("#addForm").serialize(),function(data){
						if(data == "OK"){
							alert("添加成功！");
							//window.location.href="${pageContext.request.contextPath}/UserCRUD/showUser";
							//jQuery没有reset方法，jq对象需要调用dom对象的js方法
							$("#addForm")[0].reset();
							window.location.reload();
						} else {
							alert("添加失败！");
							return false;
						}
				});
		}
	}
	function update(){
		var ids = new Array();
		<c:forEach items="${ids}" var="id">  
			ids.push("${id}");  
    	</c:forEach> 
		var id = $("#mdf_id");
		var name = $("#mdf_userName");
		var sex = $("#mdf_sex");
		var age = $("#mdf_age");
		var flag = false;//标识ID是否有效
		//var flag2 = false;//标识信息是否有效
		
		if($.trim(id.val()) == ""){
			alert("请指定要更改用户的ID！");
			id.focus();
			return false
		} else {
			for(var i=0;i<ids.length;i++){
				if($.trim(id.val()) == ids[i]){
					flag = true;
				}
			}
			if(flag==false){
				alert("输入的ID不存在")
				id.focus();
				return false;
				}
		}
		
		if($.trim(name.val()) == "" && $.trim(sex.val()) == "" && $.trim(age.val()) == ""){
			alert("未进行修改");
			return false;
		} else {
			$.post("${pageContext.request.contextPath}/UserCRUD/editUser",
					{
						id:id.val(),
						name:name.val(),
						sex:sex.val(),
						age:age.val()
					},
					function(data){
						if(data == "OK"){
							alert("信息修改成功！");
							window.location.href="${pageContext.request.contextPath}/UserCRUD/search?keyWords=" + $.trim(id.val());
						} else {
							alert("信息修改失败！");
							return false;
						}
				});
		}
		
	}
	function searchByKeyWords(val) {
		window.location.href = "${pageContext.request.contextPath}/UserCRUD/search?keyWords=" + val;
	}
	function showUsers() {
		window.location.href = "${pageContext.request.contextPath}/UserCRUD/showUser";
	}
	function getUserById(val) {
		window.location.href = "${pageContext.request.contextPath}/UserCRUD/getUserById?userId=" + val;
	}
	function deleteById(id){
		var UID = $("#UID");
		var flag = false;
		if(id == null || id == ""){
			alert("请输入id！");
			UID.focus();
	    	return false;
		}
		var ids = new Array();
		<c:forEach items="${ids}" var="id">  
			ids.push("${id}");  
    	</c:forEach> 
    	for(var i=0;i<ids.length;i++){
            if(id == ids[i]){
            	flag = true;
            	$.post("${pageContext.request.contextPath}/UserCRUD/delUser/" + id,
						   function(data){
	 						  if(data == "OK"){
	 								alert("用户删除成功！");
	 								//window.location.href="${pageContext.request.contextPath}/UserCRUD/showUser";
	 								UID.val("");
	 								window.location.reload();
	 							} else {
	 								alert(data);
	 								return false;
	 							}
				   });
            }
        }
    	if(flag == false){
	    	alert("请输入正确的id！");
	    	UID.focus();
    	}
    	return false;
	}
	$(function (){
		var text = $("#num").text();
		if(text==null || text == ""){
			window.location.href="${pageContext.request.contextPath}/UserCRUD/indexMSG";
		}
		$("#userName").focus();
	})
</script>
<body style="background: #333">
	<h3>
		<span style="color:#FFFFFF">当前注册用户数量(一个小时更新一次):</span>
		<a id="num" href="${pageContext.request.contextPath}/UserCRUD/showUser">${usersCount }</a>
	</h3>
	<hr>
	<div class="container-fluid" style="background-color: #fff">
		<div class="col-md-2">
			<h2 class="page-header">增</h2>
			<form id="addForm" action="" method="post">
				<div class="form-group">
					<label for="userName">姓名</label><span style="color:red">&nbsp;*</span>
					<input type="text" name="userName" id="userName" placeholder="UserName" class="form-control">
				</div>
				<div class="form-group">
					<label for="sex">性别</label><span style="color:red">&nbsp;*</span>
					<input type="text" name="sex" id="sex" placeholder="UserSex" class="form-control">
				</div>
				<div class="form-group">
					<label for="age">年龄</label><span style="color:red">&nbsp;*</span>
					<input type="text" name="age" id="age" placeholder="UserAge" class="form-control">
				</div>
			</form>
			<div class="text-right">
				<button class="btn btn-info" onclick="return addUser();">
					<span class="glyphicon glyphicon-plus"></span>&nbsp;添加用户
				</button>
			</div>
		</div>
		<div class="col-md-3">
			<h2 class="page-header">删</h2>
			<p class="text-muted">现有ID(${fn:length(ids)}个)：</p>
			<p class="text-success">
				<c:forEach items="${ids }" var="id">
					<a href="${pageContext.request.contextPath}/UserCRUD/getUserById?userId=${id }">${id }&nbsp;</a>
				</c:forEach>
			</p>
			<div class="form-inline">
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon">UID：</span>
						<input type="text" name="UID" id="UID" placeholder="填入上方ID" class="form-control">
					</div>
				</div>
				<button class="btn btn-info" onclick="return deleteById($('#UID').val());">
					<span class="glyphicon glyphicon-remove"></span>&nbsp;删除
				</button>
			</div>
		</div>
		<div class="col-md-3">
			<h2 class="page-header">改</h2>
			<form id="updateForm" action="" method="post">
				<div class="form-group">
					<label for="id">UID</label><span style="color:red">&nbsp;*</span>
					<input type="text" name="mdf_id" id="mdf_id" placeholder="要修改用户ID" class="form-control">
				</div>
				<div class="form-group">
					<label for="mdf_userName">姓名</label> 
					<input type="text" name="mdf_userName" id="mdf_userName" placeholder="留空则不进行更改" class="form-control">
				</div>
				<div class="form-group">
					<label for="mdf_sex">性别</label> 
					<input type="text" name="mdf_sex" id="mdf_sex" placeholder="留空则不进行更改" class="form-control">
				</div>
				<div class="form-group">
					<label for="mdf_age">年龄</label> 
					<input type="text" name="mdf_age" id="mdf_age" placeholder="留空则不进行更改" class="form-control">
				</div>
			</form>
			<div class="text-right">
				<button class="btn btn-info" onclick="return update();">
					<span class="glyphicon glyphicon-refresh"></span>&nbsp;更新信息
				</button>				
			</div>
		</div>
		<div class="col-md-4">
			<h2 class="page-header">查</h2>
			<button class="btn btn-info" onclick="showUsers();">查找全部</button><br><br>
			<div class="form-inline">
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon">关键字：</span>
						<input type="text" name="keyWords" id="keyWords" class="form-control">
					</div>
				</div>
				<button class="btn btn-info" onclick="searchByKeyWords($('#keyWords').val());">
					<span class="glyphicon glyphicon-search"></span>&nbsp;查找
				</button>
			</div>
			<br>
			<div class="form-inline">
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon">UserID：</span>
						<input type="text" name="ById" id="ById" class="form-control">
					</div>
				</div>
				<button class="btn btn-info" onclick="getUserById($('#ById').val());">
					<span class="glyphicon glyphicon-search"></span>&nbsp;查找
				</button>
			</div>
		</div>
	</div>
</body>
</html>
