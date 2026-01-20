package org.kgitbank.spring.post.dao;

import java.util.List;

import org.kgitbank.spring.post.vo.PostListVO;
import org.kgitbank.spring.post.vo.PostVO;

public interface IPostRepository {
	
	List<PostVO> getUserPost(String userId);  //마이페이지에서 자신의 글 확인
	void insertPost(PostVO post);
	List<PostListVO> getPostList();
	PostVO getPostDetail(int postId);
	void updatePost(PostVO post);
	void deletePost(int postId);
	List<PostListVO> getUserPostList(String userId);
	List<PostListVO> getTopLikePost();
	List<PostListVO> getMainPostList();

}
