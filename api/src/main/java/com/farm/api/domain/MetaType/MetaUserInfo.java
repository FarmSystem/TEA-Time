package com.farm.api.domain.MetaType;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter @Setter
@RequiredArgsConstructor
public class MetaUserInfo {
    @JsonProperty("year")
    private int year;
    @JsonProperty("month")
    private int month;
    @JsonProperty("day")
    private int day;
    @JsonProperty("name")
    private String name;
    @JsonProperty("email")
    private String email;
    @JsonProperty("gender")
    private String gender;
}
