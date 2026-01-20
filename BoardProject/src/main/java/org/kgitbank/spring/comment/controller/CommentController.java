package org.kgitbank.spring.comment.controller;

import java.security.Principal;
import org.kgitbank.spring.comment.service.ICommentService;
import org.kgitbank.spring.comment.vo.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	private ICommentService commentService;
	
	@PostMapping("/update")
	@ResponseBody
	public CommentVO updateComment(@RequestBody CommentVO comment, Principal principal) {
	    comment.setUserId(principal.getName());
	    commentService.updateComment(comment);
	    return commentService.getCommentById(comment.getCommentId());
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public String deleteComment(int commentId, Principal principal) {
		if(principal == null) return "fail";
		int result = commentService.deleteComment(commentId, principal.getName());
		return result == 1 ? "success" : "fail";
	}
	
	@PostMapping("/write")
	@ResponseBody
	public CommentVO writeComment(@RequestParam int postId, @RequestParam String content, @RequestParam(required=false) Integer parentCommentId, Principal principal) {
	    CommentVO comment = new CommentVO();
	    comment.setPostId(postId);
	    comment.setContent(content);
	    comment.setUserId(principal.getName());
	    comment.setParentCommentId(parentCommentId);
	    commentService.writeComment(comment);
	    return commentService.getCommentById(comment.getCommentId());
	} 
}