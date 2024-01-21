package farm.teatimeapi.controller;

import farm.teatimeapi.dto.analysis.response.DiaryAnalysisDto;
import farm.teatimeapi.dto.analysis.response.EmotionScoreDto;
import farm.teatimeapi.dto.analysis.response.WeeklyAnalysisDto;
import farm.teatimeapi.service.AnalysisService;
import farm.teatimecore.annotation.UserId;
import farm.teatimecore.dto.ResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/analysis")
@RequiredArgsConstructor
@Tag(name = "Analysis", description = "다이어리 분석 관련 API")
public class AnalysisController {
    private final AnalysisService analysisService;

    @Deprecated
    @Operation(summary = "월별 다이어리 분석 불러오기", description = "월별 다이어리 분석을 불러옵니다.")
    @GetMapping("/monthly")
    public ResponseDto<?> getMonthlyAnalysis(
            @UserId Long userId
    ) {
//        return ResponseDto.ok(analysisService.getMonthlyAnalysis(userId));
        return ResponseDto.ok(null);
    }

    @Deprecated
    @Operation(summary = "주별 다이어리 분석 불러오기", description = "주별 다이어리 분석을 불러옵니다.")
    @GetMapping("/weekly")
    public ResponseDto<WeeklyAnalysisDto> getWeeklyAnalysis(
            @UserId Long userId
    ) {
        return ResponseDto.ok(analysisService.getWeeklyAnalysis(userId));
    }

    @Operation(summary = "다이어리 분석 차트 불러오기", description = "다이어리 분석 차트 결과를 불러옵니다.")
    @GetMapping("/chart")
    public ResponseDto<List<EmotionScoreDto>> getChartScore(
            @UserId Long userId,
            @RequestParam("period") int period
    ) {
        return ResponseDto.ok(analysisService.getChartScore(userId, period));
    }

    @Operation(summary = "회원 다이어리 분석 내용 조회", description = "회원의 다이어리 분석 내용을 조회합니다.")
    @GetMapping("/{diaryId}")
    public ResponseDto<DiaryAnalysisDto> getMemberAnalysis(
            @PathVariable Long diaryId
    ) {
        return ResponseDto.ok(analysisService.getDiaryAnalysis(diaryId));
    }
}
