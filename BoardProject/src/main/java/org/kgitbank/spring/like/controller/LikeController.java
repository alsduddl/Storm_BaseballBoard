package org.kgitbank.spring.like.controller;

import org.kgitbank.spring.like.service.ILikeService;
import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/like")
public class LikeController {
	
	@Autowired
	private ILikeService likeService;
	
	//좋아요누른 게시글 목록 조회 - 버튼 동작
	@PostMapping("/toggle")
	public int toggleLike(@RequestParam int postId, Authentication authentication) {
	    UserVO user = (UserVO) authentication.getPrincipal();
	    return likeService.toggleLike(postId, user.getUserId());
	}
}
