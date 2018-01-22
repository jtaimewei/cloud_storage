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
	#list_content tr td{
		width: 44%;
    padding: 5px 10px;
	}
	.video{
		background: url(img/btn_icon_17d92fd.gif) no-repeat;
	    background-position: -228px -89px;
	    width: 24px;
	    height: 21px;
	    border: none;
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
	
	<table id="list_content">
			<thead>
				<tr>
					<td id="filename">文件名</td>
					<td id="filesize">大小</td>
					<td id="filetime">创建日期</td>
				</tr>
			</thead>
			
			<tbody id="maintbody">
			
			<c:forEach items="${listVideo}" var="list" >
				<tr class="tr_listfile">
					<td>
						<button class="video"></button>
						${list.subfolderfile}
					</td>
					<td>${list.subfoldersize}</td>
					<td><fmt:formatDate value="${list.subfolderdate}" pattern="yyyy-MM-dd HH:mm"/>	</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
	
</body>
</html>
