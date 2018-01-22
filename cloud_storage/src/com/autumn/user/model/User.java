package com.autumn.user.model;

import java.util.List;

public class User {
	
	private String username;/*用户姓名*/
	private String password;/*用户密码*/
	private int    state;	/*用户权限,0表示未注册，1表示已经注册*/
	private String code;	/*邮箱验证码-用户权限为0则数据库存储,用户权限为1数据库code为null*/
	private String email;	/*邮箱*/
	private List<Message> messages;
	
	public List<Message> getMessages() {
		return messages;
	}
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password + ", state=" + state + ", code=" + code
				+ ", email=" + email + "]";
	}
	
	
	
}
