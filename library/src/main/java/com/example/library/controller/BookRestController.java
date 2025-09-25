package com.example.library.controller;

import com.example.library.entity.Book;
import com.example.library.service.BookService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/books")
@Tag(name = "图书管理API", description = "图书相关REST接口")
public class BookRestController {
    @Autowired
    private BookService bookService;
    @Operation(summary = "获取所有图书",
                description = "返回所有图书的JSON列表")
    @ApiResponse(responseCode = "200",
                description = "成功获取图书列表",
            content = @Content(mediaType = "application/json",
                    schema = @Schema(implementation = Book.class)))
    @GetMapping
    public ResponseEntity<List<Book>> getAllBooks() {
        return ResponseEntity.ok(bookService.getAllBooks());
    }
    @Operation(summary = "根据ID获取图书",
            description = "返回指定ID的图书")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "成功找到图书"),
            @ApiResponse(responseCode = "404",
                    description = "图书不存在")
    })
    @GetMapping("/{i" + "d}")
    public ResponseEntity<Book> getBookById(
            @Parameter(description = "图书ID",
                    required = true, example = "1")
            @PathVariable Long id) {
        return bookService.getBookById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    @Operation(summary = "创建新图书", description = "创建新图书并返回保存后的图书")
    @ApiResponse(responseCode = "200", description = "成功创建图书",
            content = @Content(mediaType = "application/json",
                    schema = @Schema(implementation = Book.class)))
    @PostMapping
    public ResponseEntity<Book> createBook(
            @io.swagger.v3.oas.annotations.parameters.RequestBody(
                    description = "图书对象",
                    required = true,
                    content = @Content(schema = @Schema(implementation = Book.class)))
            @RequestBody Book book) {
        return ResponseEntity.ok(bookService.saveBook(book));
    }
    @Operation(summary = "删除图书", description = "根据ID删除图书")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204", description = "成功删除图书"),
            @ApiResponse(responseCode = "404", description = "图书不存在")
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(
            @Parameter(description = "图书ID", required = true, example = "1")
            @PathVariable Long id) {
        bookService.deleteBook(id);
        return ResponseEntity.noContent().build();
    }
    @Operation(summary = "检查ISBN是否唯一", description = "验证ISBN是否已存在")
    @ApiResponse(responseCode = "200", description = "检查结果",
            content = @Content(mediaType = "application/json",
                    schema = @Schema(implementation = Map.class)))
    @GetMapping("/check-isbn")
    public ResponseEntity<Map<String, Boolean>> checkIsbnUnique(
            @Parameter(description = "ISBN编号", required = true)
            @RequestParam String isbn) {

        boolean exists = bookService.isbnExists(isbn);
        return ResponseEntity.ok(Collections.singletonMap("exists", exists));
    }
}