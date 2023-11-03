package com.farm.api.type;

import com.fasterxml.jackson.annotation.JsonProperty;
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
}
