package org.kgitbank.spring;

import java.util.List;

import org.kgitbank.spring.post.service.IPostService;
import org.kgitbank.spring.post.vo.PostListVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
	@Autowired
	private IPostService postService;
	
	//메인페이지 접속
	//
	@GetMapping({"/", "/main"})
	public String mainPage(Model model) {
		List<PostListVO> topLikePost = postService.getTopLikePost();
		model.addAttribute("topLikePost", topLikePost);
		List<PostListVO> mainPostList = postService.getMainPostList();
		model.addAttribute("mainPostList", mainPostList);
		return "main";
	}
	
}
