package com.farm.api.domain;

import com.farm.api.domain.EnumType.LoginPlatform;
import com.farm.api.domain.EnumType.UserType;
import com.farm.api.domain.MetaType.MetaUserInfo;
import io.hypersistence.utils.hibernate.type.json.JsonBinaryType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Type;
import org.springframework.data.annotation.CreatedDate;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "`users`")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_id_seq")
    @SequenceGenerator(name = "user_id_seq", sequenceName = "user_id_seq")
    @Column(name = "user_id")
    private Long id;

    @Column(name = "social_id", unique = true)
    private String socialId;

    @Column(name = "password")
    private String password;

    @Column(name = "nickname")
    private String nickname;

    @Column(name = "profile_url")
    private String profileUrl;

    @Column(name = "user_type")
    @Enumerated(EnumType.STRING)
    private UserType userType;

    @Type(JsonBinaryType.class)
    @Column(name = "user_info", columnDefinition = "jsonb")
    private MetaUserInfo userInfo;

    @Column(name = "refresh_token")
    private String refreshToken;

    @Column(name = "is_login")
    private boolean isLogin;

    @Column(name = "provider")
    @Enumerated(EnumType.STRING)
    private LoginPlatform provider;

    @CreatedDate
    @Column(name = "created_at")
    private Timestamp createdAt;

    @CreatedDate
    @Column(name = "updated_at")
    private Timestamp updatedAt;

    // ============================= One to One Relationship =============================

    @OneToOne(mappedBy = "user", fetch = FetchType.LAZY)
    private Status status;

    @OneToOne(mappedBy = "user", fetch = FetchType.LAZY)
    private Rank rank;

    // ============================= One to Many Relationship =============================

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Diary> diaries;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Reaction> reactions;

    // ============================= Builder Pattern =============================

    @Builder
    public User(String socialId, String nickname, String password, String profileUrl, UserType userType, LoginPlatform provider, MetaUserInfo userInfo) {
        this.socialId = socialId;
        this.nickname = nickname;
        this.password = password;
        this.profileUrl = profileUrl;
        this.userType = userType;
        this.userInfo = userInfo;
        this.refreshToken = null;
        this.provider = provider;
        this.isLogin = false;
        this.createdAt = Timestamp.valueOf(LocalDateTime.now());
        this.updatedAt = Timestamp.valueOf(LocalDateTime.now());
    }

    public void updateRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
        this.isLogin = true;
    }

    public void updateUser(String nickname, String profileUrl, MetaUserInfo userInfo) {
        this.nickname = nickname;
        this.profileUrl = profileUrl;
        this.userInfo = userInfo;
        this.updatedAt = Timestamp.valueOf(LocalDateTime.now());
    }

    public void logoutUser() {
        this.refreshToken = null;
        this.isLogin = false;
    }
}
