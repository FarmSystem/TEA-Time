package farm.teatimeapi.service;

import farm.teatimeapi.dto.analysis.response.DiaryAnalysisDto;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Analysis;
import farm.teatimedomain.reposiotry.AnalysisRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AnalysisService {
    private final AnalysisRepository analysisRepository;

    public DiaryAnalysisDto getDiaryAnalysis(Long diaryId) {
        Analysis analysis = analysisRepository.findByDiaryId(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_ANALYSIS));
        return DiaryAnalysisDto.fromEntity(analysis);
    }
}
