package com.example.library.service;

import com.example.library.entity.Book;
import com.example.library.entity.BorrowRecord;
import com.example.library.repository.BookRepository;
import com.example.library.repository.BorrowRecordRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BookService {
    private static final Logger logger = LoggerFactory.getLogger(BookService.class);
    private final BookRepository bookRepository;
    private final BorrowRecordRepository borrowRecordRepository;
    @Autowired
    public BookService(BookRepository bookRepository,
                       BorrowRecordRepository borrowRecordRepository) {
        this.bookRepository = bookRepository;
        this.borrowRecordRepository = borrowRecordRepository;
    }
    public List<Book> getAllBooks() {
        return bookRepository.findAll();
    }
    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }
    public Book saveBook(Book book) {
        try {
            return bookRepository.save(book);
        } catch (Exception e) {
            logger.error("保存图书失败: {}", e.getMessage());
            throw new IllegalStateException("保存图书失败: " +
                    e.getMessage());
        }
    }
    public void deleteBook(Long id) {
        logger.info("尝试删除图书: ID={}", id);// 检查是否有未归还的借阅记录
        List<BorrowRecord> activeRecords = borrowRecordRepository.
                findByBookIdAndReturnDateIsNull(id);
        if (!activeRecords.isEmpty()) {
            logger.warn("无法删除图书 ID={}, 存在 {} 条未归还记录", id,
                        activeRecords.size());
            throw new IllegalStateException("无法删除图书，存在未归还的借阅记录");
        }try {// 删除关联的借阅记录
            List<BorrowRecord> allRecords =
                    borrowRecordRepository.findByBookId(id);
            borrowRecordRepository.deleteAll(allRecords);
            logger.debug("已删除图书 ID={} 的 {} 条借阅记录", id, allRecords.size());
            // 删除图书
            bookRepository.deleteById(id);
            logger.info("成功删除图书: ID={}", id);
        } catch (Exception e) {
            logger.error("删除图书失败: ID={}, 原因: {}", id, e.getMessage());
            throw new RuntimeException("删除图书失败: " + e.getMessage());
        }
    }
    public List<Book> searchBooks(String keyword) {
        try {
            return bookRepository.findByTitleContainingIgnoreCaseOrAuthorContainingIgnoreCase(
                    keyword, keyword);
        } catch (Exception e) {

            logger.error("搜索图书失败: {}", e.getMessage());
            throw new RuntimeException("搜索图书失败: " + e.getMessage());
        }
    }
    public boolean isbnExists(String isbn) {
        return bookRepository.existsByIsbn(isbn);
    }
}