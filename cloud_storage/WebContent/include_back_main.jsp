<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>include_back_main</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />
<link href="css/back_main.css" rel="stylesheet" type="text/css">
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
		$(function(){
			
			$("#logout").click(function(){
				var fag=confirm("确定要退出吗？");
				if(fag==true){
					
					window.location.href="${pageContext.request.contextPath }/user/toLogout.do";
				}else{
					
				}
			
			});
		});
		
		</script>

</head>
<body>
	<div id="header">
		<!-- <img alt="" src="img/baidu_logo.png" width="200px" height="50px"> -->
		<a id="header_title">云盘后台管理系统</a>
		<div>您好 管理员<a>${user.username}</a>|<span id="logout" style="cursor:pointer;">退出</span></div>
		<div class="clearFloat"></div>
	</div>
	<ul id="body_left">
		<li><a href="${pageContext.request.contextPath }/manager/getAllUser.do">用户管理</a></li>
		<li><a href="${pageContext.request.contextPath }/manager/getUserAccess.do">在线用户</a></li>
	</ul>
</body>
</html>