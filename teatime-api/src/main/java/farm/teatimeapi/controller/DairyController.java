package farm.teatimeapi.controller;

import farm.teatimeapi.dto.diary.request.CreateDiaryDto;
import farm.teatimeapi.dto.diary.response.DiaryDetailDto;
import farm.teatimeapi.service.DiaryService;
import farm.teatimecore.annotation.UserId;
import farm.teatimecore.dto.ResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Nullable;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/diaries")
@RequiredArgsConstructor
@Tag(name = "Diary", description = "일기 관련 API")
public class DairyController {
    private final DiaryService diaryService;

    @Operation(summary = "일기 생성", description = "일기를 생성합니다.")
    @PostMapping(consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseDto<DiaryDetailDto> createDiary(
            @UserId Long userId,
            @Nullable @RequestPart("image") @Schema(description = "다이어리 관련 이미지") MultipartFile image,
            @RequestPart("data") CreateDiaryDto createDiaryDto
            ) {
        return ResponseDto.ok(diaryService.createDiary(userId, createDiaryDto, image));
    }

    @Operation(summary = "특정 일기 자세히 보기", description = "특정 일기를 자세히 보여줍니다.")
    @GetMapping("/{diaryId}")
    public ResponseDto<DiaryDetailDto> getDiaryDetail(
            @PathVariable @Schema(description = "다이어리 ID") Long diaryId
    ) {
        return ResponseDto.ok(diaryService.getDiaryDetail(diaryId));
    }

    @Deprecated
    @Operation(summary = "다이어리 수정하기", description = "다이어리를 수정합니다.")
    @PatchMapping(value = "/{diaryId}", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseDto<DiaryDetailDto> updateDiary(
            @UserId Long userId,
            @PathVariable @Schema(description = "다이어리 ID") Long diaryId,
            @Nullable @RequestPart("image") @Schema(description = "다이어리 관련 이미지") MultipartFile image,
            @RequestPart("data") CreateDiaryDto createDiaryDto
    ) {
        return ResponseDto.ok(diaryService.updateDiary(userId, diaryId, createDiaryDto, image));
    }

    @Operation(summary = "다이어리 삭제하기", description = "다이어리를 삭제합니다.")
    @DeleteMapping("/{diaryId}")
    public ResponseDto<?> deleteDiary(
            @UserId Long userId,
            @PathVariable @Schema(description = "다이어리 ID") Long diaryId
    ) {
        diaryService.deleteDiary(userId, diaryId);
        return ResponseDto.ok(null);
    }
}
