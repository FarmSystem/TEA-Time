package farm.teatimeapi.controller;

import farm.teatimecore.annotation.UserId;
import farm.teatimecore.dto.ResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/analysis")
@RequiredArgsConstructor
@Tag(name = "Analysis", description = "다이어리 분석 관련 API")
public class AnalysisController {

    @Operation(summary = "월별 다이어리 분석 불러오기", description = "월별 다이어리 분석을 불러옵니다.")
    @GetMapping("/monthly")
    public ResponseDto<?> getMonthlyAnalysis(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "주별 다이어리 분석 불러오기", description = "주별 다이어리 분석을 불러옵니다.")
    @GetMapping("/weekly")
    public ResponseDto<?> getWeeklyAnalysis(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(null);
    }

    @Operation(summary = "회원 다이어리 분석 내용 조회", description = "회원의 다이어리 분석 내용을 조회합니다.")
    @GetMapping("/{memberId}")
    public ResponseDto<?> getMemberAnalysis(
            @PathVariable Long memberId
    ) {
        return ResponseDto.ok(null);
    }
}
