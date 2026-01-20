package org.kgitbank.spring.admin.controller;

import org.kgitbank.spring.admin.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

//관리자 권한
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private IAdminService adminService;

	//관리자 페이지 접속하면 회원목록뜸 
    @GetMapping("/home")
    public String adminHome() {
        return "redirect:/admin/userlist"; 
    }
    
    //회원목록
    @GetMapping("/userlist")
    public String getuserList(Model model) {
    	model.addAttribute("userList", adminService.getUserList());
    	return "admin/userlist";
    }
    
    //회원목록에서 회원 삭제
    @PostMapping("/userlist/delete")
    public String deleteUser(@RequestParam String userId) {
    	if ("ADMIN".equals(userId)) {
            return "redirect:/admin/userlist";
        }
    	adminService.deleteUser(userId);
    	return "redirect:/admin/userlist";
    }
    
    //회원 상세 - 아이디 누르면 해당 회원이 작성한 게시글, 댓글 목록 
    @GetMapping("/user/detail")
    public String userDetail(@RequestParam String userId, Model model) {
        model.addAttribute("postList", adminService.getPostsByUser(userId));
        model.addAttribute("commentList", adminService.getCommentsByUser(userId));
        return "admin/userdetail";
    }
    
    //게시글 삭제
    @PostMapping("/post/delete")
    @ResponseBody
    public String deletePost(@RequestParam int postId) {
    	adminService.deletePost(postId);
    	return "success";
    }
    
    //댓글 삭제
    @PostMapping("/comment/delete")
    @ResponseBody
    public String deleteComment(@RequestParam int commentId) {
    	adminService.deleteComment(commentId);
    	return "success";
    }
    
}