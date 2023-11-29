package com.farm.api.domain.MetaType;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter @Setter
@RequiredArgsConstructor
public class MetaDiary {
    @JsonProperty("title")
    private String title;

    @JsonProperty("content")
    private String content;

    @JsonProperty("picture_url")
    private String pictureUrl;

    @JsonProperty("emoji")
    private String emoji;

    @JsonProperty("is_private")
    private boolean isPrivate;

    @Builder
    public MetaDiary(String title, String content, String pictureUrl, String emoji, boolean isPrivate) {
        this.title = title;
        this.content = content;
        this.pictureUrl = pictureUrl;
        this.emoji = emoji;
        this.isPrivate = isPrivate;
    }

    public void updateIsPrivate(boolean isPrivate) {
        this.isPrivate = isPrivate;
    }
}
