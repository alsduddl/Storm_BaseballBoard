package org.kgitbank.spring.user.dto;

import javax.validation.constraints.Pattern;

public class JoinDTO {
	
	@Pattern(regexp ="^[a-zA-Z0-9]{4,20}$", message = "아이디는 4~20자의 영문 또는 숫자 조합이어야 합니다.")
	private String userId;
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,20}$", message = "비밀번호는 8~20자이며 영문, 숫자, 특수문자(@$!%*#?&)를 포함해야 합니다.")
	private String password;
	private String userName;
	@Pattern(regexp="[a-zA-Z0-9]*@[a-zA-Z]*\\..*", message="이메일 양식에 맞춰주세요.")
	private String email;
	@Pattern(regexp="^010-\\d{4}-\\d{4}$", message="전화번호 양식에 맞춰주세요.")
	private String phoneNumber;	
	@Pattern(regexp = "^[a-zA-Z0-9가-힣]{2,12}$", message = "닉네임은 2~12자의 한글, 영문 또는 숫자만 가능합니다.")
	private String nickname;
	private String role = "ROLE_USER";
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
}
