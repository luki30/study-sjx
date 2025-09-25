package com.example.library.handler;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    // 处理500错误
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleServerErrors(Exception ex, HttpServletRequest request, Model model) {
        String errorMessage = "服务器内部错误: " + ex.getMessage();
        model.addAttribute("errorMessage", errorMessage);
        logger.error("服务器错误: {} - {}", request.getRequestURI(), ex.getMessage(), ex);
        return "error";
    }
    // 处理业务异常
    @ExceptionHandler({IllegalStateException.class, IllegalArgumentException.class})
    public String handleBusinessException(RuntimeException ex, HttpServletRequest request) {
        logger.warn("业务异常: {}", ex.getMessage());

        // 将错误信息存入session
        HttpSession session = request.getSession();
        session.setAttribute("errorMessage", ex.getMessage());

        // 获取来源页面URL
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/books");
    }
}