package farm.teatimeexternal.service;

import farm.teatimeexternal.dto.request.ConsultantDto;
import farm.teatimeexternal.utils.OpenAIUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OpenAIService {
    private final OpenAIUtil openAIUtil;

    public String consultant(ConsultantDto consultantDto) {
        String score = "해당 일기 내용의 총 감정 점수는 " + consultantDto.score().toString() + "점 입니다. "
                + "해당 일기는 다음과 같은 비율로 작성되어 있습니다. " +
                "행복의 비율은 " + consultantDto.happy().toString() + "퍼센트 이며" +
                "슬픔의 비율은 " + consultantDto.sadness().toString() + "퍼센트 이며" +
                "분노의 비율은 " + consultantDto.anger().toString() + "퍼센트 이며" +
                "불안의 비율은 " + consultantDto.anxiety().toString() + "퍼센트 이며" +
                "당황의 비율은 " + consultantDto.embarrassment().toString() + "퍼센트 입니다. ";
        return openAIUtil.consultant(consultantDto.content(), score);
    }
}
