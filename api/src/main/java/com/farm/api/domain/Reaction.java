package com.farm.api.domain;

import com.farm.api.domain.EnumType.ReactionType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "reaction")
public class Reaction {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "reaction_id_seq")
    @SequenceGenerator(name = "reaction_id_seq", sequenceName = "reaction_id_seq")
    @Column(name = "reaction_id")
    private Long id;

    @Column(name = "reaction_type")
    @Enumerated(EnumType.STRING)
    private ReactionType reactionType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "diary_id")
    private Diary diary;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Builder
    public Reaction(ReactionType reactionType, Diary diary, User user) {
        this.reactionType = reactionType;
        this.diary = diary;
        this.user = user;
    }
}
