package farm.teatimedomain.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@Table(name = "followings")
public class Following {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="following_id", nullable = false)
    private User following;

    @Builder
    private Following(User user, User following) {
        this.user = user;
        this.following = following;
    }

    public static Following of(User user, User following) {
        return Following.builder()
                .user(user)
                .following(following)
                .build();
    }
}
