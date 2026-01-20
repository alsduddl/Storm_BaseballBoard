package org.kgitbank.spring.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kgitbank.spring.comment.vo.CommentVO;

public interface ICommentRepository {

	void writeComment(CommentVO comment);
	List<CommentVO> getCommentList(int postId);
	int updateComment(CommentVO comment);
	int deleteComment(@Param("commentId") int commentId, @Param("userId") String userId);
	CommentVO getCommentById(int commentId);
	List<CommentVO> getMyCommentList(String userId);
	
}
