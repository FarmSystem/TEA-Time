package com.farm.api.dto.diary.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.File;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class DiaryCreateRequestDto {
    @JsonProperty("title")
    private String title;
    @JsonProperty("content")
    private String content;
    @JsonProperty("emotion")
    private String emotion;
    @JsonProperty("is_private")
    private String isPrivate;
}
