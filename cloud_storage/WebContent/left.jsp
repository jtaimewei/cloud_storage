<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="include_file1.jsp"></jsp:include>
<body>
<div id="body_left">
    <ul id="ul_body_left">
        <li id="quanbuwenjian" class="li_bgcolor"><a href="${pageContext.request.contextPath}/file/listFileStructure.do?page=1&subfolderid=0&subfolderfolder=全部文件" id="a_body_quanbuwenjian" class="li_color">全部文件</a></li>
        <li><a href="${pageContext.request.contextPath}/file/listPicture.do">图片</a></li>
        <li><a href="${pageContext.request.contextPath}/file/listDocument.do">文档</a></li>
        <li><a href="${pageContext.request.contextPath}/file/listVideo.do">视频</a></li>
        <li><a href="${pageContext.request.contextPath}/file/listMusic.do">音乐</a></li>
        <li><a href="${pageContext.request.contextPath}/file/listOthers.do">其他</a></li>
        <li><a id="a_body_fenxiang" class="a_body_left" href="${pageContext.request.contextPath}/file/getMyShare.do?page=1">我的分享</a></li>
        <li><a href="${pageContext.request.contextPath}/file/listRecycle.do" id="a_body_huishouzhan" class="a_body_left">回收站</a></li>
    </ul>
</div>
</body>
</html>