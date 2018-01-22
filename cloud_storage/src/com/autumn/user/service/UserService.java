package com.autumn.user.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.autumn.user.model.Message;
import com.autumn.user.model.User;

public interface UserService {

	public void registerUser(User user);

	

	public User findUserByName(String username);

	public User findUserBycode(String code);

	public void updateState(String username);

	public int findFolderid(User user);

	public List<String> findFriendList(String username);

	public void addMessage(Message message);

	public List<User> findUserMessages(String username);

	public void addFriend(Map<String, String> userMap);

	public void deleteMessages(Map<String, String> mMap);
	
	public ArrayList<User> getAllUser();
	
	public void deleteUser(String username);
	
	public void updateUser(User user);
	
	

}
