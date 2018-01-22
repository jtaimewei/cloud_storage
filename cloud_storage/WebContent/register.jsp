<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>register</title>
   <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />
    <link href="css/register_style.css" rel="stylesheet" type="text/css">
    <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
  
    <script type="text/javascript">
    $(function () {
    
    /* 隐藏所有提示信息 */
        $(".span_tip").hide();
       // $("#username").focus();
       /* 验证用户名为空--不为空则使用ajax去判断用户名是否存在 */
        $("#username").blur(function () {
        	var username =  $("#username").val();
            if(username==""){
                $("#span_un").css("color","red");
                $("#span_un").show();
            }
            else{
            	/* ajax 验证用户名是否存在 */
            	$.ajax({  
				    type: "POST",  
				    url: "${pageContext.request.contextPath }/user/checkName.do",  
				    data:{"username":username},  
				    async: false, 
				    error: function(data) {  
				        alert("验证用户名为空失败"); //ajax 上传失败的提示 
				    },  
				    success: function(data) {
				    	if(data==1){
				    		$("#span_un").html("用户名已存在！");
				    		$("#span_un").css("color","red");
			                $("#span_un").show();
							alert("该用户名已经被注册！请重新选择用户名");
						}else{
							
							$("#span_un").html("该用户名可以进行注册！");
							 $("#span_un").show();
						}
				      
				    }  
				  });
            	
            }
        })
        $("#username").focus(function () {
        	$("#span_un").html("用户名不能为空");
            $("#span_un").hide();
        });
        $("#password").blur(function () {
            if($("#password").val()==""){
                $("#span_pw").css("color","red");
                $("#span_pw").show();
            }
        })
        $("#password").focus(function () {
        	 $("#span_pw").html("密码不能为空");
            $("#span_pw").hide();
        });
        $("#repassword").blur(function () {
            if($("#repassword").val()==""){
                $("#span_rpw").css("color","red")
                $("#span_rpw").show();
               
            }else{
            	if($("#password").val()!=$("#repassword").val()){
            		$("#span_rpw").html("两次密码不一致");
            		$("#span_rpw").css("color","red")
                    $("#span_rpw").show();
            	}
            }
        })
        $("#repassword").focus(function () {
        	$("#span_rpw").html("确认密码不能为空");
            $("#span_rpw").hide();
        });
        $("#email").blur(function () {
            if($("#email").val()==""){
                $("#span_em").css("color","red")
                $("#span_em").show();
             
            }else{
                var str = $("#email").val();
                var ret = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
                if(str.match(ret)){
                }else {
                    $("#span_em").html("邮箱格式不正确");
                    $("#span_em").css("color","red")
                    $("#span_em").show();
                   
                }
            }
        })
        $("#email").focus(function () {
        	 $("#span_em").html("邮箱不能为空");
            $("#span_em").hide();
        });
       /* 点击注册按钮进行注册前验证所有信息是否完整 */ 
        $("#btn_register").click(function(){
        	var i=0;
        	var username=$("#username").val();
        	var password=$("#password").val();
        	var email=$("#email").val();
        	if(username==""){
                $("#span_un").css("color","red");
                $("#span_un").show();
                i++;
            }
        	if(password==""){
                $("#span_pw").css("color","red");
                $("#span_pw").show();
                i++;
            }
        	if($("#repassword").val()==""){
                $("#span_rpw").css("color","red")
                $("#span_rpw").show();
                i++;
            }
        	if(email==""){
                $("#span_em").css("color","red")
                $("#span_em").show();
                i++;
            }
        	if($("#span_un").html()=="用户名已存在"){
        		i++;
        	}
        	if($("#span_rpw").html()=="两次密码不一致"){
        		i++;
        	}
			if($("#span_em").html()=="邮箱格式不正确"){
				i++;
        	}
			/* 验证成功ajax注册 */
        	if(i==0){
        		var jsonObj=JSON.stringify({"username":username,
					"password":password,
					"email":email,
					});
        		 $.ajax({  
 				    type: "POST",  
 				    url: "${pageContext.request.contextPath }/user/register.do",  
 				    data:jsonObj,  
 				    async: false, 
 				    contentType:"application/json;charset=utf-8",
 				    error: function(data) {  
 				        alert("注册失败");  
 				    },  
 				    success: function(data) {
 				    	alert("你已经注册成功,请去邮箱验证");
 				    }  
 				  });
        		
        	}
        	
        });
        
        
        
    });
    
    
    </script>
</head>
<body>
    <div id="register_header">
        <div id="register_header_left">
            <img src="img/baidu.gif">
            <a>用户注册</a>
            <div class="clearFloat"></div>
        </div>
        <div id="register_header_right">
            我已注册，现在<a href="login.jsp">登录</a>
        </div>
    </div>
    <form action="" method="post" style="width: 700px;">
        <table>
            <tr>
	            <td>用户名</td>
	            <td><input name="username" id="username" type="text" placeholder="请设置用户名"></td>
	            <td><span id="span_un" class="span_tip">用户名不能为空</span></td>
            </tr>
            <tr>
	            <td>密码</td>
	            <td><input name="password" id="password" type="password" placeholder="请输入登录密码"></td>
	            <td><span id="span_pw" class="span_tip">密码不能为空</span></td>
            </tr>
            <tr>
	            <td>确认密码</td>
	            <td><input name="repassword" id="repassword" type="password" placeholder="请输入登录密码"></td>
	            <td><span id="span_rpw" class="span_tip">确认密码不能为空</span></td>
            </tr>
            <tr>
	            <td>邮箱</td>
	            <td><input name="email" id="email" type="text" placeholder="请输入登录密码"></td>
	            <td><span id="span_em" class="span_tip">邮箱不能为空</span></td>
            </tr>
           
        </table>
       
        <input id="btn_register" type="button" value="注册">
    </form>
</body>
</html>