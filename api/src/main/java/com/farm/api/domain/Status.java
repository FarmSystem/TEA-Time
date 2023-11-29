package com.farm.api.domain;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "`status`")
public class Status {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "status_id_seq")
    @SequenceGenerator(name = "status_id_seq", sequenceName = "status_id_seq")
    @Column(name = "status_id")
    private Long id;

    @Column(name = "score")
    private float score;

    @CreatedDate
    @Column(name = "created_at")
    private String createdAt;

    @CreatedDate
    @Column(name = "updated_at")
    private String updatedAt;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;
}
