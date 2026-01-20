package org.kgitbank.spring.admin.service;

import java.util.List;

import org.kgitbank.spring.admin.dao.IAdminRepository;
import org.kgitbank.spring.comment.vo.CommentVO;
import org.kgitbank.spring.post.vo.PostVO;
import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService implements IAdminService{
	
	@Autowired
	private IAdminRepository adminRepository;

	@Override
	public List<UserVO> getUserList() {
		return adminRepository.getUserList();
	}

	@Override
	public void deleteUser(String userId) {
		if ("admin".equals(userId)) {
	        throw new IllegalStateException("관리자 계정은 삭제 불가");
	    }
		adminRepository.deleteUser(userId);
	}

	@Override
	public List<PostVO> getPostsByUser(String userId) {
		return adminRepository.getPostsByUser(userId);
	}

	@Override
	public List<CommentVO> getCommentsByUser(String userId) {
		return adminRepository.getCommentsByUser(userId);
	}

	@Override
	public void deletePost(int postId) {
		adminRepository.deletePost(postId);
	}

	@Override
	public void deleteComment(int commentId) {
		adminRepository.deleteComment(commentId);
	}	

}
