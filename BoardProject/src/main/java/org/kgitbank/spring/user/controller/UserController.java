package org.kgitbank.spring.user.controller;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.kgitbank.spring.comment.service.ICommentService;
import org.kgitbank.spring.comment.vo.CommentVO;
import org.kgitbank.spring.post.service.IPostService;
import org.kgitbank.spring.post.vo.PostListVO;
import org.kgitbank.spring.post.vo.PostVO;
import org.kgitbank.spring.user.dto.JoinDTO;
import org.kgitbank.spring.user.service.IUserService;
import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

//회원
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;
    
    @Autowired
	private IPostService postService;
    
    @Autowired
    private ICommentService commentService;

    //마이페이지
    @GetMapping("/mypage")
    public String myPage(Model model) {
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	UserVO principalUser = (UserVO) auth.getPrincipal();  //Object타입 반환 방지
        UserVO user = userService.getUserById(principalUser.getUserId());
        model.addAttribute("user", user);
        List<PostVO> post = postService.getUserPost(principalUser.getUserId());
        model.addAttribute("post", post);
        return "user/mypage";
    }

    //회원가입
    @GetMapping("/join")
    public String joinUserForm(Model model) {
        model.addAttribute("user", new JoinDTO());  
        return "user/join";
    }

    @PostMapping("/join")
    public String joinUser(@Valid @ModelAttribute("user")JoinDTO joinDTO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "user/join";
        }
        userService.joinUser(joinDTO); 
        return "redirect:/login";
    }

    //아이디 중복 + 정규식 체크
    @RequestMapping("/userIdCheck")
    @ResponseBody
    public int userIdCheck(@RequestParam("userId") String userId) {
        return userService.getuserIdCount(userId);
    }

    //닉네임 중복 + 정규식 체크
    @RequestMapping("/nicknameCheck")
    @ResponseBody
    public int nicknameCheck(@RequestParam("nickname") String nickname) {
        return userService.getnicknameCount(nickname);
    }
    
    //작성한 게시글
    @GetMapping("/mylist")
    public String myPostList(Model model) {
    	Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    	UserVO loginUser = (UserVO) auth.getPrincipal();
    	List<PostListVO> myPostList = postService.getUserPostList(loginUser.getUserId());
        model.addAttribute("postList", myPostList);
        return "user/mylist";
    }
    
    //작성한 댓ㄱㄹ
    @GetMapping("/mycomment")
    public String getMyCommentList(Model model, Principal principal) {
    	String userId = principal.getName();
    	List <CommentVO> commentList = commentService.getMyCommentList(userId);
    	model.addAttribute("commentList", commentList);
    	return "user/mycomment";
    }
}