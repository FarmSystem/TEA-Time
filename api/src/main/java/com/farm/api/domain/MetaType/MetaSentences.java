package com.farm.api.domain.MetaType;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter @Setter
@RequiredArgsConstructor
public class MetaSentences {
    @JsonProperty("content")
    private String content;

    @JsonProperty("emotion")
    private String emotion;
}
