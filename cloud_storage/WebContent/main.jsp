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
	#div_left{float: left;}
	#div_right{float: right;background-color: #ffffff;height: 580px;}
	
	
	/* 设置分享框为绝对定位： */
	#sharediv{
			position:  fixed;/*绝对定位*/
			left: 300px;
			top: 100px;
			background-color: white;
			width: 700px;
			height: 300px;
	}
	#textPassword{
		height: 1px;
		width:1px;
		background-color: white;
		color: white;
	
	}
	#msgSpan{
	position:  absolute;
	top:240px;
	right: 100px;
	color: red;
	display: none;
	}
	/* 视频音乐播放位置 */
	#playDiv{
	position: fixed;
	left: 200px;
	top:50px;
	
	}
</style>
<script type="text/javascript">

	/*更改json日期格式为指定格式  */
var format = function(time, format) {
    var t = new Date(time);
    var tf = function(i) {
        return (i < 10 ? '0': '') + i
    };
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g,
    function(a) {
        switch (a) {
        case 'yyyy':
            return tf(t.getFullYear());
            break;
        case 'MM':
            return tf(t.getMonth() + 1);
            break;
        case 'mm':
            return tf(t.getMinutes());
            break;
        case 'dd':
            return tf(t.getDate());
            break;
        case 'HH':
            return tf(t.getHours());
            break;
        case 'ss':
            return tf(t.getSeconds());
            break;
        }
    });
}
/*精准查询*/
$(function(){
    $("#btn_header_text").keyup(function(){
    	//alert($(this).parent().prev().children().val());
	     $("#list_content tbody tr")
		     .hide()
		     .filter(":contains('"+( $(this).val() )+"')")
		     .show();
	    });
});
	$(function(){
		
		/* $("#jquery_jplayer_1").jPlayer({
			ready: function (event) {
				$(this).jPlayer("setMedia", {
					title: "Bubble",
					m4a: "audio/LoginScreenIntro.mp3",
					//oga: "http://jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
				});
			},
			swfPath: "./jplayer",
			supplied: "mp3,m4a, oga",
			wmode: "window",
			useStateClassSkin: true,
			autoBlur: false,
			smoothPlayBar: true,
			keyEnabled: true,
			remainingDuration: true,
			toggleDuration: true
		}); */
		/* $("#jquery_jplayer_2").jPlayer({
			ready: function () {
				$(this).jPlayer("setMedia", {
					title: "Big Buck Bunny",
					m4v: "audio/logo.mp4",
				});
			},
			swfPath: "./jplayer",
			supplied: "webmv, ogv, m4v",
			size: {
				width: "640px",
				height: "360px",
				cssClass: "jp-video-360p"
			},
			useStateClassSkin: true,
			autoBlur: false,
			smoothPlayBar: true,
			keyEnabled: true,
			remainingDuration: true,
			toggleDuration: true
		}); */
		
		var basePath="<%=basePath%>";
		/* 点击-新建文件夹添加一行 */
		$("#header_left_xinjianwenjianjia").click(function(){
			$("#maintbody").prepend('<tr class="tr_listfile"><td class="td_add"><span class="span_add"></span><input class="input_add" type="text" value="新建文件夹"/><button class="addFolder"></button><button class="cancelFolder"></button></td><td><a class="size_listfile">--</a></td><td><a class="time_listfile">--</a></td></tr>');
			/* 点击-取消增加文件夹 */
			$(".cancelFolder").click(function(){
				$(this).parent().parent().remove();
			});
			/* 点击-确认增加文件夹 */
			$(".addFolder").click(function(){
				var folder=$(this).prev().val();
				var tr=$(this);
				//alert(folder);
				$.ajax({  
				    type: "POST",  
				    url: "${pageContext.request.contextPath }/file/addFolder.do",  
				    data:JSON.stringify({
				    	foldername:folder, 
	                }),  
				    async: false,
				    contentType:"application/json;charset=utf-8",
				    error: function() {  
				        alert("Connection error");  
				    },  
				    success: function(folderFile) {
				    	if(folderFile.subfolderfolder==""){
				    		alert("该文件夹已经存在,请重新输入文件夹名字！");
				    	}else{
				    		
				    	/*  更改日期格式*/
				    	var formatDate= format(folderFile.subfolderdate, 'yyyy-MM-dd HH:mm');
				    	/*加入文件大小  */
				    	tr.parent().next().html("--");
				    	/*  加入文件日期*/
				    	tr.parent().next().next().html(formatDate);
				    	/* 加入文件名字以及链接 */
				    	tr.parent().html('<span class="span_add"></span>'+
				    	'<span class="span_listfile"><a href="${pageContext.request.contextPath }/file/listFileStructure.do?page=1&subfolderid='+folderFile.subfolderid+'&subfolderfolder='+folderFile.subfolderfolder+'">'+folderFile.subfolderfolder+'</a></span>'+
				    	'<button  class="recycle"></button>'+
							'<span style="display: none;">'+folderFile.subfolderid+'</span>'+
							'<button class="moreOperate">'+
								'<div  class="xiajimulu">'+
									'<ul>'+
										'<li class="moveTo">移动到</li>'+
										'<li class="copyTo">复制到</li>'+
										'<li class="rename">重命名</li>'+
										'<li>删&nbsp;&nbsp;&nbsp;&nbsp;除</li>'+
									'</ul>'+
								'</div>'+
							'</button>'+
							'<span style="display:none;">'+folderFile.subfolderfather+'</span>'	
				    	);
				    	}
				    }  
				  });
			});
		});
	
		
		/*js-对分享框的隐藏和显示操作  */
		 /*分享框叉叉  */
		$("#btn_close").click(function(){
			$("#sharediv").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
			$("#div_share_header").nextAll().hide();
			$("#table_share").next().remove();
		}); 
		 /*分享框取消  */
		$("#btn_cancel").click(function(){
			$("#sharediv").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
			$("#table_share").next().remove();
		});
		 /* 分享框结果后取消 */
		$("#sharediv").on('click','#a_created_close',function(){
			$(this).parent().hide();
			$("#sharediv").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
			$("#table_share").next().remove();
		});
		/* 点击分享按钮 */
		 $(".shareClass").click(function(){
			//分享文件的id
			 var fileid=$(this).next().next().html();
			// alert(fileid);
			 //分享文件的名字
			 var filename=$(this).prev().prev().children().html();
			// alert(filename);
			 $("#sharediv").fadeIn(600);
			 $(".fadeDiv").fadeIn(600);
			 $("#table_share").show();
			 $("#filenameid").html(filename);
			$("#fileidid").html(fileid);
			 
		 });
		
		/*ajax 添加一条分享并返回链接和密码  */
		$("#btn_create_link").click(function(){
			 var subfolderid=$("#fileidid").html();//文件
			 var sharename= $("#filenameid").html();//文件名字
			var  sharestate= $("#sharediv").find('input:radio:checked').val();//选中是公开0还是加密1
			var sharedaynumber=$("#sharedaynumberid").val();
			//alert(sharedaynumber);
			var jsonObj=JSON.stringify({"subfolderid":subfolderid,
										"sharename":sharename,
										"sharestate":sharestate,
										"sharedaynumber":sharedaynumber,
										});
			 $.ajax({  
				    type: "POST",  
				    url: "${pageContext.request.contextPath }/file/shareFile.do",  
				    data:jsonObj,  
				    async: false, 
				    contentType:"application/json;charset=utf-8",
				    error: function(data) {  
				        alert("添加一条分享并返回链接和密码-失败");  
				    },  
				    success: function(data) {
				    	//移除选择分享
				    	$("#table_share").hide();
				 
				    	if(data.sharestate==1){
				    		$("#sharediv").append(
				    				'<div id="div_created_link">'+
									'<div id="a_created_title">'+
									 ' <span></span><a>成功创建私密链接</a>'+
										'<div class="clearFloat"></div>'+
									'</div>'+
									'<div>'+
									'<a id="a_created_link">'+basePath+'share/file/getShare/'+data.sharefield+'</a>'+
									'<button id="btn_created_copy">复制链接及密码</button>'+
									'<span id="msgSpan">复制成功</span>'+
									'<input id="textPassword" type="text" value="'+basePath+'share/file/getShare/'+data.sharefield+' 密码    '+data.sharepassword+'">'+
										'<div class="clearFloat"></div>'+
									'</div>'+
				    				'<div id="div_created_pw">'+
									'<a>提取密码</a>'+
									'<a id="a_created_pw">'+data.sharepassword+'</a>'+
										'<div class="clearFloat"></div>'+
									'</div>'+
									'<a id="a_created_tip">可以将链接发送给你的QQ好友</a>'+
									'<button id="a_created_close">关闭</button>'+
								'</div>'
				    			);
				    	}else{
				    		$("#sharediv").append(
				    				'<div id="div_created_link">'+
									'<div id="a_created_title">'+
									 ' <span></span><a>成功创建私密链接</a>'+
										'<div class="clearFloat"></div>'+
									'</div>'+
									'<div>'+
									'<a id="a_created_link">'+basePath+'share/file/getShare/'+data.sharefield+'</a>'+
									'<button id="btn_created_copy">复制链接</button>'+
									'<span id="msgSpan">复制成功</span>'+
									'<input id="textPassword" type="text" value="'+basePath+'share/file/getShare/'+data.sharefield+'">'+
										'<div class="clearFloat"></div>'+
									'</div>'+
									'<a id="a_created_tip">可以将链接发送给你的QQ好友</a>'+
									'<button id="a_created_close">关闭</button>'+
								'</div>'
				    			);
				    	}
				    }  
				  }); 
		});
		/* 复制链接和密码到粘贴板 */
		$("#sharediv").on('click','#btn_created_copy',function(){

			$("#textPassword").select(); // 选择对象
			document.execCommand("Copy"); // 执行浏览器复制命令
			//alert("已复制好，可贴粘。");
			$("#sharediv").find("#msgSpan").show();
		});
		
		/* 将文件或文件夹移入回收站部分 */
		var removeTr;
		$("body").on("click",".recycle",function(){
			$("#recycle").fadeIn(600);
			$(".fadeDiv").fadeIn(600);
			var fileid = $(this).next().html();
			removeTr = $(this).parent().parent();
			$("#file_id").html(fileid);
		});
		$("#close_recycle").click(function(){
			$("#recycle").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
		})
		$("#close-recycle").click(function(){
			$("#recycle").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
		})
		$("#recycle_ensure").click(function(){
			var fileid = $("#file_id").html();
			$.ajax({  
			    type: "POST",  
			    url: "${pageContext.request.contextPath}/file/moveToRecycle.do",  
			    data:{"fileid":fileid},
			    async: false, 
			    error: function() {  
			    	alert("遇到一个严重问题-文件删除失败，请检查"); 
			    },  
			    success: function(data) {
			    	$("#recycle").fadeOut(600);
					$(".fadeDiv").fadeOut(600);
			    	removeTr.hide();
			    }
			  }); 
		})
		
		
		/* 移动文件 ------  */
		var moveToTr;
		$("#close-moveToPop").click(function(){
			$("#moveToPop").fadeOut(600);
			$("#moveToPop").find(".moveTotop").remove();
			$(".fadeDiv").fadeOut(600);
		})
		$("#cancel-moveTo").click(function(){
			$("#moveToPop").fadeOut(600);
			$("#moveToPop").find(".moveTotop").remove();
			$(".fadeDiv").fadeOut(600);
		})
		
		/* 移动文件 ------ 查询数据，开启弹框   */
		$("body").on("click",".moveTo",function(){
			moveToTr = $(this).parent().parent().parent().parent().parent();
			var fileid = $(this).parent().parent().parent().prev().html();
			var filename= $(this).parent().parent().parent().parent().children().next().children().html();
			var filefather = $(this).parent().parent().parent().next().html();
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/file/gainTree.do",
				contentType:"application/json;charset=utf-8",
				error:function(){
					alert("系统故障-请通知管理员检修！")
				},
				success:function(data){
					$("#moveToPop").fadeIn(600);
					$(".fadeDiv").fadeIn(600);
					$(".moveTofile").html(fileid);
					$(".moveToname").html(filename);
					$(".moveTofather").html(filefather);
					$(".moveTo-center-text").append(
						"<div class='moveTotop'>"
							+"<div class='tr0' id='' style='z-index:10'>"
								+"<span style='display:none'>true</span>"
								+"<button class='moveToSignAdd' />"
								+"<button class='moveToFolder' />"
								+"<span>全部文件</span>"
								+"<div class='0' style='display:none'>0</div>"
								+"<div class='0' style='display:none'>0</div>"
							+"</div>"
						+"</div>"
					)
					var f = 0;
					showContext(data,0,f);
				},
			});
		}); 
		/* 移动文件 ------ 查询数据，利用递归算法将数据输送到弹框中   */
		function showContext(data,id,f){
			f = f + 1;
			for(var i=0;i<data.length;i++){
				if(data[i].subfolderfather==id){
					appendMoveToPop(data[i],f);
					showContext(data, data[i].subfolderid,f);
				}
			}
		};
		// 移动文件 ------ 将查出来的目录树 添加到窗口中
		function appendMoveToPop(data,f){
			$("div[class=tr"+(f-1)+"]:last").append(
				"<div class=tr"+f+" id='' style='display:none;z-index"+f+10+"'>"
					+"<span style='display:none'>true</span>"
					+"<button class='moveToSignAdd' />"
					+"<button class='moveToFolder' />"
					+"<span>"+data.subfolderfolder+"</span>"
					+"<div class="+data.subfolderid+" style='display:none'>"+data.subfolderid+"</div>"
					+"<div class="+data.subfolderfather+" style='display:none'>"+data.subfolderfather+"</div>"
				+"</div>"
			);
			appendSpace(f)
		}	
		// 移动文件 ------ 目录树中根据层级添加对应的空行 
		function appendSpace(f){
			for(var i =0 ;i < f ;i++){
				 $("div[class^='tr']:last").prepend(
					"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				);
			}  
		}
		//移动文件------确定此文件的前面的moveToSign为 什么符号
		
		//移动文件 ------点击加号 展示下面的目录 
		/*  $(".moveTo-center-text").on('click','.moveToSignAdd',function(){
		 		var a=$(this).next().next().next().html();
				 $("."+a).parent().fadeIn(600);
				 $(this).prev().html("false");
				 $(this).attr("class","moveToSignSub");
				 
		});  */
		//移动文件 ------点击减号 隐藏下面的目录 
		/*  $(".moveTo-center-text").on('click','.moveToSignSub',function(){
		 		$(this).prev().html("true");
		 		$(this).siblings("div[class^='tr']").fadeOut(600);
		 		$(this).attr("class","moveToSignAdd");
		}); */
		
		//移动文件 ------点击tr 展示下面的目录
		    $(".moveTo-center-text").on('click',"div[class^='tr']",function(){
			 if($(this).children().html()=="true"){
				 $("#isSelected").attr('id','');			//移除其他的选择标识
				 $(this).attr('id','isSelected');			//设置当前被选择
				 var a=$(this).children().next().next().next().next().html();  //取值
				 $(this).find('span:first').html("false");
				 $("."+a).parent().slideDown("slow");   
				 $(this).find('button:first').attr("class","moveToSignSub");
				 return false;
				 
			 }else if($(this).children().html()=="false"){
				 $("#isSelected").attr('id','');			//移除其他的选择标识
				 $(this).attr('id','isSelected');			//设置当前被选择
				 var a=$(this).children().next().next().next().next().html();  //取值
				 $(this).find('span:first').html("true");
				 $(this).children().siblings("div[class^='tr']").slideUp("slow");;
				 $(this).find('button:first').attr("class","moveToSignAdd");
				 return false;
			 }
		});   
		
		
		 /*移动文件 ------鼠标移动改变颜色*/
		 /*  $(".moveTo-center-text").on('mouseover',"div[class^='tr']",function(){
				this.style.backgroundColor = '#e5f0fb';
			});
		 $(".moveTo-center-text").on('mouseout',"div[class^='tr']",function(){
				this.style.backgroundColor = '#fff';
			}); */ 
		//alert($(".moveTofile").html()+$(".moveToname").html()); 
		
		//移动文件    --点击确定按钮
		 $('#ensure-moveTo').click(function(){
			 var targetid = $(".moveTo-center-text").find("#isSelected").children().next().next().next().next().html();
			 $(".moveTotargetid").html(targetid);
			 var fileid = $(".moveTofile").html();
			 if($("#isSelected").children().children("."+fileid).html()!=null){
				 alert("不能移动到父文件夹下！");
			 }else{
				 if($("."+fileid).parent().find("#isSelected").html()!=null){
					 alert("不能移动到自身文件夹下！");
				 }else{
					 if(targetid==$(".moveTofile").html()){
						 alert("不能移动到自身文件夹下！");
					 }else{
						 /* 实现移动  并且判断文件名字是否存在 */
						 /* alert("可以移动"); */
						 moveToAndJudge();
					 } 
				 }
			 }
		 })
		 //移动文件    --实现移动
		 function moveToAndJudge(){
			 var file = $(".moveTofile").html();
			 var father = $(".moveTofather").html();
			 var name = $(".moveToname").html();
			 var targetid = $(".moveTotargetid").html();
			 $.ajax({
					type:"post",
				 	data:{
						"fileid":file,
						"filename":name,
						"filefatherid":father,
						"targetid":targetid
					},
					url:"${pageContext.request.contextPath}/file/moveToTarget.do",
					error:function(){
						alert("系统故障，请通知检修");
					},
					success:function(data){
						if(data==0){
							//重名了，开启弹窗
							$("#renamePop input").attr("placeholder",name);
							$(".flag").html("移动");
							$("#renamePop").fadeIn(600);
							$("#moveToPop").fadeOut(600);
						}else{
							$("#moveToPop").fadeOut(600);
							$(".fadeDiv").fadeOut(600);
							$("#renamePop").fadeOut(600);
							$(moveToTr).remove();
						}
					}
				 });
		}
		
		//移动文件    --重命名弹窗设置
		 $(".renamePop-cancel").click(function(){
			 if($(".flag").html()=='移动'){
				 $("#moveToPop").fadeIn(600);
			 }else{
				 if($(".flag").html()=='复制'){
					 $("#copyToPop").fadeIn(600);
				 }
			 }
			 $("#renamePop").fadeOut(600);
		 })
		 $(".renamePop-ensure").click(function(){
			var name = $(".renamePop-center input").val();
			if(name==0){
				 alert("请输入文件名");
			}else{
				 if($(".flag").html()=='移动'){
						 $(".moveToname").html(name);
						 moveToAndJudge();
				 }else{
					 if($(".flag").html()=='复制'){
						 $(".copyToname").html(name);
						 copyToAndJudge();
					 }
				 }
			}
		 })
		
		
		 /* 复制文件 -----------复制文件 -------------复制文件 --------------复制文件 -------------------  */
			var copyToTr
			$("#close-copyToPop").click(function(){
				$("#copyToPop").fadeOut(600);
				$(".fadeDiv").fadeOut(600);
				$("#copyToPop").find(".copyTotop").remove();
			})
			$("#cancel-copyTo").click(function(){
				$("#copyToPop").fadeOut(600);
				$(".fadeDiv").fadeOut(600);
				$("#copyToPop").find(".copyTotop").remove();
			})
			
			/* 复制文件 ------ 查询数据，开启弹框   */
			$("body").on("click",".copyTo",function(){
				copyToTr = $(this).parent().parent().parent().parent().parent();
				var fileid = $(this).parent().parent().parent().prev().html();
				var filename= $(this).parent().parent().parent().parent().children().next().children().html();
				var filefather = $(this).parent().parent().parent().next().html();
				//alert(fileid+"--"+filename+"--"+filefather);
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/file/gainTree.do",
					contentType:"application/json;charset=utf-8",
					error:function(){
						alert("系统故障-请通知管理员检修！")
					},
					success:function(data){
						$("#copyToPop").fadeIn(600);
						$(".fadeDiv").fadeIn(600);
						$(".copyTofile").html(fileid);
						$(".copyToname").html(filename);
						$(".copyTofather").html(filefather);
						$(".copyTo-center-text").append(
							"<div class='copyTotop'>"
								+"<div class='tr0' id='' style='z-index:10'>"
									+"<span style='display:none'>true</span>"
									+"<button class='copyToSignAdd' />"
									+"<button class='copyToFolder' />"
									+"<span>全部文件</span>"
									+"<div class='0' style='display:none'>0</div>"
									+"<div class='0' style='display:none'>0</div>"
								+"</div>"
								
							+"</div>"
						)
						var f = 0;
						showContextCopy(data,0,f);
					},
				});
			}); 
			/* 复制文件 ------ 查询数据，利用递归算法将数据输送到弹框中   */
			function showContextCopy(data,id,f){
				f = f + 1;
				for(var i=0;i<data.length;i++){
					if(data[i].subfolderfather==id){
						appendcopyToPop(data[i],f);
						showContextCopy(data, data[i].subfolderid,f);
					}
				}
			};
			
			
			function appendcopyToPop(data,f){
				$("div[class=tr"+(f-1)+"]:last").append(
					"<div class=tr"+f+" id='' style='display:none;z-index"+f+10+"'>"
						+"<span style='display:none'>true</span>"
						+"<button class='copyToSignAdd' />"
						+"<button class='copyToFolder' />"
						+"<span>"+data.subfolderfolder+"</span>"
						+"<div class="+data.subfolderid+" style='display:none'>"+data.subfolderid+"</div>"
						+"<div class="+data.subfolderfather+" style='display:none'>"+data.subfolderfather+"</div>"
					+"</div>"
				);
				appendSpaceCopy(f)
			}	
			// 复制文件 ------ 目录树中根据层级添加对应的空行 
			function appendSpaceCopy(f){
				for(var i =0 ;i < f ;i++){
					 $("div[class^='tr']:last").prepend(
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
					);
				}  
			}
			
			//复制文件 ------点击加号 展示下面的目录 
			 /* $(".copyTo-center-text").on('click','.copyToSign',function(){
					 var a=$(this).next().next().next().html();
					 $("."+a).parent().fadeIn(600);
			});  */
			//复制文件 ------点击tri 展示下面的目录
			/*  $(".copyTo-center-text").on('click',"div[class^='tri']",function(){
				 $(this).attr('id','isSelected').siblings('#isSelected').attr('id','');
				 var a=$(this).children().next().next().next().html();
				 $("."+a).parent().fadeIn(600);
			});  */
			$(".copyTo-center-text").on('click',"div[class^='tr']",function(){
				 if($(this).children().html()=="true"){
					 $("#isSelected").attr('id','');			//移除其他的选择标识
					 $(this).attr('id','isSelected');			//设置当前被选择
					 var a=$(this).children().next().next().next().next().html();  //取值
					 $(this).find('span:first').html("false");
					 $("."+a).parent().slideDown("slow");   
					 $(this).find('button:first').attr("class","copyToSignSub");
					 return false;
					 
				 }else if($(this).children().html()=="false"){
					 $("#isSelected").attr('id','');			//移除其他的选择标识
					 $(this).attr('id','isSelected');			//设置当前被选择
					 var a=$(this).children().next().next().next().next().html();  //取值
					 $(this).find('span:first').html("true");
					 $(this).children().siblings("div[class^='tr']").slideUp("slow");
					 $(this).find('button:first').attr("class","copyToSignAdd");
					 return false;
				 }
			}); 
			
			//复制文件    --点击确定按钮 确定移动    ---调用函数
			 $('#ensure-copyTo').click(function(){
				 var targetid = $(".copyTo-center-text").find("#isSelected").children().next().next().next().next().html();
				 $(".copyTotargetid").html(targetid);
				 var fileid = $(".copyTofile").html();
				 if($("#isSelected").children().children("."+fileid).html()!=null){
					 alert("不能复制到父文件夹下！");
				 }else{
					 if($("."+fileid).parent().find("#isSelected").html()!=null){
						 alert("不能复制到自身文件夹下！");
					 }else{
						 if(targetid==$(".copyTofile").html()){
							 alert("不能复制到自身文件夹下！");
						 }else{
							 /* 实现移动  并且判断文件名字是否存在 */
							 /* alert("可以复制"); */
							 copyToAndJudge();  
						 } 
					 }
				 }
			 })
			 //复制文件    --判断文件是否重名    --实现移动
			 function copyToAndJudge(){
				var file = $(".copyTofile").html();
				var filename = $(".copyToname").html();
				var father = $(".copyTofather").html();
				var targetid = $(".copyTotargetid").html();
				//alert(file+"--"+filename+"--"+father+"--"+targetid);
				 $.ajax({
						type:"post",
					 	data:{
							"fileid":file,
							"filename":filename,
							"filefatherid":father,
							"targetid":targetid
						},
						url:"${pageContext.request.contextPath}/file/copyToTarget.do",
						error:function(){
							alert("系统故障，请通知检修");
						},
						success:function(data){
							if(data==0){
								//重名了，开启弹窗
								$("#renamePop input").attr("placeholder",filename);
								$(".flag").html("复制");
								$("#renamePop").fadeIn(600);
								$("#copyToPop").fadeOut(600);
							}else{
								$("#copyToPop").fadeOut(600);
								$(".fadeDiv").fadeOut(600);
								$("#renamePop").fadeOut(600);
							}
						}
					 });
			 }
			
			 /* 在线预览文档 */
				$(".showPDF").click(function(){
					var subfolderid=$(this).next().next().next().next().html();
					var filename=$(this).children().html();
					//alert(filename);
					var url= "<%=request.getServerName()%>" ;
					//alert(url);
					 $.ajax({
						type:"post",
					 	data:{
							"subfolderid":subfolderid,"filename":filename,
						},
						url:"${pageContext.request.contextPath }/preview/pdf.do",
						error:function(){
							alert("在线预览失败");
						},
						success:function(data){
							var filename=data.split('.');
							//alert(filename);
							var fileLastName=filename[filename.length-1];
							//alert(fileLastName);
							if(data==null){
								alert("文件系统错误！");
							}else{
								if(fileLastName=="pdf"){
								/*在新窗口中打开预览的文件  */
							window.open('http://'+url+':8080/cloud_storage/generic/web/viewer.html?file=pdf/'+data+'',false);
								}
								else if(fileLastName=="mp3"){
									$("#jquery_jplayer_1").jPlayer({
										ready: function (event) {
											$(this).jPlayer("setMedia", {
												title: "Bubble",
												m4a: "audio/"+data,
												//oga: "http://jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
											});
										},
										swfPath: "./jplayer",
										supplied: "mp3,m4a, oga",
										wmode: "window",
										useStateClassSkin: true,
										autoBlur: false,
										smoothPlayBar: true,
										keyEnabled: true,
										remainingDuration: true,
										toggleDuration: true
									});
									$(".jp-audio").show();
									
								}
								else if(fileLastName=="mp4"){
							
									$("#jquery_jplayer_2").jPlayer({
										ready: function () {
											$(this).jPlayer("setMedia", {
												title: "Big Buck Bunny",
												m4v: "audio/"+data,
											});
										},
										swfPath: "./jplayer",
										supplied: "webmv, ogv, m4v",
										size: {
											width: "640px",
											height: "360px",
											cssClass: "jp-video-360p"
										},
										useStateClassSkin: true,
										autoBlur: false,
										smoothPlayBar: true,
										keyEnabled: true,
										remainingDuration: true,
										toggleDuration: true
									});
									$(".jp-video").show();
									
									
								}
							}
						}
					 }); 
				});
		$("#closeMp3").click(function(){
			
			/* $("#jquery_jplayer_1").jPlayer({
				ready: function (event) {
					$(this).jPlayer("setMedia", {
						title: "Bubble",
						m4a: "",
						//oga: "http://jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
					});
				},
				swfPath: "./jplayer",
				supplied: "mp3,m4a, oga",
				wmode: "window",
				useStateClassSkin: true,
				autoBlur: false,
				smoothPlayBar: true,
				keyEnabled: true,
				remainingDuration: true,
				toggleDuration: true
			}); */
			$("#jp_container_1").hide();
			
		}); 
		$("#closeMp4").click(function(){
			$(".jp-video").hide();
			
		}); 
			 
			 
			
	});
