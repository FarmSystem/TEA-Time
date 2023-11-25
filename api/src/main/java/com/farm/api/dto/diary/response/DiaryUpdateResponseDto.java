package com.farm.api.dto.diary.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Getter
@NoArgsConstructor
public class DiaryUpdateResponseDto {
    @JsonProperty("id")
    private Long id;
    @JsonProperty("title")
    private String title;
    @JsonProperty("content")
    private String content;
    @JsonProperty("emotion")
    private String emotion;
    @JsonProperty("is_private")
    private String isPrivate;

    @Builder
    public DiaryUpdateResponseDto(Long id, String title, String content, String emotion, String isPrivate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.emotion = emotion;
        this.isPrivate = isPrivate;
    }
}
