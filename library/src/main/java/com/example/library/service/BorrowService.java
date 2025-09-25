package com.example.library.service;

import com.example.library.entity.Book;
import com.example.library.entity.BorrowRecord;
import com.example.library.repository.BookRepository;
import com.example.library.repository.BorrowRecordRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;

@Service
public class BorrowService {
    private final BorrowRecordRepository borrowRecordRepository;
    private final BookRepository bookRepository;
    private static final Logger logger = LoggerFactory.getLogger(BorrowService.class);
    @Autowired
    public BorrowService(BorrowRecordRepository borrowRecordRepository,
                         BookRepository bookRepository) {
        this.borrowRecordRepository = borrowRecordRepository;
        this.bookRepository = bookRepository;
    }
    public BorrowRecord borrowBook(Long bookId, String borrowerName) {
        logger.info("借阅请求 - 图书ID: {}, 借阅人: {}", bookId, borrowerName);

        Book book = bookRepository.findById(bookId)
                .orElseThrow(() -> {
                    logger.error("图书不存在: ID={}", bookId);
                    return new RuntimeException("图书不存在");
                });

        if (!book.getAvailable()) {
            logger.warn("图书不可借阅: ID={}, 状态: 已借出", bookId);
            throw new RuntimeException("图书不可借阅");
        }
        book.setAvailable(false);
        bookRepository.save(book);
        logger.debug("更新图书状态: ID={}, 状态=不可用", bookId);
        BorrowRecord record = new BorrowRecord();
        record.setBook(book);
        record.setBorrowerName(borrowerName);
        record.setBorrowDate(LocalDate.now());
        BorrowRecord savedRecord = borrowRecordRepository.save(record);
        logger.info("借阅记录创建成功: 记录ID={}, 图书ID={}, 借阅人={}",
                savedRecord.getId(), bookId, borrowerName);

        return savedRecord;
    }
    public BorrowRecord returnBook(Long recordId) {
        BorrowRecord record = borrowRecordRepository.findById(recordId)
                .orElseThrow(() -> new RuntimeException("Record not found"));

        Book book = record.getBook();
        book.setAvailable(true);
        bookRepository.save(book);
        record.setReturnDate(LocalDate.now());
        return borrowRecordRepository.save(record);
    }
    public List<BorrowRecord> getAllRecords() {
        return borrowRecordRepository.findAll();
    }
}