<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>好友聊天</title>
	<%
	String path = request.getContextPath();
	String http = request.getScheme()+"://";
	String base = request.getServerName()+":"+request.getServerPort()+path+"/";
	String basePath =http+base;
	%>
	<base href="<%=basePath%>" />
	<link rel="stylesheet" href="css/shared_dialog.css">
	<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<style type="text/css">
</style>
<script type="text/javascript">
$(function(){
	 
	var mydate = new Date();
	if((mydate.getMonth()+1)<10){
		var myMonth="0"+(mydate.getMonth()+1);
	}else{
		var myMonth=""+(mydate.getMonth()+1);
	}
	// mydate.getMonth(); //获取当前月份(0-11,0代表1月)
	 //mydate.getDate(); //获取当前日(1-31)
	 if(mydate.getDate()<10){
			var myDate="0"+mydate.getDate();
		}else{
			var myDate=""+mydate.getDate();
		}
	 if(mydate.getHours()<10){
			var myHours="0"+mydate.getHours();
		}else{
			var myHours=""+mydate.getHours();
		}
	// mydate.getHours(); //获取当前小时数(0-23)
	 if(mydate.getMinutes()<10){
			var myMinutes="0"+mydate.getMinutes();
		}else{
			var myMinutes=""+mydate.getMinutes();
		}
	//mydate.getMinutes(); //获取当前分钟数(0-59)
	
	var us = [];
	var table=[];//创建对话table集合
	
	$(".span_title_user").each(function(){
		table.push($(this).html());
  	});
	var userList=[];//好友的集合
	
	/* for(i=0;i<user.length;i++){
		alert(user[i].username);
	} */
	
	   var base="<%=base%>";
	var webSocket = new WebSocket("ws://"+base+"chat//ws");
	webSocket.onopen = function(event){
	    console.log("连接成功");
	    console.log(event);
	};
	webSocket.onerror = function(event){
	    console.log("连接失败");
	    console.log(event);
	};
	webSocket.onclose = function(event){
	    console.log("Socket连接断开");
	    console.log(event);
	};
	//接收消息
	webSocket.onmessage = function(event){
		
			var message = JSON.parse(event.data);
			if(message.friendMessage==0){//为普通消息
					if(message.fromwho==$("#friendNameInput").val()){
						$("#session_list").find("."+message.fromwho+" button").html(0);
					}else{
						
						var num=  $("#session_list").find("."+message.fromwho+" button").html();
						//alert(num);
						 $("#session_list").find("."+message.fromwho+" button").html(parseInt(num)+1);
					}
					 
					for(i=0;i<table.length;i++){
						//alert(table);
						if(message.fromwho==table[i]){
							//alert("消息进来了-进入已经存在了的");
							$("#session_list").find("."+message.fromwho+" span:eq(1)").html(message.messagedate);
							$("#session_list").find("."+message.fromwho+" .div_tip").html(message.messagetext);
							$("#dialog_body_right_table").find("#"+message.fromwho+"").append(
									'<tr><td width="50px"><img src="img/yonghu.png" width="50px" height="50px"></td>'+
									'<td width="280px"><a>'+message.messagetext+'</a></td>'+
									'<td width="100px"></td>'+
									'<td width="280px"></td>'+
									'<td width="50px"></td></tr>'
							);
							$("#divDetail").scrollTop($("#dialog_body_right_table").find("#"+message.fromwho+"").height()) ;
							return;
						}
					}
					table.push(message.fromwho);
					//alert("消息进来了-创建一个新的");
					//在会话窗口创建这个好友的会话
					$("#session_list").append(
							'<li class="'+message.fromwho+'"><a><img alt="" src="img/yonghu.png" width="50px" height="50px">'+
								'<div class="div_session_right"><div class="div_title">'+
										'<span class="span_title_user">'+message.fromwho+'</span>'+
										'<span class="span_title_time">'+message.messagedate+'</span>'+
									'</div><div class="div_tip">'+message.messagetext+'</div>'+
								'</div></a><button>1</button></li>'
					);
					//创建好友聊天框
					$("#divDetail").append(
							'<table id="'+message.fromwho+'">'+
							'<tr><td width="50px"></td>'+
								'<td width="280px"></td>'+
								'<td width="100px">'+message.messagedate+'</td>'+
								'<td width="280px"></td>'+
								'<td width="50px"></td></tr>'+
							'<tr><td width="50px"><img src="img/yonghu.png" width="50px" height="50px"></td>'+
								'<td width="280px"><a>'+message.messagetext+'</a></td>'+
								'<td width="100px"></td>'+
								'<td width="280px"></td>'+
								'<td width="50px"></td></tr>'+
						'</table>'
					);
					$("#dialog_body_right_table").find("#"+message.fromwho+"").hide();
			}
			else if(message.friendMessage==1){//表示为好友请求消息

				for(i=0;i<table.length;i++){
					//alert(table);
					if(message.fromwho==table[i]){
						//alert("消息进来了-进入已经存在了的");
						$("#session_list").find("."+message.fromwho+" span:eq(1)").html(message.messagedate);
						$("#session_list").find("."+message.fromwho+" .div_tip").html(message.messagetext);
						return;
					}
				}
				table.push(message.fromwho);
				//alert("消息进来了-创建一个新的");
				//在会话窗口创建-请求加为好友的会话
				$("#session_list").append(
						'<li class="'+message.fromwho+'"><a><img alt="" src="img/yonghu.png" width="50px" height="50px">'+
							'<div class="div_session_right"><div class="div_title">'+
									'<span class="span_title_user">'+message.fromwho+'</span>'+
									'<span class="span_title_time">'+message.messagedate+'</span>'+
								'</div><div class="div_tip">'+message.messagetext+'</div>'+
							'</div></a><button>Q</button></li>'
				);
				//创建加为好友的确认框
				$("#divDetail").append(
						'<table id="'+message.fromwho+'">'+
						'<tr><td width="50px"></td>'+
							'<td width="280px"></td>'+
							'<td width="100px">'+message.messagedate+'</td>'+
							'<td width="280px"></td>'+
							'<td width="50px"></td></tr>'+
						'<tr><td width="50px"><img src="img/yonghu.png" width="50px" height="50px"></td>'+
							'<td width="280px"><a>用户'+message.fromwho+'正在请求添加你为好友</a></td>'+
							'<td width="100px"></td>'+
							'<td width="280px"></td>'+
							'<td width="50px"></td></tr>'+
						'<tr><td width="50px"></td>'+
							'<td width="280px"></td>'+
							'<td width="100px"></td>'+
							'<td width="280px"></td>'+
							'<td width="50px"></td></tr>'+
						'<tr><td ></td>'+
							'<td colspan="3"><center><button name='+message.fromwho+' class="addFriendButton">同意添加</button></center></td>'+
							'<td ></td></tr>'+
					'</table>'
				);
				
			}else{
				alert("消息读取错误！");
			}
	} 
	
	/* 回车发送消息 */
	$("body").keydown(function () {
		if (event.keyCode == "13") {//keyCode=13是回车键
			$('#input_submit').trigger("click");
		}
		});
	
	
	  //点击发送按钮给用户发送消息
	$("#input_submit").click(function(){
		//alert($("#friendNameInput").val());
		//alert( $("#input_text").val());
		var messageText=$("#input_text").val();
		var towho=$("#friendNameInput").val();
		if(messageText!=""){
			$("#dialog_body_right_table").find("#"+towho+"").append(
					'<tr><td width="50px"></td>'+
					'<td width="280px"></td>'+
					'<td width="100px"></td>'+
					'<td width="280px"><a>'+messageText+'</a></td>'+
					'<td width="50px"><img src="img/yonghu.png" width="50px" height="50px"></td></tr>'
					);
			$("#divDetail").scrollTop($("#dialog_body_right_table").find("#"+towho+"").height()) ;
			
			
			var data = {};//新建data对象，并规定属性名与相应的值
		    data['fromwho'] = "${user.username}";
		    data['towho'] = towho;
		    data['messagetext'] = messageText;
		   webSocket.send(JSON.stringify(data));
		    $("#input_text").val("");
		}else{
			
		}
			
	});  
	
	
	//$("#div_add_friend").hide();
	$("#friend_list").hide();
	$("#dialog_body_right_table").hide();
	
	/* 点击打开增加好友按钮 */
	$("#a_addfriend").click(function(){
		$("#add_friend_input").val("");
		$("#add_friend_input").show();
		$("#div_add_friend").css("display","block");
		$(".fadeDiv").css("display","block");
	});
	/* 点击关闭增加好友按钮 */
	$("#span_close").click(function(){
		$("#span_tip").html("输入Autumn用户名添加好友:");
		$("#div_add_friend button").html("搜索");
		$("#div_add_friend button").css("margin-left","");
		$("#div_add_friend button").css("margin-left","");
		$("#div_add_friend").css("display","none");
		$(".fadeDiv").css("display","none");
		
	});
	/* 点击显示所有会话按钮 */
	$("#messageId").click(function(){
		$("#friend_list").hide();
		$("#session_list").show();
		
		
	});
	/*点击显示所有好友按钮  */
	$("#friendId").click(function(){
		 $.ajax({  
		    type: "POST",  
		    url: "${pageContext.request.contextPath }/user/toFriend.do",  
		    async: false,
		    contentType:"application/json;charset=utf-8",
		    error: function() {  
		        alert("查找好友失败");  
		    },  
		    success: function(data) {
		    	$.each(data, function(index, obj) {
		    		var j=0;
		    		for(i=0;i<userList.length;i++){
		    			if(obj==userList[i]){
		    				j=1;
		    			}
		    		}
		    		if(j==0){
		    			userList.push(obj);
    				$("#friend_list").append(
							 '<li class="friend_list_class"><a>'+
									'<img alt="" src="img/yonghu.png" width="50px" height="50px">'+
									'<span>'+obj+'</span>'+
								'</a></li>'
							 );
		    		}
				 });
		    }  
		  });
		$("#friend_list").show();
		$("#session_list").hide();
	});
	
	/* 点击一个好友，创建一个对话-并打开聊天框 */
	$("#friend_list").on("click",".friend_list_class",function(){
		$("#div_shared_file").show();
		$("#dialog_body_right_img").hide();
		$("#dialog_body_right_table").show();
		var username=$(this).find("span").html();
		//alert(username);
		$("#friendNameInput").val(username);
		//alert($("#friendNameInput").val());
		$("#friend_list").find("#"+username+"").html(0);
		//var table=$("#divDetail").find("table").attr("id");
		//alert(table);
		
		 for(i=0;i<table.length;i++){
			if(table[i]==username){
				//alert("以前的这是"+username);
				$("#divDetail").find("table").hide();
				$("#divDetail").find("#"+username+"").show();
				$("#divDetail").scrollTop($("#dialog_body_right_table").find("#"+username+"").height()) ;
				$("#friend_list").hide();
				$("#session_list").show();
				return;
			}
		} 
		// alert("这是新的"+username);
		/* if(table!=null&&table==username){
			alert("buweikong");
			$("#divDetail").find("table").hide();
			alert($("#"+username+"").html());
			$("#"+username+"").show();
		}else{ */
			table.push(username);
		$("#divDetail").find("table").hide();
		//在会话窗口创建这个好友的会话
		$("#session_list").append(
				'<li class="'+username+'"><a><img alt="" src="img/yonghu.png" width="50px" height="50px">'+
					'<div class="div_session_right"><div class="div_title">'+
							'<span class="span_title_user">'+username+'</span>'+
							'<span class="span_title_time">'+myMonth+'-'+myDate+'&nbsp;'+myHours+':'+myMinutes+'</span>'+
						'</div><div class="div_tip"></div>'+
					'</div></a><button>0</button></li>'
		);
		//创建好友聊天框
		$("#divDetail").append(
				'<table id="'+username+'">'+
				'<tr><td width="50px"></td>'+
					'<td width="280px"></td>'+
					'<td width="100px">'+myMonth+'-'+myDate+'&nbsp;'+myHours+':'+myMinutes+'</td>'+
					'<td width="280px"></td>'+
					'<td width="50px"></td></tr>'+
			'</table>'
		);
		$("#friend_list").hide();
		$("#session_list").show();
		/* } */
		
	});
	/* 点击好友会话，打开聊天框 */
	$("#session_list").on('click','li',function(){
		var thisli=$(this);
		if($(this).find("button").html()!="Q"){
			//当聊天记录是历史记录打开之后就清除
			if($(this).attr("name")=="old"){
				var fromwho=$(this).attr("class");
				//alert("进入要删除的");
				$.ajax({  
				    type: "POST",  
				    url: "${pageContext.request.contextPath }/user/deleteMessage.do",
				    data: {"fromwho":fromwho},
				    async: false,
				    error: function() {  
				        alert("删除当前聊天记录失败");  
				    },  
				    success: function(data) {
				 
				    	thisli.attr("name","");
				    }  
				  });
				
			}
			var username=$(this).find("span:eq(0)").html();
			//alert(name);
			$(this).find("button").html(0);
			$("#friendNameInput").val(username);
			$("#div_shared_file").show();
			$("#dialog_body_right_img").hide();
			$("#dialog_body_right_table").show();
			$("#divDetail").find("table").hide();
			$("#divDetail").find("#"+username+"").show();
			$("#divDetail").scrollTop($("#dialog_body_right_table").find("#"+username+"").height()) ;

		}else{//好友请求的框
			var username=$(this).find("span:eq(0)").html();
			$("#friendNameInput").val(username);
			if($(this).attr("name")=="old"){
				$("#divDetail").find("#"+username+"").append(
						 '<tr><td ></td>'+
						'<td colspan="3"><center><button name='+username+' class="addFriendButton">同意添加</button></center></td>'+
						'<td ></td></tr>'
				);
			}
			$("#dialog_body_right_img").hide();
			$("#dialog_body_right_table").show();
			$("#divDetail").find("table").hide();
			
			$("#divDetail").find("#"+username+"").show();
			$("#div_shared_file").hide();
			
		}
		
	});
	
	/*点击搜索好友按钮  */
	$("#div_add_friend button").click(function(){
		var username=$("#add_friend_input").val();
		if($(this).html()=="搜索"){
			
			//alert(username);
			if(username==""){
				alert("请输入用户名");
			}
			else if(username=="${user.username}"){
				alert("不能添加自己");
			}else{
			
			$.ajax({  
			    type: "POST",  
			    url: "${pageContext.request.contextPath}/user/findFriend.do",  
			    data:{"username":username},
			    async: false, 
			    error: function() {  
			    	alert("查找用户名失败"); 
			    },  
			    success: function(data) {
			    	if(data==0){
			    		alert("该用户名不存在");
			    	}
			    	else if(data==1){
			    		alert("该用户已经是您的好友了");
			    	}
			    	else{
			    		$("#span_tip").html("您正在添加用户【"+username+"】");
			    		$("#add_friend_input").hide();
			    		$("#div_add_friend button").css("margin-left","200px");
			    		$("#div_add_friend button").html("确定");
			    	}
			    	
			    }
			  }); 
			}
		}
		else if($(this).html()=="确定"){//给对方发送好友请求
			var fmessage = {};//新建data对象，并规定属性名与相应的值
			fmessage['fromwho'] = "${user.username}";
			fmessage['towho'] = username;
			fmessage['messagetext'] = "好友请求";
			fmessage['friendMessage'] = 1;
		   webSocket.send(JSON.stringify(fmessage));
		   
		   $('#span_close').trigger("click");
		   alert("好友请求已经发送给对方,等待对方的回应。");
		}
		
		
	});
	//确定点击添加好友
	$("#divDetail").on("click",".addFriendButton",function(){
		//alert($(this).html());
		var friendname= $(this).attr("name");
		var thisparent=$(this).parent();
		$.ajax({  
		    type: "POST",  
		    url: "${pageContext.request.contextPath}/user/addFriend.do",  
		    data:{"friendname":friendname},
		    async: false, 
		    error: function() {  
		    	alert("添加好友失败"); 
		    },  
		    success: function(data) {
		    	//alert("添加好友成功,现在可以跟好友聊天了");
		    	thisparent.html("添加好友成功,现在可以跟好友聊天了");
		    	$("#div_shared_file").show();
		    	$("#session_list").find("."+friendname+"").attr("name","");
		    	$("#session_list").find("."+friendname+" button").html(0);
		    }
		  });
		
	});
	
	
});

