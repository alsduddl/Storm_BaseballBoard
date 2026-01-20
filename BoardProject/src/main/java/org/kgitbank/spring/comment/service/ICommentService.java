package org.kgitbank.spring.comment.service;

import java.util.List;

import org.kgitbank.spring.comment.vo.CommentVO;

public interface ICommentService {

	void writeComment(CommentVO comment);
	List<CommentVO> getCommentList(int postId);
	int updateComment(CommentVO comment);
	int deleteComment(int commentId, String userId);
	CommentVO getCommentById(int commentId);
	List<CommentVO> getMyCommentList(String userId);

}
