package com.autumn.user.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.autumn.user.model.User;
import com.autumn.user.model.UserSession;
import com.autumn.user.service.UserService;
import com.autumn.user.session.SessionListener;


@Controller
@RequestMapping("/manager")
public class ManagerController {
	@Resource
	private UserService userservice;
	
	@RequestMapping("/getAllUser.do")
	public String getAllUser(Model model){
		if(userservice==null){
			System.out.println("hel");
		}
		ArrayList<User> user=userservice.getAllUser();
		model.addAttribute("userlist",user);
		return "back_main";
	}
	
	@RequestMapping("/deleteUser.do")
	public String deleteUser(HttpServletRequest req){
		userservice.deleteUser(req.getParameter("un"));
		return "redirect: /cloud_storage/manager/getAllUser.do";
	}
	
	@RequestMapping("/updateUser.do")
	public String updateUser(HttpServletRequest req){
		User u=new User();
		u.setUsername(req.getParameter("un"));
		u.setPassword(req.getParameter("pw"));
		u.setEmail(req.getParameter("em"));
		u.setState(Integer.parseInt(req.getParameter("stat")));
		System.out.println("----"+u.getState());
		userservice.updateUser(u);
		return "redirect: /cloud_storage/manager/getAllUser.do";
	}
	
	@RequestMapping("/getUserAccess.do")
	public String getUserAccess(Model model){
		List<UserSession> list=SessionListener.getSessions();
		
		model.addAttribute("userSessionList",list);
		return "accessManage";
	}
	
	
}
