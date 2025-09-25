package com.example.library.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.persistence.*;

@Entity
@Table(name = "user")
@Schema(description = "用户实体")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(description = "用户ID", example = "1")
    private Long id;
    @Column(nullable = false, unique = true)
    @Schema(description = "用户名", example = "admin")
    private String username;
    @Column(nullable = false)
    @Schema(description = "密码", example = "admin123")
    private String password;
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setPassword(String password) { this.password = password; }
}