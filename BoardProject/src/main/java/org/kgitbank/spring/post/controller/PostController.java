package org.kgitbank.spring.post.controller;

import java.util.List;

import org.kgitbank.spring.comment.service.ICommentService;
import org.kgitbank.spring.comment.vo.CommentVO;
import org.kgitbank.spring.post.service.IPostService;
import org.kgitbank.spring.post.vo.PostListVO;
import org.kgitbank.spring.post.vo.PostVO;
import org.kgitbank.spring.recommend.service.IRecommendService;
import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

//게시글
@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private IPostService postService;
	
	@Autowired
	private ICommentService commentService;
	
	@Autowired
	private IRecommendService recommendService;
	
	//게시글 작성
	@GetMapping("/write")
	public String insertPostForm() {
		return "post/write";
	}
	
	@PostMapping("/write")
	public String insertPost(PostVO post) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    UserVO loginUser = (UserVO) auth.getPrincipal();
	    post.setUserId(loginUser.getUserId());

	    //현재 로그인한 사용자가 관리자 권한인지 확인
	    boolean isAdmin = auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
	    
	    if (isAdmin) {
	        //관리자는 무조건 공지글
	        post.setIsNotice("Y");
	        post.setSeatInfo(null);
	        post.setCheerScore(null);
	        post.setSatisfactionScore(null);
	    } else {
	        //회원은 일반글
	        post.setIsNotice("N");
	    }

	    postService.insertPost(post);
	    return "redirect:/post/list";
	}

	//게시글 목록
	@GetMapping("/list")
	public String getPostList(Model model) {
		List<PostListVO> postList = postService.getPostList();
		model.addAttribute("postList", postList);
		return "post/list";	
	}
	
	//게시글 상세페이지에서 작성자만 수정/삭제 만들기위해 현재 로그인한 사용자랑 게시글 작성자랑 비교
	@GetMapping("/detail")
	public String getPostDetail(int postId, Model model) {
		PostVO post = postService.getPostDetail(postId);
		model.addAttribute("post", post);
		List<CommentVO> commentList = commentService.getCommentList(postId);
	    model.addAttribute("commentList", commentList);
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String loginUserId = null;
	    if(auth != null && auth.getPrincipal() instanceof UserVO) {
			loginUserId = ((UserVO) auth.getPrincipal()).getUserId();
		}
	    model.addAttribute("loginUserId", loginUserId);
		return "post/detail";
	}
	
	//게시글 수정
	@GetMapping("/update")
	public String updatePost(@RequestParam int postId, Model model) {
		PostVO post = postService.getPostDetail(postId);
		model.addAttribute("post", post);
		return "post/update";
	}
	
	@PostMapping("/update")
	public String updatePost(PostVO post) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    UserVO loginUser = (UserVO) auth.getPrincipal();
	    PostVO originPost = postService.getPostDetail(post.getPostId());

	    boolean isAdmin = auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
	    //작성자 or 관리자만 수정 가능
	    if (!originPost.getUserId().equals(loginUser.getUserId()) && !isAdmin) {
	        return "redirect:/post/detail?postId=" + post.getPostId();
	    }

	    if (isAdmin) {
	        post.setIsNotice("Y");
	        post.setSeatInfo(null);
	        post.setCheerScore(null);
	        post.setSatisfactionScore(null);
	    } else {
	        post.setIsNotice("N");
	    }

	    post.setUserId(originPost.getUserId());
	    
	    postService.updatePost(post);
	    return "redirect:/post/detail?postId=" + post.getPostId();
	}
	
	//게시글 삭제
	//게시글 상세페이지에서 현재 로그인한 사용자랑 게시글 작성자가 같은지 확인 후 삭제
	@PostMapping("/delete")
	public String deletePost(int postId) {
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    UserVO loginUser = (UserVO) auth.getPrincipal();
	    PostVO post = postService.getPostDetail(postId);

	    boolean isAdmin = auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
	    // 글 작성자나 관리자만 삭제 가능
	    if (!post.getUserId().equals(loginUser.getUserId()) && !isAdmin) {
	        return "redirect:/post/detail?postId=" + postId;
	    }

	    postService.deletePost(postId);
	    return "redirect:/post/list";
	}
	
	//좌석 검색 - 키워드 검색 연결시킴
	@GetMapping("/search")
	public String searchSeat(@RequestParam(required = false) String keyword, Model model) {
		model.addAttribute("keyword", keyword);
		model.addAttribute("resultList", recommendService.searchSeat(keyword));
		return "post/search";
	}
}
