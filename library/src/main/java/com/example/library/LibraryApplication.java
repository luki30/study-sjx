package com.example.library;

import com.example.library.entity.User;
import com.example.library.repository.UserRepository;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
@OpenAPIDefinition
@SpringBootApplication
public class LibraryApplication {
    private static final Logger logger =
            LoggerFactory.getLogger(LibraryApplication.class);
    public static void main(String[] args) {
        try {
            logger.info("图书馆管理系统启动中...");
            SpringApplication.run(LibraryApplication.class, args);
            logger.info("图书馆管理系统启动完成!");
        } catch (Exception e) {
            logger.error("应用启动失败: {}", e.getMessage(), e);
            System.exit(1);
        }
    }
    // 添加默认用户
    @Bean
    CommandLineRunner init(UserRepository userRepository) {
        return args -> {
            try {
                if (userRepository.count() == 0) {
                    logger.info("创建默认管理员账户");
                    User admin = new User();
                    admin.setUsername("admin");
                    admin.setPassword("admin123");
                    userRepository.save(admin);
                } else {
                    logger.info("已存在用户账户，跳过默认账户创建");
                }
            } catch (Exception e) {
                logger.error("初始化用户失败: {}", e.getMessage());
            }
        };
    }
}