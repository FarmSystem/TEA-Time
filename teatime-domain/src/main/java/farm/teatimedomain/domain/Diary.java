package farm.teatimedomain.domain;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "diaries")
public class Diary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "content", length = 1000, nullable = false)
    private String content;

    @Column(name = "image", nullable = false)
    private String image;

    @Column(name = "created_at")
    private LocalDate createdAt;

    @OneToOne(mappedBy = "diary")
    private Analysis analysis;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Builder
    private Diary(String title, String content, String image, User user) {
        this.title = title;
        this.content = content;
        this.image = image;
        this.user = user;
        this.createdAt = LocalDate.now();
    }

    public static Diary fromDto(String title, String content, String image, User user) {
        return Diary.builder()
                .title(title)
                .content(content)
                .image(image)
                .user(user)
                .build();
    }

    public void update(String title, String content, String image) {
        this.title = title;
        this.content = content;
        this.image = image;
    }
}
