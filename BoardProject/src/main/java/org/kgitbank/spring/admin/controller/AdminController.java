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

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private IAdminService adminService;

    @GetMapping("/home")
    public String adminHome() {
        return "redirect:/admin/userlist"; 
    }
    
    @GetMapping("/userlist")
    public String getuserList(Model model) {
    	model.addAttribute("userList", adminService.getUserList());
    	return "admin/userlist";
    }
    
    @PostMapping("/userlist/delete")
    public String deleteUser(@RequestParam String userId) {
    	if ("ADMIN".equals(userId)) {
            return "redirect:/admin/userlist";
        }
    	adminService.deleteUser(userId);
    	return "redirect:/admin/userlist";
    }
    
    @GetMapping("/user/detail")
    public String userDetail(@RequestParam String userId, Model model) {
        model.addAttribute("postList", adminService.getPostsByUser(userId));
        model.addAttribute("commentList", adminService.getCommentsByUser(userId));
        return "admin/userdetail";
    }
    
    @PostMapping("/post/delete")
    @ResponseBody
    public String deletePost(@RequestParam int postId) {
    	adminService.deletePost(postId);
    	return "success";
    }
    
    @PostMapping("/comment/delete")
    @ResponseBody
    public String deleteComment(@RequestParam int commentId) {
    	adminService.deleteComment(commentId);
    	return "success";
    }
    
}