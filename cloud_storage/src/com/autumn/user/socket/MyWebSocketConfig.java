package com.autumn.user.socket;

import javax.annotation.Resource;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Component
@EnableWebSocket
public class MyWebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer{

	@Resource
	private MyWebSocketHandler handler;
	
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
		// TODO Auto-generated method stub
		//添加websocket处理器，添加握手拦截器
		System.out.println("连接入口");
		webSocketHandlerRegistry.addHandler(handler, "/ws").addInterceptors(new MyHandShakeInterceptor());
		System.out.println("进入拦截器");
		//添加websocket处理器，添加握手拦截器
		webSocketHandlerRegistry.addHandler(handler, "/ws/sockjs").addInterceptors(new MyHandShakeInterceptor()).withSockJS();
	}
	
	
	

}
