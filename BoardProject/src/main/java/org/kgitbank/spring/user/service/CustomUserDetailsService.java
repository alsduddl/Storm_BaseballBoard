package org.kgitbank.spring.user.service;

import org.kgitbank.spring.user.dao.IUserRepository;
import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final IUserRepository userRepository;
    
    @Autowired
    public CustomUserDetailsService(IUserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
        UserVO user = userRepository.getUserById(userId);
        if(user == null) {
            throw new UsernameNotFoundException(userId + " 사용자를 찾을 수 없습니다.");
        }
        return user;
    }
}
