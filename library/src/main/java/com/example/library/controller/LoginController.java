package com.example.library.controller;

import com.example.library.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
    private static final Logger logger =
            LoggerFactory.getLogger(LoginController.class);
    private final UserRepository userRepository;
    @Autowired
    public LoginController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }
    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        logger.info("登录尝试: 用户名={}", username);
        try {
            if (userRepository.findByUsernameAndPassword(username,
                    password).isPresent()) {
                session.setAttribute("user", username);
                logger.info("登录成功: 用户名={}", username);
                return "redirect:/books";
            } else {
                logger.warn("登录失败: 用户名={}", username);
                model.addAttribute("error",
                                    "用户名或密码错误");
                return "login";
            }
        } catch (Exception e) {
            logger.error("登录处理失败: {}", e.getMessage());
            throw new RuntimeException("登录处理失败: " + e.getMessage());
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}