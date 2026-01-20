package org.kgitbank.spring.admin.dao;

import java.util.List;

import org.kgitbank.spring.comment.vo.CommentVO;
import org.kgitbank.spring.post.vo.PostVO;
import org.kgitbank.spring.user.vo.UserVO;

public interface IAdminRepository {
	
	List<UserVO> getUserList();
    void deleteUser(String userId);
    List<PostVO> getPostsByUser(String userId);
    List<CommentVO> getCommentsByUser(String userId);
    void deletePost(int postId);
	void deleteComment(int commentId);
	
}
