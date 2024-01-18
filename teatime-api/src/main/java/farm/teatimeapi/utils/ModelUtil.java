package farm.teatimeapi.utils;

import farm.teatimeapi.dto.analysis.response.DiaryAnalysisDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
@RequiredArgsConstructor
public class ModelUtil {
    private final RestTemplate restTemplate;

    public DiaryAnalysisDto makeDiaryAnalysis(String content) {
        String url = "http://localhost:8082/model/predict";
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        String body = "{\"content\": \"" + content + "\"}";
        HttpEntity<String> request = new HttpEntity<>(body, headers);
        ResponseEntity<DiaryAnalysisDto> response = restTemplate.postForEntity(url, request, DiaryAnalysisDto.class);
        return response.getBody();
    }
}
