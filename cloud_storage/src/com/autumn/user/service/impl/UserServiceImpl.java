package com.autumn.user.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.autumn.user.dao.UserDao;
import com.autumn.user.model.Message;
import com.autumn.user.model.User;
import com.autumn.user.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userdao;
	@Override
	public void registerUser(User user) {
		// TODO Auto-generated method stub
		userdao.registerUser(user);
	}
	
	@Override
	public User findUserByName(String username) {
		// TODO Auto-generated method stub
		return userdao.findUserByName(username);
	}
	@Override
	public User findUserBycode(String code) {
		// TODO Auto-generated method stub
		return userdao.findUserBycode(code);
	}
	@Override
	public void updateState(String username) {
		// TODO Auto-generated method stub
		userdao.updateState(username);
	}
	@Override
	public int findFolderid(User user) {
		// TODO Auto-generated method stub
		return userdao.findFolderid(user);
	}
	@Override
	public List<String> findFriendList(String username) {
		// TODO Auto-generated method stub
		List<String> list1=userdao.findFriendList1(username);
		List<String> list2=userdao.findFriendList2(username);
		for (String string : list2) {
			list1.add(string);
		}
		
		return list1;
	}
	@Override
	public void addMessage(Message message) {
		// TODO Auto-generated method stub
		userdao.addMessage(message);
	}
	@Override
	public List<User> findUserMessages(String username) {
		// TODO Auto-generated method stub
		return userdao.findUserMessages(username);
	}

	@Override
	public void addFriend(Map<String, String> userMap) {
		// TODO Auto-generated method stub
		userdao.addFriend(userMap);
	}

	@Override
	public void deleteMessages(Map<String, String> mMap) {
		// TODO Auto-generated method stub
		userdao.deleteMessages(mMap);
	}

	@Override
	public ArrayList<User> getAllUser() {
		// TODO Auto-generated method stub
		return userdao.getAllUser();
	}

	@Override
	public void deleteUser(String username) {
		// TODO Auto-generated method stub
		userdao.deleteUser(username);
	}

	@Override
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		userdao.updateUser(user);
	}

	
	

}
