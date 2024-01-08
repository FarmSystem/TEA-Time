package farm.teatimeapi.controller;

import farm.teatimecore.annotation.UserId;
import farm.teatimecore.dto.ResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/me")
@RequiredArgsConstructor
@Tag(name = "My Page", description = "마이페이지 관련 API")
public class MemberController {

    @Operation(summary = "마이페이지 달력 화면 불러오기", description = "마이페이지 달력 화면을 불러옵니다.")
    @GetMapping("/calendar")
    public ResponseDto<?> getCalendar(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "특정 날짜 다이어리 불러오기", description = "특정 날짜의 다이어리를 불러옵니다.")
    @GetMapping("/calendar/{diaryId}")
    public ResponseDto<?> getDiary(
//            @UserId Long userId,
            @PathVariable Long diaryId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "본인 다이어리 분석 조회", description = "본인의 다이어리 분석을 조회합니다.")
    @GetMapping("/analysis")
    public ResponseDto<?> getMyAnalysis(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "본인 프로필 화면 보기", description = "사용자의 프로필 화면을 불러옵니다.")
    @GetMapping("")
    public ResponseDto<?> getMyProfile(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "프로필 수정하기", description = "사용자의 프로필을 수정합니다.")
    @PatchMapping("/profile")
    public ResponseDto<?> updateProfile(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "회원 레벨 보기", description = "사용자의 레벨을 불러옵니다.")
    @GetMapping("/level")
    public ResponseDto<?> getLevel(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }
}
