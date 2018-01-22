<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>user_list</title>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>" />

<jsp:include page="include_file2.jsp"></jsp:include>
<script type="text/javascript">
$(function () {
    /*上传文件框的显示与隐藏  */
	$("#header_left_shanchuan").click(function (){
		$("#upload").css("display","block");
	});
	/* 隐藏上传文件框 */
	$("#close_upload").click(function(){
		$("#upload").css("display","none");
	});
	/*ajax 判断文件名是否存在 */
	$("#input_submit").click(function(){
		//文件的后缀名：如 .jsp 
		 var filelastname=$("#file_lastname").val();
		//文件的名字 
		var filenameval=$("#upload_file_tmp").val();
		//文件的完整名
		var filenewname=filenameval+filelastname;
		if(filenewname==""){
			alert("请选择文件");
		}
		else{
		 $.ajax({  
			    type: "POST",  
			    url: "${pageContext.request.contextPath }/file/checkFileName.do",  
			    data:JSON.stringify({
			    	filename:filenewname, 
                }),  
			    async: false, 
			    contentType:"application/json;charset=utf-8",
			    error: function(request) {  
			        alert("查找文件失败");  
			    },  
			    success: function(folderFile) {
			    	if(folderFile.subfolderfile==""){
			    		alert("该文件名已经存在,请重新输入文件名字！");
			    	}else{
			    		
			    		$("#uploadFileInfo").submit();
			    	}
			      
			    }  
			  }); 
		}
	});
	
	
	
});
function change(){ 
	//var firstname=$("#upload_file").val();
	var firstname=document.getElementById("upload_file").value;
	
	var name=firstname.split('\\');
	var filename=name[2].split('.');
	//alert(filename[0]);
    document.getElementById("upload_file_tmp").value=filename[0]; 
    document.getElementById("file_lastname").value="."+filename[1];
} 

</script>
</head>
<body>
	<div id="list_header" class="pad_lef">
		<ul id="list_header_left">
			<li id="header_left_shanchuan">上传</li>
			<li id="header_left_xinjianwenjianjia" class="header_left_handle">新建文件夹</li>
			<li id="header_left_lixian" class="header_left_handle">离线下载</li>
			<li id="header_left_shebei" class="header_left_handle">我的设备</li>
			<li class="clearFloat"></li>
		</ul>
		<div id="list_header_right">
			<form action="">
				<table>
					<tr>
						<td><input id="btn_header_text" type="text"
							placeholder="搜索您的文件"></td>
						<td><input id="btn_header_search" type="submit" value="">
						</td>
					</tr>
				</table>
			</form>
			<img src="img/paixu.png" width="20px" height="20px"> <img
				src="img/xianshi.png" width="20px" height="20px">
		</div>
		<div class="clearFloat"></div>
	</div>
    <div id="upload" style="background-color: gray;display: none">
    	<button id="close_upload"></button>
        <img src="img/upload.PNG">
        <form id="uploadFileInfo" action="${pageContext.request.contextPath }/file/uploadFile.do"  
            method="post" enctype="multipart/form-data">
            <input type="file"  id="upload_file" name="subfolderfile"  style="display: none;" onchange="change();">  
    		<input type="text"  id="upload_file_tmp" name="filename">
    		<input type="text"  id="file_lastname"  >
    		<br/>
           <button type="button" id="select_file" onclick="upload_file.click();">浏览  </button>
            <button id="input_submit" type="button">上传 </button>  
        </form>
    </div>
    
</body>
</html>