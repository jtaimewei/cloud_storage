<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />

<title>back_main</title>
<style type="text/css">
#body_right{width: 79%;border: 1px #efefef solid;float: right;margin-right: 16px;border-radius: 5px;padding-left: 30px;}

#div_body_operate{height: 38px;margin: 20px 0px 0px 0px;}
#div_body_operate a{display: block;float: left;width: 150px;height: 38px;text-align: center;line-height: 38px;border: 1px #cec7c7 solid;border-radius: 5px;margin: 0px 0px 0px 30px; }
#div_body_operate input{margin-left: 230px;height: 30px;width: 250px;border: none;border: 1px #cec7c7 solid;border-radius: 5px;}
#div_body_operate button{width: 110px; height: 34px;border: none;background-color:#058592;color: #fff;border-radius: 5px;margin-left: 10px; }

#body_right table{text-align: center;margin-top: 20px;}
#body_right table td{border-style: none;height: 38px;border-bottom: 1px #efefef solid;}
#table_head{background-color: #058592;color: #fff;height: 38px;}

#update_title{height:50px; width: 600px; background-color: #10a6b4;}
#div_update_bg{background-color: #201f1f;background: rgba(0,0,0,0.5);position: absolute;top: 1px;left: 1px;width: 100%;height: 100%;color: #000;}
#div_update{width: 600px;height: 400px;position: relative;background-color:#fff;opacity:1;margin: 150px 0px 0px 400px;}
#div_update table{padding: 0px 0px 0px 20px;}
#div_update td{height: 38px;}
#div_update input{width: 400px;border: none;padding: 0px 0px 0px 10px;}
#div_update form button{width: 100px;margin:20px 0px 0px 200px;}

p{margin-left: 50px;font-size: 13px;color:#10a6b4; }
#update_title div{float: left;color: #fff;font-size: 20px;margin: 10px 20px;}
#update_title button{float:right;border:none;background:url("img/btn_icon_17d92fd.gif"); background-position: -280px -46px;width: 19px;margin: 5px 5px 0px 0px;height: 20px;}
</style>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
	$().ready(function () {
		$("#div_update_bg").hide();
		$(".a_update").click(function (){
			//alert("helo"+$(this).index()); 
			$("#div_update_bg").show();
			var arr=new Array(4);
			for(var i=0;i<4;i++){
				arr[i]=$(this).parent().parent().find("td").eq(i).text();
			}
			$("#div_update input").each(function (index) {
				$(this).val(arr[index]);
			}) 
		})
		$("#update_title button").click(function (){
			$("#div_update_bg").hide();
		})
	})
</script>
</head>
<body>
	<jsp:include page="include_back_main.jsp"></jsp:include>
	<div id="body_right">
		<!-- <div id="div_body_operate"><a>id从低到高</a><a>时间从高到低</a><input type="text" ><button>搜索</button></div> -->
		<table width="1040px" cellpadding="0" cellspacing="0">
			<tr id="table_head"><td>用户名</td><td>用户密码</td><td>用户状态</td><td>邮箱</td><td>操作</td></tr>
		<c:forEach items="${userlist}" var="user">
			<tr><td class="tr_userlist">${user.username}</td><td>${user.password}</td><td>${user.state}</td><td>${user.email}</td><td><span class="a_update" style="cursor:pointer;">修改</span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<a href="${pageContext.request.contextPath }/manager/deleteUser.do?un=${user.username}">冻结</a></td></tr>
		</c:forEach>
		</table>
	</div>
	<div id="div_update_bg">
		<div id="div_update">
			<div id="update_title">
				<div>修改用户信息</div>
				<button></button>
			</div>
			<form action="${pageContext.request.contextPath }/manager/updateUser.do" method="post">
				<table>
					<tr><td>用户名:</td><td><input readonly="readonly" name="un" type="text"></td></tr>
					<tr><td>用户密码:</td><td><input name="pw" type="text"></td></tr>
					<tr><td>用户权限:</td><td><input name="stat" type="text"></td></tr>
					<tr><td>邮箱:</td><td><input name="em" type="text"></td></tr>
				</table>
				<p>修改权限说明：0为未激活用户，1为普通用户，2为管理员用户，3为非法用户</p>
				<button type="submit">修改</button>
			</form>
		</div>
	</div>
</body>
</html>