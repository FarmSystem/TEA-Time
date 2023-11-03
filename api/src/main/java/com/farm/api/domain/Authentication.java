package com.farm.api.domain;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import java.time.LocalDateTime;

@Entity
@Getter @Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "`authentication`")
public class Authentication {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "authentication_id_seq")
    @SequenceGenerator(name = "authentication_id_seq", sequenceName = "authentication_id_seq")
    @Column(name = "authentication_id")
    private Long id;

    @Column(name = "access_token")
    private String accessToken;

    @Column(name = "refresh_token")
    private String refreshToken;

    @Column(name = "expired_duration")
    private Long expiredDuration;

    @CreatedDate
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @CreatedDate
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

}
