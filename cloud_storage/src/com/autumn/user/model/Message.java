package com.autumn.user.model;

import java.util.Date;

public class Message {
	private int messageid;
    private String fromwho;
    private String towho;
    private String messagetext;
    private int friendMessage;//0：表示普通消息 1：表示好友请求消息
    private Date messagedate;
    
    
    
	
	public int getFriendMessage() {
		return friendMessage;
	}
	public void setFriendMessage(int friendMessage) {
		this.friendMessage = friendMessage;
	}
	public int getMessageid() {
		return messageid;
	}
	public void setMessageid(int messageid) {
		this.messageid = messageid;
	}
	public String getFromwho() {
		return fromwho;
	}
	public void setFromwho(String fromwho) {
		this.fromwho = fromwho;
	}
	public String getTowho() {
		return towho;
	}
	public void setTowho(String towho) {
		this.towho = towho;
	}
	public String getMessagetext() {
		return messagetext;
	}
	public void setMessagetext(String messagetext) {
		this.messagetext = messagetext;
	}
	public Date getMessagedate() {
		return messagedate;
	}
	public void setMessagedate(Date messagedate) {
		this.messagedate = messagedate;
	}
	@Override
	public String toString() {
		return "Message [messageid=" + messageid + ", fromwho=" + fromwho + ", towho=" + towho + ", messagetext="
				+ messagetext + ", friendMessage=" + friendMessage + ", messagedate=" + messagedate + "]";
	}
	
    
    

}
