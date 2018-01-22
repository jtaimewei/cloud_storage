package com.autumn.user.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.autumn.user.model.Message;
import com.autumn.user.model.User;

public interface UserDao {

	public void registerUser(User user);

	public List<User> findUserBySome(List<String> list);

	public List<Map<String, Object>> testArray();

	public User findUserByName(String username);

	public User findUserBycode(String code);

	public void updateState(String username);

	public int findFolderid(User user);

	public List<String> findFriendList1(String username);
	public List<String> findFriendList2(String username);

	public void addMessage(Message message);

	public List<User> findUserMessages(String username);

	public void addFriend(Map<String, String> userMap);

	public void deleteMessages(Map<String, String> mMap);
	
	public ArrayList<User> getAllUser();
	
	public void deleteUser(String username);
	
	public void updateUser(User user);
	

}
