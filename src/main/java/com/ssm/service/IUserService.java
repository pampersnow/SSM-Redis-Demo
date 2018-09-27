package com.ssm.service;

import java.util.List;
import com.ssm.pojo.User;

/**
 * user表的操作接口
 * 
 */
public interface IUserService {

	/**
	 * 通过id查询user接口方法
	 * 
	 * @param userId
	 * @return User
	 */
	public User getUserById(Integer userId);

	/**
	 * 查询所有的user
	 * 
	 * @return 返回userList
	 */
	public List<User> getAllUser();

	/**
	 * 添加一个user
	 * 
	 * @param user
	 */
	public User insertUser(User user);

	/**
	 * 通过ID删除用户
	 * 
	 * @param id
	 * @return 
	 */
	public int deleteUser(int id);

	/**
	 * 通过关键字查询用户
	 * 
	 * @param keyWords
	 * @return
	 */
	public List<User> findUsers(String keyWords);

	/**
	 * 更新用户
	 * 
	 * @param user
	 * @return int
	 */
	public int editUser(User user);

	/**
	 * 查询网站注册用户数量(一小时更新一次)
	 * @return Integer
	 */
	public Integer selectUsersCount();

	/**
	 * 查询现有ID
	 * @return List<Integer>
	 */
	public List<Integer> selectNowIds();
}