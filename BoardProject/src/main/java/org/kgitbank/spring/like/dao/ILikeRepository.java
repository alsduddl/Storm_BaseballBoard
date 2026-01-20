package org.kgitbank.spring.like.dao;

import org.apache.ibatis.annotations.Param;

public interface ILikeRepository {
	
	int checkLike(@Param("postId") int postId, @Param("userId") String userId);
	void deleteLike(@Param("postId") int postId, @Param("userId") String userId);
	void insertLike(@Param("postId") int postId, @Param("userId") String userId);
	int getLikeCount(@Param("postId") int postId);

}
