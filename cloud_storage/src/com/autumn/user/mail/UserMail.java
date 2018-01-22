package com.autumn.user.mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;

import com.autumn.user.model.User;

@Component
public class UserMail {
	private static String HOST="smtp.qq.com";
	private static String SMTP="smtp";
	private static String PORT="587";
	private static String MAILTITLE="autumn向您发送验证码";
	private static String USER="2939009859@qq.com";
	private static String PASSWORD="dgemhajipesodcjd";
	public void sendMail(User user,String basePath){

		
		Properties props=new Properties();
        props.put("mail.transport.protocol", SMTP);
		props.put("mail.smtp.host", HOST);
		props.put("mail.smtp.port",PORT );
		props.put("mail.smtp.auth", "true");
		props.put("mail.user",USER);
		props.put("mail.password", PASSWORD);
		Authenticator authenticator=new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				String userName=props.getProperty("mail.user");
				String password=props.getProperty("mail.password");
				
				return new PasswordAuthentication(userName,password);
			}
		};
		Session session =Session.getInstance(props,authenticator);
		MimeMessage message=new MimeMessage(session);
		try {
			message.setFrom(new InternetAddress(props.getProperty("mail.user")));
			
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
			
			message.setSubject(MAILTITLE);
			message.setContent("<h1>来自Autumn网盘用户注册激活邮件,正在为用户名为:"+user.getUsername()+"的用户进行邮箱激活,激活请点击链接:</h1><h3><a href='"+basePath+"email/user/emailChechInfo/"
					+ user.getCode() + "'>"+basePath+"email/user/emailChechInfo/" + user.getCode() + " </a></3>",
			"text/html;charset=utf-8");
			message.setSentDate(new Date());
			message.saveChanges();
			Transport transport=session.getTransport();
			transport.send(message);
			transport.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}
}
