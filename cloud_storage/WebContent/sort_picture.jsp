<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />
<jsp:include page="include_file2.jsp"></jsp:include>
<style type="text/css">
	.picture-body{
		border: 1px solid gray;
	    float: right;
	    width: 82%;
	    background: white;
	    border-radius: 15px;
	    padding: 10px 20px;
	}
	.picture-title{
		background-color: #f0f9fd;
	    height: 18px;
	    width: 96%;
	    padding: 10px 20px;
	    border-radius: 5px;
	    font-size: 15px;
	    color: blue;
	    font-weight: 500;
	}
	.picture-show{
    	padding: 7px 20px 7px 0px;
	}
	.picture-show img{
		width: 180px;
    	height: 120px;
	}
	

</style>
<script type="text/javascript">
	$(function(){
		
		
	});
	
</script>

<body>
<jsp:include page="header.jsp"></jsp:include>
	<div id="div_left">
	<jsp:include page="left.jsp"></jsp:include>
	</div>
	<div class="picture-body">
		<c:forEach items="${listPicture}" var="list" >
			<div class="picture-title" id='<fmt:formatDate value="${list.folderFile.subfolderdate}" pattern="yyyyMMdd"/>'>
				<fmt:formatDate value="${list.folderFile.subfolderdate}" pattern="yyyy年MM月dd日"/>
			</div>
			<div class="picture-show">
				<img src="/picture/${list.path }">
			</div>
		</c:forEach>
	</div>
</body>
</html>
