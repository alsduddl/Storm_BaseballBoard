package org.kgitbank.spring.comment.service;

import java.util.List;

import org.kgitbank.spring.comment.dao.ICommentRepository;
import org.kgitbank.spring.comment.vo.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService implements ICommentService{
	
	@Autowired
	private ICommentRepository commentRepository;
	
	@Override
	public void writeComment(CommentVO comment) {
		commentRepository.writeComment(comment);
	}

	@Override
	public List<CommentVO> getCommentList(int postId) {
		return commentRepository.getCommentList(postId);
	}

	@Override
	public int updateComment(CommentVO comment) {
		return commentRepository.updateComment(comment);
	}

	@Override
	public int deleteComment(int commentId, String userId) {
		return commentRepository.deleteComment(commentId, userId);
	}

	@Override
	public CommentVO getCommentById(int commentId) {
		return commentRepository.getCommentById(commentId);
	}

	@Override
	public List<CommentVO> getMyCommentList(String userId) {
		return commentRepository.getMyCommentList(userId);
	}

}
