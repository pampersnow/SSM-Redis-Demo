package com.ssm.pojo;

import java.io.Serializable;

/**
 * User实体类对应数据库中的tb_user表
 * 
 * 要想使用redis存对象，一定要让实体类实现Serializable(序列化)接口，否则会报错。
 */
public class User implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = -5244288298702801619L;
    private int id;
    private String userName;
    private String sex;
    private int age;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getsex() {
        return sex;
    }

    public void setsex(String sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", userName=" + userName + ", sex=" + sex + ", age=" + age + "]";
    }
}