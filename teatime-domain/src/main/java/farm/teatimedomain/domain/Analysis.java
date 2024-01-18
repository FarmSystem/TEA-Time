package farm.teatimedomain.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = lombok.AccessLevel.PROTECTED)
@Table(name = "analysis")
public class Analysis {
    @Id
    private Long id;

    @Column(name = "score")
    private Float score;

    @Column(name = "happy")
    private Float happy;

    @Column(name = "embarrassment")
    private Float embarrassment;

    @Column(name = "anger")
    private Float anger;

    @Column(name = "sadness")
    private Float sadness;

    @Column(name = "anxiety")
    private Float anxiety;

    @OneToOne()
    @MapsId
    @JoinColumn(name = "id")
    private Diary diary;

    @Builder
    private Analysis(Float score, Float happy, Float embarrassment, Float anger, Float sadness, Float anxiety, Diary diary) {
        this.score = score;
        this.happy = happy;
        this.embarrassment = embarrassment;
        this.anger = anger;
        this.sadness = sadness;
        this.anxiety = anxiety;
        this.diary = diary;
    }

    public void update(Float score, Float happy, Float embarrassment, Float anger, Float sadness, Float anxiety) {
        this.score = score;
        this.happy = happy;
        this.embarrassment = embarrassment;
        this.anger = anger;
        this.sadness = sadness;
        this.anxiety = anxiety;
    }

    public static Analysis fromDto(Float score, Float happy, Float embarrassment, Float anger, Float sadness, Float anxiety, Diary diary) {
        return Analysis.builder()
                .score(score)
                .happy(happy)
                .embarrassment(embarrassment)
                .anger(anger)
                .sadness(sadness)
                .anxiety(anxiety)
                .diary(diary)
                .build();
    }
}
