package org.kgitbank.spring.post.vo;

import java.util.Date;

public class PostVO {
	private int postId;
	private String userId;
	private String title;
	private String content;
	private String seatInfo;
	private Integer  cheerScore;
	private Integer  satisfactionScore;
	private Date contentDate;
	
	private int userPostNum;
	
	private int likeCount;
	
	private String isNotice;
	
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSeatInfo() {
		return seatInfo;
	}
	public void setSeatInfo(String seatInfo) {
		this.seatInfo = seatInfo;
	}
	public Integer getCheerScore() {
		return cheerScore;
	}
	public void setCheerScore(Integer cheerScore) {
		this.cheerScore = cheerScore;
	}
	public Integer getSatisfactionScore() {
		return satisfactionScore;
	}
	public void setSatisfactionScore(Integer satisfactionScore) {
		this.satisfactionScore = satisfactionScore;
	}
	public Date getContentDate() {
		return contentDate;
	}
	public void setContentDate(Date contentDate) {
		this.contentDate = contentDate;
	}
	public int getUserPostNum() {
		return userPostNum;
	}
	public void setUserPostNum(int userPostNum) {
		this.userPostNum = userPostNum;
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
	
}
