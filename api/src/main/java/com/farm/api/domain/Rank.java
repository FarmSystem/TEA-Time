package com.farm.api.domain;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter @Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "`rank`")
public class Rank {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "rank_id_seq")
    @SequenceGenerator(name = "rank_id_seq", sequenceName = "rank_id_seq")
    @Column(name = "rank_id")
    private Long id;

    @Column(name = "`grade`")
    private String grade;

    @Column(name = "exp")
    private Long exp;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

}
