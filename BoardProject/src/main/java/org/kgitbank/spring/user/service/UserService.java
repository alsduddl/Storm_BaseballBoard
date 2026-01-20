package org.kgitbank.spring.user.service;

import org.kgitbank.spring.user.dao.IUserRepository;
import org.kgitbank.spring.user.dto.JoinDTO;
import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService implements IUserService{

	@Autowired
	private IUserRepository userRepository;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
		
	@Override
	public void joinUser(JoinDTO joinDTO) {
		UserVO user = new UserVO();
	    user.setUserId(joinDTO.getUserId());
	    user.setPassword(passwordEncoder.encode(joinDTO.getPassword()));
	    user.setUserName(joinDTO.getUserName());
	    user.setEmail(joinDTO.getEmail());
	    user.setPhoneNumber(joinDTO.getPhoneNumber());
	    user.setNickname(joinDTO.getNickname());
	    user.setRole("USER");

	    userRepository.insertUser(user);		
	}
	
	@Override
	public void insertAuth(String userId) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public UserVO getUserById(String userId) {
		if(userId == null || userId.isEmpty()) {
	        throw new IllegalArgumentException("userId가 null입니다");
	    }
	    return userRepository.getUserById(userId);
	}
	
	@Override
	public UserVO getUserInfo(String userId) {	
		return userRepository.getUserById(userId);
	}
	
	@Override
	public boolean checkPassword(String userId, String password) {
		UserVO user = userRepository.getUserById(userId);
		if(user == null ) {
			throw new RuntimeException("계정정보가 다릅니다.");
		}
		return passwordEncoder.matches(password, user.getPassword());
	}

	@Override
	public UserVO login(String userId) {
		return userRepository.getUserById(userId);
	}

	@Override
	public int getuserIdCount(String userId) {
		return userRepository.getuserIdCount(userId);
	}

	@Override
	public int getnicknameCount(String nickname) {
		return userRepository.getnicknameCount(nickname);
	}


}
