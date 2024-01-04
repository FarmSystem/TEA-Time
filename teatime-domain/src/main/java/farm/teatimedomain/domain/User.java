package farm.teatimedomain.domain;

import farm.teatimedomain.type.EProvider;
import farm.teatimedomain.type.ERole;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@DynamicUpdate
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    private UUID id;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "provider", nullable = false)
    @Enumerated(EnumType.STRING)
    private EProvider provider;

    @Column(name = "role", nullable = false)
    @Enumerated(EnumType.STRING)
    private ERole role;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @Column(name = "nickname", nullable = false)
    private String nickname;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "profile_image")
    private String profileImage = "default";

    @Column(name = "is_login", columnDefinition = "TINYINT(1)")
    private Boolean isLogin;

    @Column(name = "is_public", columnDefinition = "TINYINT(1)")
    private Boolean isPublic = true;

    @Column(name = "refresh_token")
    private String refreshToken;

    @Column(name = "level")
    private Integer level = 1;

    @Column(name = "score")
    private Integer score = 0;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Diary> diaries = new ArrayList<>();

    @Builder
    public User(String email, String password, String nickname, EProvider provider, ERole role) {
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.provider = provider;
        this.role = role;
        this.createdAt = LocalDate.now();
        this.isLogin = false;
        this.refreshToken = null;
    }

    public void writeDiary() {
        this.score += 10;
        checkLevelUp();
    }

    private void checkLevelUp() {
        boolean levelUp = false;

        if (score >= 2000 && level < 6) {
            level = 6; levelUp = true;
        } else if (score >= 1000 && level < 5) {
            level = 5; levelUp = true;
        } else if (score >= 500 && level < 4) {
            level = 4; levelUp = true;
        } else if (score >= 200 && level < 3) {
            level = 3; levelUp = true;
        } else if (score >= 100 && level < 2) {
            level = 2; levelUp = true;
        }

        if (levelUp) { this.score = 0; }
    }

    public void updateRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public void updateUserInfo(String nickname, String profileImage, Boolean isPublic) {
        if (nickname != null && (!Objects.equals(this.nickname, nickname))) {
            this.nickname = nickname;
        }

        if (profileImage != null && (!Objects.equals(this.profileImage, profileImage))) {
            this.profileImage = profileImage;
        }

        if (isPublic != this.isPublic) {
            this.isPublic = isPublic;
        }
    }
}
