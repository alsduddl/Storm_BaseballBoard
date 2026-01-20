package org.kgitbank.spring.post.service;

import java.util.List;

import org.kgitbank.spring.like.dao.ILikeRepository;
import org.kgitbank.spring.post.dao.IPostRepository;
import org.kgitbank.spring.post.vo.PostListVO;
import org.kgitbank.spring.post.vo.PostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostService implements IPostService{

	@Autowired
	public IPostRepository postRepository;
	
	@Autowired
	public ILikeRepository likeRepository;
	
	@Override
	public List<PostVO> getUserPost(String userId) {
		return postRepository.getUserPost(userId);
	}

	@Override
	public void insertPost(PostVO post) {
		postRepository.insertPost(post);	
	}

	@Override
	public List<PostListVO> getPostList() {
		return postRepository.getPostList();
	}

	@Override
	public PostVO getPostDetail(int postId) {
		PostVO post = postRepository.getPostDetail(postId);
	    if (post != null) {
	        int likeCount = likeRepository.getLikeCount(postId);
	        post.setLikeCount(likeCount);
	    }

	    return post;
	}

	@Override
	public void updatePost(PostVO post) {
		postRepository.updatePost(post);
	}

	@Override
	public void deletePost(int postId) {
		postRepository.deletePost(postId);
	}

	@Override
	public List<PostListVO> getUserPostList(String userId) {
		return postRepository.getUserPostList(userId);
	}

	@Override
	public List<PostListVO> getTopLikePost() {
		return postRepository.getTopLikePost();
	}

	@Override
	public List<PostListVO> getMainPostList() {
		return postRepository.getMainPostList();
	}

}
