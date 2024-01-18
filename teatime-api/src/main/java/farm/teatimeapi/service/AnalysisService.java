package farm.teatimeapi.service;

import farm.teatimeapi.dto.analysis.request.AnalysisDto;
import farm.teatimeapi.dto.analysis.response.DiaryAnalysisDto;
import farm.teatimecore.dto.ResponseDto;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Analysis;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.reposiotry.AnalysisRepository;
import farm.teatimedomain.reposiotry.DiaryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class AnalysisService {
    private final RestTemplate restTemplate;
    private final AnalysisRepository analysisRepository;
    private final DiaryRepository diaryRepository;

    public DiaryAnalysisDto getDiaryAnalysis(Long diaryId) {
        Analysis analysis = analysisRepository.findByDiaryId(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_ANALYSIS));
        return DiaryAnalysisDto.fromEntity(analysis, getConsultant(diaryId));
    }

    private String getConsultant(Long diaryId) {
        Diary diary = diaryRepository.findById(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));

        String url = "http://localhost:8080/external";
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        AnalysisDto analysisDto = AnalysisDto.fromEntity(diary);
        HttpEntity<AnalysisDto> request = new HttpEntity<>(analysisDto, headers);
        ResponseEntity<ResponseDto> response = restTemplate.postForEntity(url, request, ResponseDto.class);
        return response.getBody().data().toString();
    }
}
