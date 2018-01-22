<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<style type="text/css">
body {
	background: url("img/footer-cloud_83b2a75.png") no-repeat fixed;
	background-position-y: bottom;
	background-size: 1366px 324px;
	background-color: #eef2f6;
}

#div_pickup {
	width: 500px;
	height: 280px;
	margin: 150px auto;
	background-color: #fff;
}

#div_title {
	height: 90px;
	background-color: #438aee;
	line-height: 90px;
	color: #fff;
}
#div_title span{margin-right: 10px;}
#div_body {
	height: 190px;
	padding: 44px 0px 0px 30px;
}
#div_body button{width: 80px; height: 36px;border: none;color: #fff;background-color: #4e97ff;border-radius: 5px;}
#input_textpass{width: 300px;height: 36px;margin:20px 0px 0px 0px; padding-left: 10px;background-color: #f2f2f2;border: none;border-radius: 5px;}
#span_img_icon{border-radius: 50px; width: 50px;height: 50px;float: left;overflow: hidden;margin: 16px 14px 0px 30px;}
</style>
<script type="text/javascript">
	$(function(){
		
		$(".getShareButton").click(function(){
			var  subfolderid=${share.subfolderid};
			var sharefield="${share.sharefield}";
			//alert(sharefield);
			var sharepassword=$("#input_textpass").val();
			//alert(sharepassword);
			if(sharepassword==""||sharepassword==null){
				alert("请输入提取密码");
			}else{
				if(sharepassword=="无加密文件不需要密码"){
					
					sharepassword="0";
				}
				var jsonObj=JSON.stringify({"subfolderid":subfolderid,
					"sharefield":sharefield,
					"sharepassword":sharepassword
					});
				 $.ajax({  
					    type: "POST",  
					    url: "${pageContext.request.contextPath }/file/downloudShare.do",  
					    data:jsonObj,  
					    async: false,
					    contentType:"application/json;charset=utf-8",
					    error: function(request) {  
					        alert("下载分享失败");  
					    },  
					    success: function(msg) {
					    	/* alert(typeof data);
							 var msg=parseInt(data); */
					    	if(msg==0){
					    		 alert("链接已经被删除");
					    	}
					    	else if(msg==-1){
					    		alert("提取码错误");
					    	}
					    	else {
					    		var form=$("<form>");//定义一个form表单
					    		form.attr("style","display:none");
					    		form.attr("method","get");
					    		form.attr("action","${pageContext.request.contextPath}/file/batchDownByIds.do");
					    		var input1=$("<input>");
					    		input1.attr("type","hidden");
					    		input1.attr("name","id");
					    		input1.attr("value",msg);
					    		$("body").append(form);//将表单放置在web中
					    		form.append(input1);
					    		form.submit();//表单提交 
					    	} 
					    }  
					  }); 
			}
		});
	});
</script>

</head>
<body>
	<div id="div_pickup">
	
	<c:if test="${msg==0}">
		<div id="div_title">
			<div id="span_img_icon">
			<img alt="" src="img/d758c603.jpg" width="50px" height="50px">
			</div>
			<span>链接错误</span>
		</div>
		<div id="div_body">
			<span>链接不存在或者用户已经删除文件</span><br>
		</div>
	</c:if>
	<c:if test="${msg==1}">
		<div id="div_title">
			<div id="span_img_icon">
			<img alt="" src="img/d758c603.jpg" width="50px" height="50px">
			</div>
			<span>链接已经过期了</span>
		</div>
		<div id="div_body">
			<span>哎！来晚了！链接已经失效了！</span><br>
		</div>
	</c:if>
	<c:if test="${msg==2}">
		
			<div id="div_title">
				<div id="span_img_icon">
				<img alt="" src="img/d758c603.jpg" width="50px" height="50px">
				</div>
				<span>${share.username}</span>给您分享了文件:${share.sharename}
			</div>
			<c:if test="${share.sharepassword!=null}">
				<div id="div_body">
					<span>请输入提取密码：</span><br>
					<input id="input_textpass" type="text">
					<button class="getShareButton">提取文件</button>
				</div>
			</c:if>
			<c:if test="${share.sharepassword==null}">
				<div id="div_body">
					<span>文件为公开链接：</span><br>
					<input id="input_textpass" type="text" value="无加密文件不需要密码"   readonly="readonly">
					<button class="getShareButton">提取文件</button>
				</div>
			</c:if>
		
	</c:if>
	</div>
</body>
</html>