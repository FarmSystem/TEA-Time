package farm.teatimeapi.utils;

import farm.teatimeapi.dto.analysis.response.DiaryAnalysisDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
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
    @Value("${client.model.url}") private String externalUrl;

    public DiaryAnalysisDto makeDiaryAnalysis(String content) {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        String body = "{\"content\": \"" + content + "\"}";
        HttpEntity<String> request = new HttpEntity<>(body, headers);
        ResponseEntity<DiaryAnalysisDto> response = restTemplate.postForEntity(externalUrl, request, DiaryAnalysisDto.class);
        return response.getBody();
    }
}
