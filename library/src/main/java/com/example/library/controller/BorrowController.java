package com.example.library.controller;

import com.example.library.service.BorrowService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/borrows")
public class BorrowController {
    private final BorrowService borrowService;
    @Autowired
    public BorrowController(BorrowService borrowService) {
        this.borrowService = borrowService;
    }
    @Operation(summary = "获取借阅记录列表", description = "返回所有借阅记录页面")
    @GetMapping
    public String listRecords(Model model) {
        model.addAttribute("records", borrowService.getAllRecords());
        return "borrow/list";
    }
    @Operation(summary = "借阅图书", description = "借阅指定图书")
    @PostMapping("/borrow")
    public String borrowBook(
            @Parameter(description = "图书ID", required = true, example = "1")
            @RequestParam Long bookId,

            @Parameter(description = "借阅人姓名", required = true, example = "张三")
            @RequestParam String borrowerName) {
        borrowService.borrowBook(bookId, borrowerName);
        return "redirect:/books";
    }
    @Operation(summary = "归还图书", description = "归还指定借阅记录的图书")
    @PostMapping("/return/{id}")
    public String returnBook(
            @Parameter(description = "借阅记录ID", required = true, example = "1")
            @PathVariable Long id) {
        borrowService.returnBook(id);
        return "redirect:/borrows";
    }
}