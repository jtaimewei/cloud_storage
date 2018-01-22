<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>accessManage</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />
<style type="text/css">
#body_right{width: 79%;border: 1px #efefef solid;float: right;margin-right: 16px;border-radius: 5px;padding-left: 30px;}
#body_right table{text-align: center;margin-top: 20px;}
#body_right table td{border-style: none;height: 38px;border-bottom: 1px #efefef solid;}
#table_head{background-color: #058592;color: #fff;height: 38px;}
</style>
</head>
<body>
 <jsp:include page="include_back_main.jsp"></jsp:include>
<div id="body_right">
		<!-- <div id="div_body_operate"><a>id从低到高</a><a>时间从高到低</a><input type="text" ><button>搜索</button></div> -->
		<table width="1040px" cellpadding="0" cellspacing="0">
		
			<tr>
				<td colspan="4">当前在线人数:&nbsp;&nbsp;&nbsp;${fn:length(userSessionList)}&nbsp;&nbsp;人</td>
			</tr>
			<tr id="table_head">
				<td>序号</td>
				<td>用户ip地址</td>
				<td>用户名</td>
				<td>登录时间</td>
			</tr>
		<c:forEach items="${userSessionList}" var="UserSession" varStatus="status">
			<tr>
				<td class="tr_userlist">${status.index+1}</td>
				<td class="tr_userlist">${UserSession.ip}</td>
				<td>${UserSession.loginUserName}</td>
				<td><fmt:formatDate value="${UserSession.onlineTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</c:forEach>
		</table>
	</div>
</body>
</html>