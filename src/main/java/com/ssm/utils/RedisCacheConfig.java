package com.ssm.utils;

import java.lang.reflect.Method;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.interceptor.KeyGenerator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * 通过spring管理redis缓存配置
 * 
 * @author Administrator
 *
 */
@Configuration
@EnableCaching
public class RedisCacheConfig extends CachingConfigurerSupport {

	/*
	 * 使用volatile关键字
	 * 当多个线程进行操作共享数据时，可以保证内存中的数据可见。底层原理：内存栅栏。
	 * 使用volatile关键字修饰时，可理解为对数据的操作都在主存中进行。
	 * 相较于synchronized是一种较为轻量级的同步策略。
	 * 
	 * 注意：
	 * volatile不具备“互斥性” volatile不能保证变量的“原子性”
	 */
	private volatile JedisConnectionFactory jedisConnectionFactory;
	private volatile RedisTemplate<String, String> redisTemplate;
	private volatile RedisCacheManager redisCacheManager;

	public RedisCacheConfig() {
		super();
	}

	/**
	 * 带参数的构造方法 初始化所有的成员变量
	 * 
	 * @param jedisConnectionFactory
	 * @param redisTemplate
	 * @param redisCacheManager
	 */
	public RedisCacheConfig(JedisConnectionFactory jedisConnectionFactory,
			RedisTemplate<String, String> redisTemplate,
			RedisCacheManager redisCacheManager) {
		this.jedisConnectionFactory = jedisConnectionFactory;
		this.redisTemplate = redisTemplate;
		this.redisCacheManager = redisCacheManager;
	}

	public JedisConnectionFactory getJedisConnecionFactory() {
		return jedisConnectionFactory;
	}

	public RedisTemplate<String, String> getRedisTemplate() {
		return redisTemplate;
	}

	public RedisCacheManager getRedisCacheManager() {
		return redisCacheManager;
	}

	/**
	 * 定义自动生成的redis key的规则
	 * 
	 * @param target
	 *            目标实例
	 * @param method
	 *            方法被调用的方法
	 * @param objects
	 *            方法参数(扩展任何 var-args)
	 * @return 返回生成的键
	 * */
	@Bean
	public KeyGenerator keyGenerator() {
		return new KeyGenerator() {
			@Override
			public Object generate(Object target, Method method,
					Object... objects) {
				StringBuilder sb = new StringBuilder();
				// sb.append(target.getClass().getName());
				sb.append(method.getName());
				if (objects.length != 0) {
					sb.append("_");
					for (Object obj : objects) {
						sb.append(obj.toString());
					}
				}
				return sb.toString();
			}
		};
	}
}