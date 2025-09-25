package com.example.library.handler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class MessageAdvice {
    @ModelAttribute
    public void addAttributes(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            // 从session获取错误信息
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
                model.addAttribute("errorMessage", errorMessage);
                session.removeAttribute("errorMessage"); // 清除session中的错误信息
            }
            // 从session获取成功信息
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                model.addAttribute("successMessage", successMessage);
                session.removeAttribute("successMessage");
            }
        }
    }
}