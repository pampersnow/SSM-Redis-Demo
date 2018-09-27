package com.ssm.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ssm.pojo.User;
import com.ssm.service.IUserService;

/**
 * user控制器
 * 
 */

@Controller
@RequestMapping("/UserCRUD")
public class UserController {

    @Resource
    private IUserService userService;
    
    @SuppressWarnings("rawtypes")
	@Resource
    private RedisTemplate redisTemplate;
    

    /**
     * 统计注册用户总数
     * @param null
     * @return String
     * @throws Exception 
     */
    
    @SuppressWarnings("unchecked")
	@RequestMapping("/indexMSG")
    public String getIndexMSG(Model model) throws Exception{
    	String usersCount = null;
    	
    	//尝试从缓存中取数据
    	usersCount = (String) redisTemplate.opsForValue().get("users_count");
    	
    	if(usersCount == null){
    		//redis缓存中无数据，从数据库中查询，并放入redis缓存中，设置生存时间为1小时
    		System.out.println("从数据库中取当前已注册用户数量");
    		usersCount = Integer.toString(userService.selectUsersCount());
    		redisTemplate.opsForValue().set("users_count", usersCount, 1, TimeUnit.HOURS);
    	} else {
    		System.out.println("从redis缓存中取当前已注册用户数量");
    		System.out.println("拿到的数据："+usersCount);
    	}
    	
    	List<Integer> ids = null;
    	ids = userService.selectNowIds();
    	
    	model.addAttribute("usersCount", usersCount);
    	model.addAttribute("ids", ids);
    	return "forward:/index.jsp";
    }
    
    /**
     * 通过ID查询User
     * 
     * @param userId
     * @param model
     * @return String
     */
    @RequestMapping(value = "/getUserById", method = RequestMethod.GET)
    public String getUserById(Model model, Integer userId) {
    	System.out.println("**********getUserById********");
    	User user = userService.getUserById(userId);
    	model.addAttribute("user", user); // 填充数据到model
    	return "showUser";
    }
    
    /**
     * 查询所有User
     * 
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value = "/showUser", method = RequestMethod.GET)
    public String showUsers(Model model) {
        System.out.println("**********showUsers********");
        List<User> userList = new ArrayList<User>();
        userList = userService.getAllUser();
        model.addAttribute("userList", userList); // 填充数据到model
        return "showUser";
    }

    /**
     * 增加一个用户
     * 
     * @param userName
     * @param sex
     * @param age
     * @throws Exception 
     */
    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public void addUser(User user, HttpServletResponse response) throws Exception {
        System.out.println("******addUser********");
        User result = userService.insertUser(user);
        if (result.getId() != 0) {
			response.getWriter().print("OK");
		} else {
			response.getWriter().print("FAIL");
		}
    }

    /**
     * 通过userID删除用户
     * 
     * @param userID
     * @throws Exception 
     */
    @RequestMapping(value = "/delUser/{userID}", method = RequestMethod.POST)
    public void delUser(@PathVariable int userID, HttpServletResponse response) throws Exception {
        System.out.println(userID);
        int i = userService.deleteUser(userID);
        if(i == 1){
        	response.getWriter().print("OK");
        }else{
        	response.getWriter().print("删除失败！");
        }
        
    }

    /**
     * 查询用户
     * 
     * @param model
     * @param keyWords
     * @return
     */
    @RequestMapping("/search")
    public ModelAndView findUsers(String keyWords) {
        System.out.println(keyWords);
        ModelAndView mv = new ModelAndView();
        List<User> userList = new ArrayList<User>();
        userList = userService.findUsers(keyWords);
        
        mv.addObject("userList", userList);
        mv.setViewName("showUser");

        return mv;
    }
    
    /**
     * 更新用户信息
     * @param userName
     * @param sex
     * @param age
     * @param id
     * @return
     * @throws Exception 
     */
    @RequestMapping(value="/editUser",method=RequestMethod.POST)
    public void editUser(int id, String name, String sex, int age, HttpServletResponse res) throws Exception {
    	User user = new User();
    	user.setId(id);
    	user.setAge(age);
    	user.setsex(sex);
    	user.setUserName(name);
    	System.out.println(user.toString());
        int rows = userService.editUser(user);
        if(rows == 1){
        	res.getWriter().print("OK");
        } else {
        	res.getWriter().print("FAIL");
        }
    }
    
    
    
    
}






