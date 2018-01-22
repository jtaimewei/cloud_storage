package com.autumn.user.model;

import java.util.Date;

public class UserSession {
	    
    private String ip ;  //客户计算机的ip.   
      
    private String loginUserName; //客户登录名.   
        
    private Date onlineTime;   //客户登录系统时间. 

    
    
	public UserSession(String ip, String loginUserName, Date onlineTime) {
		super();
		this.ip = ip;
		this.loginUserName = loginUserName;
		this.onlineTime = onlineTime;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getLoginUserName() {
		return loginUserName;
	}

	public void setLoginUserName(String loginUserName) {
		this.loginUserName = loginUserName;
	}

	public Date getOnlineTime() {
		return onlineTime;
	}

	public void setOnlineTime(Date onlineTime) {
		this.onlineTime = onlineTime;
	}

	@Override
	public String toString() {
		return "OnlineSession [ip=" + ip + ", loginUserName=" + loginUserName + ", onlineTime=" + onlineTime + "]";
	}
        
    
     
       
      
   

	
    
}
