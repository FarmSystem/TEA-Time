package com.farm.api.domain.MetaType;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@RequiredArgsConstructor
public class MetaEmotions {
    @JsonProperty("result")
    private String result;

    @JsonProperty("pleasure")
    private float pleasure;

    @JsonProperty("anger")
    private float anger;

    @JsonProperty("anxiety")
    private float anxiety;

    @JsonProperty("sadness")
    private float sadness;

    @JsonProperty("horror")
    private float horror;
}
