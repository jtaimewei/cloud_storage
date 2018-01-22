<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="include_file1.jsp"></jsp:include>
<style type="text/css">
	span{
  cursor:pointer;
}
</style>
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
    <img id="img_header_logo" src="img/baidu_logo.PNG">
    <ul id="ul_header_left">
        <li><a href="${pageContext.request.contextPath }/user/toMain.do">网盘</a></li>
        <li><a href="${pageContext.request.contextPath }/user/toChat.do">分享</a></li>
        <li><a >更多</a></li>
    </ul>
    <ul id="ul_header_right">
        
        <li class="li_header_text" id="li_header_username">
        <a id="a_username">${user.username}</a> <span id="logout">退出</span>
        </li>
    	
        <li><img id="img_li_2" class="img_li" src="img/xitongtongzhi.png"></li>
        <li><img id="img_li_3" class="img_li" src="img/yijian.png"></li>
        <li><img id="img_li_4" class="img_li" src="img/pifu.png"></li>
       
    </ul>
    <div class="clearFloat"></div>
</div>
</body>
</html>