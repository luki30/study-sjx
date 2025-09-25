package com.example.library.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "book")
@Schema(description = "图书实体")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "图书ID", example = "1")
    private Long id;
    @Column(nullable = false)
    @Schema(description = "图书标题", example = "Java编程思想")
    private String title;
    @Column(nullable = false)
    @Schema(description = "作者", example = "Bruce Eckel")
    private String author;
    @Column(unique = true, nullable = false)
    @Schema(description = "ISBN编号", example = "9787111213826")
    private String isbn;
    @Schema(description = "出版年份", example = "2007")
    private Integer publishYear;
    @Column(columnDefinition = "boolean default true")
    @Schema(description = "是否可借", example = "true")
    private Boolean available = true;
}