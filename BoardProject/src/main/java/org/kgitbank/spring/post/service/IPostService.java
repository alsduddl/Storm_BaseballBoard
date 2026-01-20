package org.kgitbank.spring.post.service;

import java.util.List;

import org.kgitbank.spring.post.vo.PostListVO;
import org.kgitbank.spring.post.vo.PostVO;

public interface IPostService {

	List<PostVO> getUserPost(String userId);
	void insertPost(PostVO post);
	List<PostListVO> getPostList();
	PostVO getPostDetail(int postId);
	void updatePost(PostVO post);
	void deletePost(int postId);
	List<PostListVO> getUserPostList(String userId);
	List<PostListVO> getTopLikePost();
	List<PostListVO> getMainPostList();

}
