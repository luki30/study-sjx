package com.example.library.repository;

import com.example.library.entity.BorrowRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BorrowRecordRepository
        extends JpaRepository<BorrowRecord, Long> {
    List<BorrowRecord> findByBookId(Long bookId);
    List<BorrowRecord> findByBookIdAndReturnDateIsNull(Long bookId);
}