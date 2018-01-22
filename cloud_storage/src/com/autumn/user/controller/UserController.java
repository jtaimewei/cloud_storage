package com.autumn.user.controller;




import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.autumn.commons.DateUtils;
import com.autumn.commons.UUIDUtils;
import com.autumn.file.service.FolderFileService;
import com.autumn.user.mail.UserMail;
import com.autumn.user.model.User;
import com.autumn.user.model.UserSession;
import com.autumn.user.service.UserService;
import com.autumn.user.session.SessionListener;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Resource
	private UserService userservice;
	
	@Resource
	private UserMail userMail;
	
	@Resource
	private  FolderFileService folderFileService;
	
	//注册前 ajax 验证用户名是否为空
	@RequestMapping("/checkName.do")
	public @ResponseBody int checkname(String username){
		
		User user= userservice.findUserByName(username);
		int msg=0;
		if(user!=null){
			
			msg=1;
		}
		
		return msg;
	}
	
	//注册-ajax
	@RequestMapping("/register.do")
	public @ResponseBody int registerUser(@RequestBody User user,HttpServletRequest request){
		try {
			user.setCode(UUIDUtils.getUUID()+UUIDUtils.getUUID());
			user.setState(0);
			userservice.registerUser(user);
			//给用户邮箱发送验证邮件
			String contextPath = request.getContextPath();   
			String basePath = request.getScheme()+"://"+request.getServerName()+":"+
			                request.getServerPort()+contextPath+"/";
			userMail.sendMail(user,basePath);
		} catch (Exception e) {
			return 0;
		}
		return 1;
	}
	
	//用户邮箱点击验证邮箱链接后
	@RequestMapping("emailChechInfo/{code}")
	public String emailChech(@PathVariable String code){
		System.out.println("验证链接为："+code);
		User user = userservice.findUserBycode(code);
		if(user==null){
			//邮箱验证失败返回到失败界面
			//response.sendRedirect("errorRegister.jsp"); 
			//return "forward:errorRegister";
			return "errorRegister";
		}
		//验证成功则修改用户的权限--并返回到登录界面
		userservice.updateState(user.getUsername());
		//用户验证成功后，给用户在文件系统中创建一个用户自己的文件夹。
		folderFileService.addUserFolder(user.getUsername());
		//return "forward:login";
		//response.sendRedirect("login.jsp");
		return "login";
	}
	
	//ajax 用户登录验证用户信息是否正确
	@RequestMapping("/login.do")
	public @ResponseBody int loginIn(String username,String password,HttpSession session,HttpServletRequest request){
		User user = userservice.findUserByName(username);
		int msg=0;//用户名不存在
		if(user!=null){
			if(user.getState()==0){
				msg=1;//用户未邮箱验证
			}
			else if(user.getState()==3){
				msg=2;//用户被冻结了
			}
			else if(!user.getPassword().equals(password)){
				msg=3;//用户密码不正确
			}else {
				session.setAttribute("user", user);
				//用户登录成功后加入session监听。
				session.setAttribute(SessionListener.LISTENER_NAME,new UserSession(request.getRemoteAddr(), user.getUsername(), DateUtils.getDATE()));
				if(user.getState()==1){
					msg=4;//普通用户登录成功
					//将用户根文件夹设置session
					int folderid= userservice.findFolderid(user);
					session.setAttribute("folderid",folderid);
				}
				else if (user.getState()==2) {
					msg=5;//管理员用户登录成功
				}
				
			}
		}
		System.out.println("---------------"+msg);
		return msg;
	}
	
	
	//临时测试路径
	@RequestMapping(value="/toMain.do",produces="text/html;charset=UTF-8;")
	public String goToMain(HttpSession session,Model model){
	
		String a="全部文件";
		model.addAttribute("subfolderfolder",a);
		return "redirect: /cloud_storage/file/listFileStructure.do?page=1&subfolderid=0";
	}
	
	//进入好友聊天界面
	@RequestMapping("/toChat.do")
	public String goChat(HttpSession session,Model model){
		User user= (User) session.getAttribute("user");
		//查找对应的所有好友
		/*List<String> list= userservice.findFriendList(user.getUsername());
		model.addAttribute("friendlist", list);*/
		//查找聊天记录
		List<User> userMessages=userservice.findUserMessages(user.getUsername());
		model.addAttribute("userMessages", userMessages);
		return "shared_dialog";
	}
	
	//查找用户的好友列表
	@RequestMapping("/toFriend.do")
	public @ResponseBody List<String>  findFriend(HttpSession session){
		 User user= (User) session.getAttribute("user");
		 List<String> listFriend= userservice.findFriendList(user.getUsername());
		
		return listFriend;
	}
	//添加好友判断用户名是否存在
	@RequestMapping("/findFriend.do")
	public @ResponseBody int findFriend(String username,HttpSession session){
		
		User user= userservice.findUserByName(username);
		if(user!=null){
			User user1= (User) session.getAttribute("user");
			List<String> list= userservice.findFriendList(user1.getUsername());
			for (String username1 : list) {
				if(username1.equals(username)){
					return 1;//表示已经添加了这个好友了
				}
			}
			return 2;//表示可以添加这个好友
			
			
		}
		
		return 0;//表示没有该用户名
	}
	//添加好友
	@RequestMapping("/addFriend.do")
	public @ResponseBody int addFriend(String friendname,HttpSession session) {
		// TODO Auto-generated method stub
		User user1= (User) session.getAttribute("user");
		Map<String,String> userMap=new HashMap<String,String>();
		userMap.put("username", user1.getUsername());
		userMap.put("friendname", friendname);
		userservice.addFriend(userMap);
		
		return 1;
	}
	//ajax 删除聊天记录
	@RequestMapping("/deleteMessage.do")
	public @ResponseBody int deleteMessage(String fromwho,HttpSession session){
		User user1= (User) session.getAttribute("user");
		Map<String,String> mMap=new HashMap<String,String>();
		mMap.put("towho", user1.getUsername());
		mMap.put("fromwho", fromwho);
		userservice.deleteMessages(mMap);
		return 1;
	}
	
	
	//用户退出-销毁当前用户的session
		@RequestMapping("/toLogout.do")
		public void logout(HttpServletResponse response,HttpSession session) throws IOException{
			
				session.invalidate() ;
				 //此方法可以销毁当前用户创建的所有session;
				response.sendRedirect("/cloud_storage/login.jsp");//如果是普通用户则返回到房屋主界面
			
			 
			
		}
	
	
	
	
	
}
