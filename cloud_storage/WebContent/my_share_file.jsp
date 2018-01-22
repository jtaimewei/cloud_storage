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
 #pageDiv a{
 	color: blue;
 
 }

</style>
<script type="text/javascript">
	$(function(){
		
		//把当前页码显示为红色
		var page=${pageinfo.page};
		$("#pageDiv").find("#"+page+"").css("color","red");
		//点击删除-ajax 删除这一条分享记录
		$(".deleteShareSpan").click(function(){
			var shareid=$(this).parent().parent().find("td:eq(1)").html();
			//alert(shareid);
			var msg=confirm("确定删除这个分享吗？");
			 if(msg==true){
				 window.location.href="${pageContext.request.contextPath }/file/deleteShare.do?shareid="+shareid;
			 }
			     
			   
			
		});
		
	});
	
</script>

<body>
<jsp:include page="header.jsp"></jsp:include>
	<div id="div_left">
	<jsp:include page="left.jsp"></jsp:include>
	</div>
	&nbsp;&nbsp;&nbsp;&nbsp;共有${pageinfo.countnumber}个分享     
	
	&nbsp;&nbsp;&nbsp;&nbsp;
	<div id="pageDiv" style="display: inline;font-size: 16px;color: blue;" >
	<a href="${pageContext.request.contextPath}/file/getMyShare.do?page=1"><span>首页</span></a>
	&nbsp;&nbsp;
			<c:if test="${pageinfo.page>1}">
				<a
					href="${pageContext.request.contextPath}/file/getMyShare.do?page=${pageinfo.page-1}"
					> <span>&laquo;</span>
				</a>
			</c:if>

			<c:if test="${pageinfo.page==1}">
				<a> 
				<span>&laquo;</span>
				</a>
			</c:if>
			&nbsp;&nbsp;
			<c:choose>

				<c:when test="${pageinfo.page<=3 && pageinfo.pagenumber<=3}">
					<c:forEach var="i" begin="1" end="${pageinfo.pagenumber}">
						<a id="${i}"
							href="${pageContext.request.contextPath}/file/getMyShare.do?page=${i}">${i}</a>
							&nbsp;
					</c:forEach>
				</c:when>

				<c:when test="${pageinfo.page<=3 && pageinfo.pagenumber>3}">
					<c:forEach var="i" begin="1" end="3">
						<a id="${i}"
							href="${pageContext.request.contextPath}/file/getMyShare.do?page=${i}">${i}</a>
					&nbsp;
					</c:forEach>
				</c:when>
				<c:when test="${pageinfo.page>3}">
					<c:forEach var="i" begin="${pageinfo.page-2}"
						end="${pageinfo.page}">
						<a  id="${i}"
							href="${pageContext.request.contextPath}/file/getMyShare.do?page=${i}">${i}</a>
					&nbsp;
					</c:forEach>
				</c:when>


			</c:choose>

				&nbsp;
			<c:if test="${pageinfo.page<pageinfo.pagenumber}">
				<a
					href="${pageContext.request.contextPath}/file/getMyShare.do?page=${pageinfo.page+1}"
					> <span>&raquo;</span>
				</a>
			</c:if>
			<c:if test="${pageinfo.page==pageinfo.pagenumber}">
				<a> 
				<span>&raquo;</span>
				</a>
			</c:if>
			&nbsp;&nbsp;
			<a href="${pageContext.request.contextPath}/file/getMyShare.do?page=${pageinfo.pagenumber}"> <span>尾页</span>
			</a>
	</div>
	
	
	
	<br>
	<table id="list_content">
			<thead>
				<tr>
					
					<td class="cont_pad_lef" width="40px">序号</td>
					<td class="cont_pad_lef" width="150px">分享的id</td>
					<td id="daxiao">文件名</td>
					<td id="riqi">分享日期</td>
					<td id="riqi">结束日期</td>
					<td id="riqi">链接</td>
					<td id="riqi">密码</td>
					<td id="riqi">删除</td>
				</tr>
			</thead>
			
			<tbody id="maintbody">
			
			<c:forEach items="${shareList}" var="shareList" varStatus="status" >
				<tr class="tr_listfile">
				
						<td class="a_listfile">
							${ (status.index + 1)+pageinfo.datanumber}
						</td>
						<td class="a_listfile">
							${shareList.shareid }
						</td>
						<td>
							${shareList.sharename }
						</td>
						<td>
					<fmt:formatDate value="${shareList.sharedate}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
					<td style="padding-left: 10px;">
						<c:if test="${shareList.shareoverdate==null}">
						永久有效
						</c:if>
						<c:if test="${shareList.shareoverdate!=null}">
						<fmt:formatDate value="${shareList.shareoverdate}" pattern="yyyy-MM-dd HH:mm"/>
						</c:if>
					</td>
					
						<td class="td_listfile">
							<%=basePath %>share/file/getShare/${shareList.sharefield }
						</td>
						<td style="padding-left: 10px;">
							<c:if test="${shareList.sharepassword==null }">
								公开
							</c:if>
							<c:if test="${shareList.sharepassword!=null }">
								${shareList.sharepassword }
							</c:if>
						</td>
						<td>
							<span class="deleteShareSpan">删除</span>
						</td>
				
					
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
	
</body>
</html>
