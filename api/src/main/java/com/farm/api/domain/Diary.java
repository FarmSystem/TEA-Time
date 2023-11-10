package com.farm.api.domain;

import com.farm.api.domain.MetaType.MetaDiary;
import io.hypersistence.utils.hibernate.type.json.JsonBinaryType;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Type;
import org.springframework.data.annotation.CreatedDate;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "`diary`")
public class Diary {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "diary_id_seq")
    @SequenceGenerator(name = "diary_id_seq", sequenceName = "diary_id_seq")
    @Column(name = "diary_id")
    private Long id;

    @Type(JsonBinaryType.class)
    @Column(name = "diary", columnDefinition = "jsonb")
    private MetaDiary diary;

    @CreatedDate
    @Column(name = "created_at")
    private Timestamp createdAt;

    @CreatedDate
    @Column(name = "updated_at")
    private Timestamp updatedAt;

    // ============================= One To One Relationship =============================

    @OneToOne(mappedBy = "diary", fetch = FetchType.LAZY)
    private DiaryResult diaryResult;

    // ============================= One To Many Relationship =============================

    @OneToMany(mappedBy = "diary", fetch = FetchType.LAZY)
    private List<Reaction> reactions;

    // ============================= Many To One Relationship =============================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    // ============================= Builder Pattern =============================

    @Builder
    public Diary(User user, MetaDiary diary) {
        this.user = user;
        this.diary = diary;
        createdAt = Timestamp.valueOf(LocalDateTime.now());
        updatedAt = Timestamp.valueOf(LocalDateTime.now());
    }

    public void updateDiaryToPublic(MetaDiary diary) {
        this.diary.setPrivate(false);
    }

    public void updateDiaryToPrivate(MetaDiary diary) {
        this.diary.setPrivate(true);
    }
}
