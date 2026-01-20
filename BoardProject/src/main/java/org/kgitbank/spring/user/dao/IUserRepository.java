package org.kgitbank.spring.user.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.kgitbank.spring.user.vo.UserVO;

@Mapper
public interface IUserRepository {

	void insertUser(UserVO user);
	void insertAuth(String userId);
	UserVO getUserById(@Param("userId") String userId);
	int getuserIdCount(String userId);
	int getnicknameCount(String nickname);
}
