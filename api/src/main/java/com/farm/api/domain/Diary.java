package com.farm.api.domain;

import com.farm.api.type.MetaDiary;
import io.hypersistence.utils.hibernate.type.json.JsonBinaryType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;
import org.springframework.data.annotation.CreatedDate;
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
    private String createdAt;

    @CreatedDate
    @Column(name = "updated_at")
    private String updatedAt;

    @OneToOne(mappedBy = "diary", fetch = FetchType.LAZY)
    private DiaryResult diaryResult;

    @OneToMany(mappedBy = "diary", fetch = FetchType.LAZY)
    private List<Reaction> reactions;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
}