</script>
</head>
<body >
	<jsp:include page="header.jsp"></jsp:include>
	<div id="dialog_body">
		<div id="dialog_body_left">
			<ul id="left_dialog">
				<li  id="messageId">
					<a>
						<img alt="" src="img/session.png" width="20px" height="24px">
						<span>会话</span>
					</a>
				</li>
				<li id="friendId">
					<a id="friend">
						<img alt="" src="img/friend.png" width="20px" height="24px">
						<span >好友</span>
					</a>
				</li>
			</ul>
			<div class="clearFloat"></div>
			<!-- 列表内容:好友会话 -->
		<ul id="session_list">
		 <c:forEach items="${userMessages}" var="listMessage">
			<li name="old" class="${listMessage.username}">
				<a>
					<img alt="" src="img/yonghu.png" width="50px" height="50px">
					<div class="div_session_right">
						<div class="div_title">
							<span class="span_title_user">${listMessage.username}</span>
							<span class="span_title_time"><fmt:formatDate value="${listMessage.messages['0'].messagedate}" pattern="MM-dd HH:mm"/></span>
						</div>
						<div class="div_tip">${listMessage.messages['0'].messagetext}</div>
					</div>
				</a>
				<c:if test="${listMessage.messages['0'].friendMessage==0}">
				<button >${fn:length(listMessage.messages)}</button>
				</c:if>
				<c:if test="${listMessage.messages['0'].friendMessage==1}">
				<button >Q</button>
				</c:if>
				
			</li>
		</c:forEach> 
			
		</ul>
		
		<!-- 好友列表 -->
			<ul id="friend_list">
				<%-- <c:forEach items="${friendlist }" var="userlist">
					<li class="friend_list_class">
						<a> 
							<img alt="" src="img/yonghu.png" width="50px" height="50px">
							<span>${userlist }</span>
						</a>
						
					</li>
				</c:forEach> --%>
			</ul>
			
			
			<a id="a_addfriend"><span>添加好友</span></a>
		</div>
		<div id="dialog_body_right">
		
		 <div id="dialog_body_right_img">
			<img id="empthStart" alt="" src="img/emptyStart_8caa682.png"><br>
			
		</div>
		
		<!-- 聊天窗口 -->
		<div id="dialog_body_right_table">
		<center><input type="text" id="friendNameInput" style="text-align:center;font-size:20px;border: none;"></center>
		<hr>
		<div id="divDetail" style="height:520px;overflow:auto;">
		
			<!-- 聊天的table -->
			 <c:forEach items="${userMessages }" var="listMessages">
				<table id="${listMessages.username }" style="display: none;">
					
					<c:forEach items="${listMessages.messages }" var="message">
					<tr>
						<td width="50px"><img src="img/yonghu.png" width="50px" height="50px"></td>
						<td width="280px">
						<fmt:formatDate value="${message.messagedate}" pattern="MM-dd HH:mm"/><br>
						<a>${message.messagetext}</a></td>
						<td width="100px"></td>
						<td width="280px"></td>
						<td width="50px"></td>
					</tr>
					</c:forEach>
					
				</table>
		</c:forEach>
		</div>
			<div id="div_shared_file" >
				<button>说你想说</button>
				
					<input id="input_text" type="text">
					<input id="input_submit" type="button" value="发送" style="cursor:pointer;">
					
			</div>
		</div> 
		
		</div>
	</div>

			<div id="div_add_friend">
				<span id="span_title">添加好友<span id="span_close" style="float: right;">X&nbsp;&nbsp;</span></span><br>
				<span id="span_tip">输入Autumn用户名添加好友:</span>
				<input id="add_friend_input" type="text" >
				<button>搜索</button>
			</div>
	
	<!-- 模态框样式的背景层 -->
	<div class="fadeDiv"> </div>

</body>
</html>