package com.example.library.controller;

import com.example.library.entity.Book;
import com.example.library.service.BookService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
@Controller
@RequestMapping("/books")
@Tag(name = "图书管理", description = "图书的增删改查操作")
public class BookController {
    private final BookService bookService;
    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }
    @Operation(summary = "获取所有图书列表", description = "返回图书列表页面")
    @GetMapping
    public String listBooks(Model model) {
        model.addAttribute("books", bookService.getAllBooks());
        return "book/list";
    }
    @Operation(summary = "显示创建图书表单", description = "返回图书创建表单页面")
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("book", new Book());
        return "book/form";
    }
    @Operation(summary = "创建新图书", description = "保存图书并重定向到列表页")
    @PostMapping
    public String saveBook(@ModelAttribute Book book) {
        bookService.saveBook(book);
        return "redirect:/books";
    }
    @Operation(summary = "显示编辑图书表单",
            description = "根据ID返回图书编辑表单")
    @GetMapping("/edit/{id}")
    public String showEditForm(
            @Parameter(description = "图书ID",
                    required = true, example = "1")
            @PathVariable Long id, Model model) {
        Book book = bookService.getBookById(id)
                .orElseThrow(() ->
                        new IllegalArgumentException
                                ("无效的图书ID: " + id));
        model.addAttribute("book", book);
        return "book/form";
    }
    @Operation(summary = "删除图书", description = "根据ID删除图书")
    @GetMapping("/delete/{id}")
    public String deleteBook(
            @Parameter(description = "图书ID", required = true, example = "1")
            @PathVariable Long id) {
        bookService.deleteBook(id);
        return "redirect:/books";
    }
    @Operation(summary = "搜索图书", description = "根据关键词搜索图书")
    @GetMapping("/search")
    public String searchBooks(
            @Parameter(description = "搜索关键词", required = true, example = "Java")
            @RequestParam String keyword, Model model) {
        model.addAttribute("books", bookService.searchBooks(keyword));
        return "book/list";
    }
}