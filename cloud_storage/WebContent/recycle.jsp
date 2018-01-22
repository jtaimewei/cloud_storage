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
<script type="text/javascript">
	$(function(){
		/* 撤销删除 */
		var removeTr;
		$(".recover").click(function(){
			var fileid = $(this).prev().html();
			var filename = $(this).prev().prev().html();
			var filefather = $(this).next().next().html();
			removeTr = $(this).parent().parent();
			$("#recover_id").html(fileid);
			$("#recover_name").html(filename);
			$("#recover_father").html(filefather);
			$("#recover").fadeIn(600);
			$(".fadeDiv").fadeIn(600);
		});
		$("#close_pop").click(function(){
			$("#recover").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
		});
		
		$("#close-recover").click(function(){
			$("#recover").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
		});
		
		$("#recover_ensure").click(function(){
			
			recoverJudge()
		});
		
		//确定回收
		function recoverJudge(){
			var fileid = $("#recover_id").html();
			var filename = $("#recover_name").html();
			var filefather = $("#recover_father").html();
			/* alert(fileid+"--"+filename+"--"+filefather); */
			$.ajax({
				type:"POST",
				data:{
					"fileid":fileid,
					"filename":filename,
					"filefatherid":filefather
				},
				url:"${pageContext.request.contextPath}/file/recover.do",
				error:function(){
					alert("系统故障，请检修");
				},
				success:function(data){
					if(data==1){
						$("#recover").fadeOut(600);
						$(".fadeDiv").fadeOut(600);
						$("#renamePop").fadeOut(600);
						removeTr.hide();
					}else{
						$("#renamePop").fadeIn(600);
						$("#recover").fadeOut(600);
					}
					
				}
			});
		}
		//移动文件    --重命名弹窗设置
		 $(".renamePop-cancel").click(function(){
			 $("#recover").fadeIn(600);
			 $("#renamePop").fadeOut(600);
		 })
		 $(".renamePop-ensure").click(function(){
			var name = $(".renamePop-center input").val();
			if(name==0){
				 alert("请输入文件名");
			}else{
					 $("#recover_name").html(name);
					 recoverJudge();
				 }
		 })
		/* 永久删除 */
		
		$(".delfile").click(function(){
			var fileid = $(this).prev().prev().html();
			var filename = $(this).prev().prev().prev().children().html();
			removeTr = $(this).parent().parent();
			$("#del_id").html(fileid);
			$("#del_name").html(filename);
			$("#delfile").fadeIn(600);
			$(".fadeDiv").fadeIn(600);
			
		});
		$("#close_delpop").click(function(){
			$("#delfile").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
		});
		$("#close-delfile").click(function(){
			$("#delfile").fadeOut(600);
			$(".fadeDiv").fadeOut(600);
		});
		$("#del_ensure").click(function(){
			var fileid = $("#del_id").html();
			var filename = $("#del_name").html();
			$.ajax({
				type:"POST",
				data:{
					"fileid":fileid,
					"filename":filename
				},
				url:"${pageContext.request.contextPath}/file/delfile.do",
				error:function(){
					alert("系统故障，请检修");
				},
				success:function(){
					$("#delfile").fadeOut(600);
					$(".fadeDiv").fadeOut(600);
					removeTr.hide();
				}
			});
		})		
	});
</script>

<body>
<jsp:include page="header.jsp"></jsp:include>
	<div id="div_left">
	<jsp:include page="left.jsp"></jsp:include>
	</div>
	提示：回收站不占用网盘空间，文件保存10天后将被自动清除。开通会员 延长至15天，开通超级会员 延长至30天 <br>
	<table id="list_content">
			<thead>
				<tr>
				<td id="wenjianming" class="cont_pad_lef">
					<input class="chbox" type="checkbox">
						<span class="span_wenjianming">文件名</span>
						<div class="clearFloat"></div></td>
					<td id="daxiao">大小</td>
					<td id="riqi">删除日期</td>
				</tr>
			</thead>
			
			<tbody id="maintbody">
			
			<c:forEach items="${listFolderFile}" var="listfile" >
				<tr class="tr_listfile">
					<c:if test="${listfile.subfolderfolder!=null}">
						<td class="a_listfile">
							<span class="span_add"></span>
							<span class="span_listfile">${listfile.subfolderfolder}</span>
							<span style="display: none;">${listfile.subfolderid}</span>
							<button type="button" class="recover"></button>
							<button type="button" class="delfile"></button>
							<span style="display:none;">${listfile.subfolderfather}</span>
						</td>
						<td>
							<a class="size_listfile">--</a>
						</td>
					
					</c:if>
					<c:if test="${listfile.subfolderfile!=null}">
						<td class="td_listfile">
							<span class="span_file"></span>
							<span class="span_listfile">${listfile.subfolderfile}</span>
							<span style="display: none;">${listfile.subfolderid}</span>
							<button type="button" class="recover"></button>
							<button type="button" class="delfile"></button>
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
		
		<!-- 隐藏弹框-确认还原 -->		
		<div id="recover">
			<span id="recover_id" style="display: none;"></span>
			<span id="recover_name" style="display: none;"></span>
			<span id="recover_father" style="display: none;"></span>
			<div class="open-top">
				<span>确认还原</span>
				<button id="close-recover"></button>
			</div>
			<div class="open-center">
				<div class="open-center-text">
					确认还原选中的文件？
				</div>
				<button id="recover_ensure" type="button">确定</button>
				<button id="close_pop" type="button">取消</button>
			</div>
		</div>
		
		<div class="fadeDiv" >
		
		</div>
		<!-- 隐藏弹框-确认删除 -->
		<div id="delfile" >
			<span id="del_id" style="display: none;"></span>
			<span id="del_name" style="display:none;"></span>
			<div class="open-top">
				<span>彻底删除</span>
				<button id="close-delfile"></button>
			</div>
			<div class="open-center">
				<div class="open-center-text">
					文件删除后将无法恢复，您确定要彻底删除所选文件吗？
				</div>
				<button id="del_ensure" type="button">确定</button>
				<button id="close_delpop" type="button">取消</button>
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
		
</body>
</html>
