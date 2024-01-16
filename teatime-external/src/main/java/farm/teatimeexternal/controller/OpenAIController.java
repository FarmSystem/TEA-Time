package farm.teatimeexternal.controller;

import farm.teatimecore.dto.ResponseDto;
import farm.teatimeexternal.dto.request.ConsultantDto;
import farm.teatimeexternal.service.OpenAIService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/external")
@RequiredArgsConstructor
public class OpenAIController {
    private final OpenAIService openAIService;

    @PostMapping("")
    public ResponseDto<String> consultant(
            @RequestBody ConsultantDto consultantDto
            ) {
        return ResponseDto.ok(openAIService.consultant(consultantDto));
    }
}