</script>
</head>
<body>

	<jsp:include page="header.jsp"></jsp:include>
	<div id="div_left">
	<jsp:include page="left.jsp"></jsp:include>
	</div>
	<div id="div_right">
		<jsp:include page="body_top.jsp"></jsp:include>
		
	<div id="list_body">
		<div id="body_header" class="pad_lef">
			<span id="quanbuwenjian">
				<c:forEach items="${connectList}" var="map" varStatus="status">
					-->
					<span style="display: none;">${map.key}</span>
					<a href="${pageContext.request.contextPath }/file/listFileStructure.do?page=1&subfolderfolder=${map.value}&subfolderid=${map.key}">${map.value}</a>
					<%-- 注意此处不要修改span标签和a标签中的内容，${map.key}、${map.value}中的内容在删除操作中有取 --%>
				</c:forEach>
			</span> <span id="yijiazai">已全部加载</span>
			<div class="clearFloat"></div>
		</div>
		
		<table id="list_content">
			<thead>
				<tr>
				<td id="wenjianming" class="cont_pad_lef">
					<input class="chbox" type="checkbox">
						<span class="span_wenjianming">文件名</span>
						<div class="clearFloat"></div></td>
					<td id="daxiao">大小</td>
					<td id="riqi">修改日期</td>
				</tr>
			</thead>
			
			<tbody id="maintbody">
			
			<c:forEach items="${folderfile}" var="listfile" >
				
				<tr class="tr_listfile" >
					<c:if test="${listfile.subfolderfolder!=null}">
						<td class="a_listfile">
							<span class="span_add"></span>
							<span class="span_listfile">
								<a href="${pageContext.request.contextPath }/file/listFileStructure.do?page=1&subfolderfolder=${listfile.subfolderfolder}&subfolderid=${listfile.subfolderid}">${listfile.subfolderfolder}</a>
							</span>
							<button  class="recycle"></button>
							<span style="display: none;">${listfile.subfolderid}</span>
							<button class="moreOperate"><!-- 更多 -->
								<div  class="xiajimulu">
									<ul>
										<li class="moveTo">移动到</li>
										<li class="copyTo">复制到</li>
										<li class="rename">重命名</li>
										<li>删&nbsp;&nbsp;&nbsp;&nbsp;除</li>
									</ul>
								</div>
							</button>
							<span style="display:none;">${listfile.subfolderfather}</span>
						</td>
						<td><a class="size_listfile">--</a></td>
					</c:if>
					<c:if test="${listfile.subfolderfile!=null}"><!-- 文件 -->
						<td class="td_listfile">
							<span class="span_file"></span>
							<span class="span_listfile showPDF">
								<a>${listfile.subfolderfile}</a>
							</span>
							<a class="a_listfile_download" href="${pageContext.request.contextPath}/file/batchDownByIds.do?id=${listfile.subfolderid}"></a>
							<button type="button" class="shareClass"></button><!-- 分享 -->
							<button  class="recycle" ></button>  <!-- 删除 -->
							<span style="display: none;">${listfile.subfolderid}</span>
							<button class="moreOperate"><!-- 更多 -->
								<div  class="xiajimulu">
									<ul>
										<li class="moveTo">移动到</li>
										<li class="copyTo">复制到</li>
										<li class="rename">重命名</li>
										<li>删&nbsp;&nbsp;&nbsp;&nbsp;除</li>
									</ul>
								</div>
							</button>
							<span style="display:none;">${listfile.subfolderfather}</span>
						</td>
						<td><a class="size_listfile">${listfile.subfoldersize}KB</a></td>
					</c:if>
					<td><a class="time_listfile"></a><fmt:formatDate value="${listfile.subfolderdate}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		
	</div>
	</div>
	
	<div id="sharediv" style="display: none">
		<div id="div_share_header">
			<a id="a_share_title">分享文件：<span id="filenameid"></span>
			<span id="fileidid" style="display: none;"></span></a>
			<button id="btn_close"></button>
			<div class="clearFloat"></div>
			<a id="a_share_link">分享连接</a>
		</div>
		<!-- 分享 -->
		<table id="table_share">
			<tr>
				<td class="td_tip">分享形式</td><td class="td_discription"><input class="input_radio" type="radio" name="radio" value="1" checked="checked"><span>加密            仅限拥有密码者查看，更加隐私安全</span></td>
			</tr>
			<tr>
				<td></td>
				<td><input class="input_radio" type="radio" name="radio" value="0">公开           任何人可查看或下载，同时出现在您的个人主页</td>
			</tr>
			<tr>
				<td class="td_tip">有效期</td>
				<td>
					<select id="sharedaynumberid">
						  <option  value ="0">永久有效</option>
						  <option  value ="1">有效期1天</option>
						  <option  value ="7">有效期7天</option>
					</select>
				</td>
			</tr>
			<tr class="tr_button">
				<td id="td_button" colspan="2">
					<button id="btn_cancel">取消</button>
					<button id="btn_create_link">创建链接</button>
				</td>
			</tr>
		</table>
		<!-- 生成连接 -->
		<!--  <div id="div_created_link">
			<div id="a_created_title">
				<span></span><a>成功创建私密链接</a>
				<div class="clearFloat"></div>
			</div>
			<div>
				
			<a id="a_created_link">https//pan.baidu.com/s/1dFgulOH</a>
			<button id="btn_created_copy">复制链接及密码</button>
				<div class="clearFloat"></div>
			</div>
			公开链接将本div隐藏掉
			<div id="div_created_pw">
			<a>提取密码</a>
			<a id="a_created_pw">remc</a>
				<div class="clearFloat"></div>
			</div>
			
			<a id="a_created_tip">可以将链接发送给你的QQ好友</a>
			<button id="a_created_close">关闭</button>
		</div> -->	
	</div>
	
	<!--将此文件或者文件夹移入回收站  -->
	<div id="recycle">
		<span id="file_id" style="display: none;"></span>
		<div class="open-top">
			<span>确认删除</span>
			<button id="close-recycle"></button>
		</div>
		<div class="open-center">
			<div class="open-center-text">
				确认要把所选文件放入回收站吗？<br>
				删除的文件可在10天内通过回收站还原
			</div>
			<button id="recycle_ensure" type="button">确定</button>
			<button id="close_recycle" type="button">取消</button>
		</div>
		
		<div>
			<img alt="" src="img\vip1.png">
		</div>
	</div>
	
	
	<!-- 移动文件 隐藏框 -->
	<div id="moveToPop">
		<div class="moveTofile" style="display: none;"> </div>
		<div class="moveToname" style="display: none;"> </div>
		<div class="moveTofather" style="display:none"></div>
		<div class="moveTotargetid" style="display:none"></div>
		
		<div class="moveTo-top">
			<span>移动到</span>
			<button id="close-moveToPop"></button>
		</div>
		<div class="moveTo-center">
			<div class="moveTo-center-text">
				<!-- 在这append数据 -->
			</div>
		</div>
		
		<div class="moveTo-bottom">
			<button id="newFile-moveTo">新建文件夹</button>
			<button id="cancel-moveTo">取消</button>
			<button id="ensure-moveTo">确定</button>
		</div>
	</div>
	
	
	<!-- 复制文件 隐藏框 -->
	<div id="copyToPop">
		<div class="copyTofile" style="display: none;"> </div>
		<div class="copyToname" style="display: none;"> </div>
		<div class="copyTofather" style="display:none"></div>
		<div class="copyTotargetid" style="display:none"></div>
		
		<div class="copyTo-top">
			<span>复制到</span>
			<button id="close-copyToPop"></button>
		</div>
		<div class="copyTo-center">
			<div class="copyTo-center-text">
				<!-- 在这append数据 -->
			</div>
		</div>
		
		<div class="copyTo-bottom">
			<button id="newFile-copyTo">新建文件夹</button>
			<button id="cancel-copyTo">取消</button>
			<button id="ensure-copyTo">确定</button>
		</div>
	</div>
	
	<!-- 重命名弹框 隐藏框 -->
	<div id="renamePop">
		<div class="flag" style="display:none"></div>
		<div class="renamePop-top">
			<span>文件重名了,请重新命名</span>
		</div>
		<div class="renamePop-center">
			<input name=""	type="text" placeholder=""/>
		</div>
		<div class="renamePop-bottom">
			<button class="renamePop-cancel">取消</button>
			<button class="renamePop-ensure">确认</button>
		</div>
	</div>
	<!-- 模态框样式的背景层 -->
	<div class="fadeDiv"> </div>
	

				<!--
		    	
		    	描述：音频播放器
		    -->
	<div id="playDiv">
		 
		  <div id="jp_container_1" class="jp-audio" role="application" aria-label="media player" style="display: none;">
		  	<span id="closeMp3" style="margin-left: 400px;">X</span>
		  <div id="jquery_jplayer_1" class="jp-jplayer"></div>
			<div class="jp-type-single">
				 <div class="jp-gui jp-interface"> 
					<div class="jp-controls">
						<button class="jp-play" role="button" tabindex="0">play</button>
						<button class="jp-stop" role="button" tabindex="0">stop</button>
					</div>
					<div class="jp-progress">
						<div class="jp-seek-bar">
							<div class="jp-play-bar"></div>
						</div>
					</div>
					<div class="jp-volume-controls">
						<button class="jp-mute" role="button" tabindex="0">mute</button>
						<button class="jp-volume-max" role="button" tabindex="0">max volume</button>
						<div class="jp-volume-bar">
							<div class="jp-volume-bar-value"></div>
						</div>
					</div>
					<div class="jp-time-holder">
						<div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
						<div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
						<div class="jp-toggles">
							<button class="jp-repeat" role="button" tabindex="0">repeat</button>
						</div>
					</div>
				</div>
				<div class="jp-details">
					<div class="jp-title" aria-label="title">&nbsp;</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>
		  <!--
		  	作者：2661370328@qq.com
		  	时间：2017-10-11
		  	描述：视频播放器
		  --> 
		  
	<div id="jp_container_1" class="jp-video jp-video-360p" role="application" aria-label="media player" style="display: none;">
		<span id="closeMp4" style="margin-left: 620px;">X</span>
		<div class="jp-type-single">
			<div id="jquery_jplayer_2" class="jp-jplayer"></div>
			<div class="jp-gui">
				<div class="jp-video-play">
					<button class="jp-video-play-icon" role="button" tabindex="0">play</button>
				</div>
				<div class="jp-interface">
					<div class="jp-progress">
						<div class="jp-seek-bar">
							<div class="jp-play-bar"></div>
						</div>
					</div>
					<div class="jp-current-time" role="timer" aria-label="time">&nbsp;</div>
					<div class="jp-duration" role="timer" aria-label="duration">&nbsp;</div>
					<div class="jp-controls-holder">
						<div class="jp-controls">
							<button class="jp-play" role="button" tabindex="0">play</button>
							<button class="jp-stop" role="button" tabindex="0">stop</button>
						</div>
						<div class="jp-volume-controls">
							<button class="jp-mute" role="button" tabindex="0">mute</button>
							<button class="jp-volume-max" role="button" tabindex="0">max volume</button>
							<div class="jp-volume-bar">
								<div class="jp-volume-bar-value"></div>
							</div>
							
						</div>
						
						<div class="jp-toggles">
							<button class="jp-repeat" role="button" tabindex="0">repeat</button>
							<button class="jp-full-screen" role="button" tabindex="0">full screen</button>
						</div>
					</div>
					<div class="jp-details">
						<div class="jp-title" aria-label="title">&nbsp;</div>
					</div>
					
				</div>
			</div>
			
			<div class="jp-no-solution">
				<span>Update Required</span>
				To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
			</div>
			
		</div>
		
	</div>
</div>
			

	
	
</body>
</html>