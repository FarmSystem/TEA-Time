package com.farm.api.domain.EnumType;

import com.farm.api.exception.CustomException;
import com.farm.api.exception.ErrorCode;

public enum ReactionType {
    LAUGH, SAD, WOW, HEART, GOOD;

    public static ReactionType getReactionType(String reactionType) {
        return switch (reactionType) {
            case "LAUGH" -> LAUGH;
            case "SAD" -> SAD;
            case "WOW" -> WOW;
            case "HEART" -> HEART;
            case "GOOD" -> GOOD;
            default -> throw new CustomException(ErrorCode.NOT_FOUND_REACTION_TYPE);
        };
    }
}
