 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<jsp:include page="include_file2.jsp"></jsp:include>
<link href="./blue.monday/css/jplayer.blue.monday.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./js/jquery.min.js"></script>
<script type="text/javascript" src="./js/jquery.jplayer.min.js"></script>	
<style type="text/css">
/* 视频音乐播放位置 */
	#playDiv{
	position: fixed;
	left: 100px;
	
	
	}

</style>
<script type="text/javascript">
$(function(){
	$("#jquery_jplayer_1").jPlayer({
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
	});
	$("#jquery_jplayer_2").jPlayer({
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
	});
	
});

</script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="playDiv">
		 <div id="jquery_jplayer_1" class="jp-jplayer"></div>
		  <div id="jp_container_1" class="jp-audio" role="application" aria-label="media player" >
		  关闭
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
		  <div id="jp_container_2" class="jp-video jp-video-360p" role="application" aria-label="media player">
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