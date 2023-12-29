package com.farm.api.domain;

import com.farm.api.domain.MetaType.MetaEmotions;
import com.farm.api.domain.MetaType.MetaSentences;
import io.hypersistence.utils.hibernate.type.json.JsonBinaryType;
import jakarta.annotation.Nullable;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Type;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "diary_result")
public class DiaryResult {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "diary_result_id_seq")
    @SequenceGenerator(name = "diary_result_id_seq", sequenceName = "diary_result_id_seq")
    @Column(name = "diary_result_id")
    private Long id;

    @Type(JsonBinaryType.class)
    @Column(name = "emotions", columnDefinition = "jsonb")
    @Nullable
    private MetaEmotions emotions;

    @Type(JsonBinaryType.class)
    @Column(name = "sentences", columnDefinition = "jsonb")
    @Nullable
    private MetaSentences sentences;

    @Column(name = "summation")
    @Lob
    private String summation;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "diary_id")
    private Diary diary;
}
