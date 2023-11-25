package com.farm.api.controller;

import com.farm.api.annotation.SocialId;
import com.farm.api.dto.diary.request.DiaryCreateRequestDto;
import com.farm.api.dto.diary.response.DiaryUpdateResponseDto;
import com.farm.api.dto.exception.ResponseDto;
import com.farm.api.service.DiaryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/v1/diaries")
@RequiredArgsConstructor
@Slf4j
public class DiaryController {
    private final DiaryService diaryService;

    @PostMapping
    public ResponseDto<Long> createDiary(@RequestParam("title") String title,
                                       @RequestParam("content") String content,
                                       @RequestParam("emotion") String emotion,
                                        @RequestParam("is_private") String isPrivate,
                                        @RequestParam("image") MultipartFile image,
                                        @SocialId String socialId) throws IOException {
        DiaryCreateRequestDto requestDto = new DiaryCreateRequestDto(title, content, emotion, isPrivate);
        return new ResponseDto<>(diaryService.createDiary(socialId, requestDto, image));
    }

    @PatchMapping("/{diaryId}")
    public ResponseDto<DiaryUpdateResponseDto> updateDiary(@PathVariable Long diaryId) {
        return new ResponseDto<>(diaryService.updateDiary(diaryId));
    }

    @DeleteMapping("/{diaryId}")
    public ResponseDto<Long> deleteDiary(@PathVariable Long diaryId) {
        return new ResponseDto<>(diaryService.deleteDiary(diaryId));
    }

//    @GetMapping
//    public ResponseDto<String> getDiary() {
//        return new ResponseDto<>(diaryService.getDiary());
//    }
//
//    @GetMapping("/{diaryId}")
//    public ResponseDto<String> getDiaryDetail(@PathVariable Long diaryId) {
//        return new ResponseDto<>(diaryService.getDiaryDetail(diaryId));
//    }
//
//    @GetMapping("/{diaryId}/analysis")
//    public ResponseDto<String> getDiaryAnalysis(@PathVariable Long diaryId) {
//        return new ResponseDto<>(diaryService.getDiaryAnalysis(diaryId));
//    }

    @PostMapping("/{diaryId}/reaction")
    public ResponseDto<String> postReaction(@PathVariable Long diaryId,
                                            @RequestBody String reaction,
                                            @SocialId String socialId) {
        return new ResponseDto<>(diaryService.postReaction(diaryId, socialId, reaction));
    }
}
