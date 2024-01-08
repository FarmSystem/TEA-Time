package farm.teatimedomain.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@Table(name = "comments")
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "content", length = 500, nullable = false)
    private String content;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "diary_id", nullable = false)
    private Diary diary;

    @Builder
    private Comment(String content, User user, Diary diary) {
        this.content = content;
        this.user = user;
        this.diary = diary;
        this.createdAt = LocalDate.now();
    }

    public static Comment fromDto(String content, User user, Diary diary) {
        return Comment.builder()
                .content(content)
                .user(user)
                .diary(diary)
                .build();
    }
}
