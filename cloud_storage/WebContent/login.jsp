<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>login</title>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />
    <link href="css/login_style.css" rel="stylesheet" type="text/css">
    <link href="<%=basePath %>css/login_style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/jquery.cookie.js" ></script>
    <script type="text/javascript">
    	$(function(){
    		/*jquery-cookie记住用户名和密码  */
			if ($.cookie("rmbUser") == "true") {
		        $("#rmbUser").attr("checked", true);
		        $("#username").val($.cookie("userName"));
		        $("#password").val($.cookie("passWord"));
		   		 }
        	/* 点击登录按钮验证 */
        	$("#btn_login").click(function(){
        		var username=$("#username").val();
        		var password=$("#password").val();
        		var i=0;
        		if(username==""){
        			$("#username").attr("placeholder","用户名为空");
        			i++;
        		}
        		if(password==""){
        			$("#password").attr("placeholder","密码为空");
        			i++;
        		}
        		if(i==0){
        			/* ajax 验证用户登录信息是否正确 */
                	$.ajax({  
    				    type: "POST",  
    				    url: "${pageContext.request.contextPath }/user/login.do",  
    				    data:{"username":username,"password":password},  
    				    async: false, 
    				    error: function(data) {  
    				        alert("用户登录失败"); //ajax 上传失败的提示 
    				    },  
    				    success: function(data) {
    				    	if(data==0){
    				    		alert("用户:【"+username+"】不存在！");
    						}
    				    	else if(data==1){
    				    		alert("用户:【"+username+"】未邮箱验证！");
    						}
    				    	else if(data==2){
    				    		alert("用户:【"+username+"】账号被系统冻结！");
    						}
    				    	else if(data==3){
    				    		alert("用户:【"+username+"】密码错误！");
    						}
    				    	else{
    				    		if ($("#rmbUser").is(':checked')) {
    				    			//alert(username);
    				    	        $.cookie("rmbUser", "true", { expires: 7 }); // 存储一个带7天期限的 cookie
    				    	        $.cookie("userName", username, { expires: 7 }); // 存储一个带7天期限的 cookie
    				    	        $.cookie("passWord", password, { expires: 7 }); // 存储一个带7天期限的 cookie
    				    	    }
    				    	    else {
    				    	        $.cookie("rmbUser", "false", { expires: -1 });        // 删除 cookie
    				    	        $.cookie("userName", '', { expires: -1 });
    				    	        $.cookie("passWord", '', { expires: -1 });
    				    	    }
    				    		if(data==4){
    				    		window.location.href="${pageContext.request.contextPath }/user/toMain.do";
    				    		}
    				    	    if(data==5){
    				    			window.location.href="${pageContext.request.contextPath }/manager/getAllUser.do";
    				    		}
    				    	}
    				    }  
    				  });
        			}
        	});
        /* cookie记住密码 */
        
        	
    	});
    </script>
</head>
<body>
    <div id="content">
        <div id="login_header">
            <ul>
                <li><a class="font_color1">严打违规文件和盗版侵权传播</a></li>
                <li><a class="font_color2">百度首页</a></li>
                <li><a class="font_color2">客户端下载</a></li>
                <li><a class="font_color2">官方贴吧</a></li>
                <li><a class="font_color2">官方微博</a></li>
                <li><a class="font_color2">问题反馈</a></li>
                <li><a class="font_color2 bg_color">会员中心</a></li>
                <li class="clearFloat"></li>
            </ul>
        </div>
        <div id="login_content">
            <form action="<%=request.getContextPath() %>/user/login.do?flag=no" method="post">
                <p>账号密码登录</p>
                <input id="username" name="username" class="text" type="text" placeholder="手机/邮箱/用户名">
                <input id="password" name="password" class="text" type="password" placeholder="密码">
                <input type="checkbox" id="rmbUser">记住密码
                <input id="btn_login" type="button" value="登录">
            </form>
            <div id="form_bottom1">
                <a id="form_bottom1_left">登录遇到问题</a>
                <a id="form_bottom1_right">海外手机号</a>
                <div class="clearFloat"></div>
            </div>
            <div id="form_bottom2">
                <a id="saoyisao">扫一扫登录</a><a id="weibo"></a><a id="QQ"></a>
                <a id="register" href="register.jsp">立即注册</a>
            </div>
        </div>
    </div>
    <div id="login_footer">
        <a id="footer_1"></a>
        <a id="footer_2"></a>
        <a id="footer_3"></a>
        <a id="footer_4"></a>
        <a id="footer_5"></a>
    </div>
</body>
</html>