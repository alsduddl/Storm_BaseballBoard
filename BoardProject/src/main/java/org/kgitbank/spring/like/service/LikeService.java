package org.kgitbank.spring.like.service;

import org.kgitbank.spring.like.dao.ILikeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikeService implements ILikeService{
	
	@Autowired
	public ILikeRepository likeRepository;

	@Override
	public int toggleLike(int postId, String userId) {
		int pushlike = likeRepository.checkLike(postId, userId);
		if(pushlike == 0) {
			likeRepository.insertLike(postId, userId);			
		} else {
			likeRepository.deleteLike(postId, userId);
		}
		return likeRepository.getLikeCount(postId);
	}

}
