package org.kgitbank.spring.post.vo;

import java.util.Date;

public class PostListVO {
	private int postListSn;
	private int postId;
	private String title;
	private String userId;
	private Date contentDate;
	
	private int likeCount;
	private String isNotice;
	private String userRole;
	
	public int getPostListSn() {
		return postListSn;
	}
	public void setPostListSn(int postListSn) {
		this.postListSn = postListSn;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getContentDate() {
		return contentDate;
	}
	public void setContentDate(Date contentDate) {
		this.contentDate = contentDate;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getIsNotice() {
		return isNotice;
	}
	public void setIsNotice(String isNotice) {
		this.isNotice = isNotice;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	
	
}
