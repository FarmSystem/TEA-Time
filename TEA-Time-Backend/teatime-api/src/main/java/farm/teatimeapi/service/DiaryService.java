package farm.teatimeapi.service;

import farm.teatimeapi.dto.analysis.response.DiaryAnalysisDto;
import farm.teatimeapi.dto.diary.request.CreateDiaryDto;
import farm.teatimeapi.dto.diary.response.DiaryDetailDto;
import farm.teatimeapi.utils.ImageUtil;
import farm.teatimeapi.utils.ModelUtil;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Analysis;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.AnalysisRepository;
import farm.teatimedomain.reposiotry.DiaryRepository;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class DiaryService {
    private final DiaryRepository diaryRepository;
    private final UserRepository userRepository;
    private final AnalysisRepository analysisRepository;
    private final ImageUtil imageUtil;
    private final ModelUtil modelUtil;

    @Transactional
    public DiaryDetailDto createDiary(Long userId, CreateDiaryDto createDiaryDto, MultipartFile image) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));

        if (diaryRepository.findByDate(user, LocalDate.now()).isPresent()) {
            throw new CustomException(ErrorCode.ALREADY_WRITE_DIARY);
        }

        Diary diary = diaryRepository.save(Diary.fromDto(createDiaryDto.title(), createDiaryDto.content(), imageUtil.uploadImage(image), user));
        user.writeDiary();
        DiaryAnalysisDto response = modelUtil.makeDiaryAnalysis(createDiaryDto.content());
        analysisRepository.save(Analysis.fromDto(response.score(), response.emotion().happy(),
                response.emotion().embarrassment(), response.emotion().anger(), response.emotion().sadness(),
                response.emotion().anxiety(), diary));
        return DiaryDetailDto.fromEntity(diary);
    }

    public DiaryDetailDto getDiaryDetail(Long diaryId) {
        Diary diary = diaryRepository.findById(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));
        return DiaryDetailDto.fromEntity(diary);
    }

    @Transactional
    public DiaryDetailDto updateDiary(Long userId, Long diaryId, CreateDiaryDto createDiaryDto, MultipartFile image) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));

        Diary diary = diaryRepository.findById(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));

        if (!diary.getUser().equals(user)) {
            throw new CustomException(ErrorCode.USER_NOT_MATCH);
        }

        diary.update(createDiaryDto.title(), createDiaryDto.content(),
                imageUtil.updateImage(image, diary.getImage()));

        return DiaryDetailDto.fromEntity(diary);
    }

    @Transactional
    public void deleteDiary(Long userId, Long diaryId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));

        Diary diary = diaryRepository.findById(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));

        if (!diary.getUser().equals(user)) {
            throw new CustomException(ErrorCode.USER_NOT_MATCH);
        }
        imageUtil.deleteS3File(diary.getImage());
        diaryRepository.deleteById(diaryId);
    }
}
