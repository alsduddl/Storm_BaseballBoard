package org.kgitbank.spring.user.service;

import org.kgitbank.spring.user.dto.JoinDTO;
import org.kgitbank.spring.user.vo.UserVO;

public interface IUserService {
	
	void joinUser(JoinDTO joinDTO);
	void insertAuth(String userId);
	UserVO getUserById(String userId);
	UserVO getUserInfo(String userId);
	boolean checkPassword(String userId, String password);
	UserVO login(String userId);
	int getuserIdCount(String userId);
	int getnicknameCount(String nickname);
	
	
}
