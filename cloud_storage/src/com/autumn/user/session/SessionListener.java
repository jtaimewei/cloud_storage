package com.autumn.user.session;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import com.autumn.user.model.UserSession;

public class SessionListener implements HttpSessionAttributeListener {
	
	
	

     // 定义监听的session属性名.  
      
    public final static String LISTENER_NAME = "_login";    
        
   
     // 定义存储客户登录session的集合.  
     
    private static List<UserSession> sessions = new ArrayList<UserSession>();    
    
    
     // 加入session时的监听方法.  
     

	@Override
	public void attributeAdded(HttpSessionBindingEvent sbe) {
		// TODO Auto-generated method stub
		
		if (LISTENER_NAME.equals(sbe.getName())) {
			System.out.println("session的东西"+sbe.getName());
			System.out.println("session的LISTENER_NAME"+LISTENER_NAME);
			System.out.println("对象的集合："+sbe.getValue());
            sessions.add((UserSession) sbe.getValue());    
        }  
	}
	
    // session失效时的监听方法.  
	@Override
	public void attributeRemoved(HttpSessionBindingEvent sbe) {
		// TODO Auto-generated method stub
		if (LISTENER_NAME.equals(sbe.getName())) {
			System.out.println("注销的对象是什么呢："+sbe.getValue());
            sessions.remove(sbe.getValue());    
        }
	}
	
 
    // session覆盖时的监听方法.  
     
	@Override
	public void attributeReplaced(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub

	}
	
	 
     // 返回客户登录session的集合.  
       
    public static List<UserSession> getSessions() {    
        return sessions;    
    }

}
