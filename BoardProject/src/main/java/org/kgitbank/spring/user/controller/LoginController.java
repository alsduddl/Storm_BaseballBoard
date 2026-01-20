package org.kgitbank.spring.user.controller;

import org.kgitbank.spring.user.vo.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("user", new UserVO());
        return "login";
    }
    
}
