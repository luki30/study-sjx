package com.example.library.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "borrow_record")
@Schema(description = "借阅记录实体")
public class BorrowRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "借阅记录ID", example = "1")
    private Long id;
    @ManyToOne
    @JoinColumn(name = "book_id", nullable = false)
    @Schema(description = "借阅的图书")
    private Book book;
    @Column(nullable = false)
    @Schema(description = "借阅人姓名", example = "张三")
    private String borrowerName;
    @Column(nullable = false)
    @Schema(description = "借阅日期", example = "2023-10-01")
    private LocalDate borrowDate;
    @Schema(description = "归还日期", example = "2023-10-15")
    private LocalDate returnDate;
}