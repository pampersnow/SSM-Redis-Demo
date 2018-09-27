package com.ssm.dao;

import java.util.List;
import com.ssm.pojo.User;


public interface UserMapper {

    public User selectByPrimaryKey(Integer userId);

    public List<User> selectAllUser();

    public int insertUser(User user);

    public int deleteUser(int id);

    public List<User> findUsers(String keyWords);

    public int editUser(User user);

	public Integer selectUsersCount();

	public List<Integer> selectIds();
}