package farm.teatimeapi.service;

import farm.teatimeapi.dto.diary.request.CreateDiaryDto;
import farm.teatimeapi.dto.diary.response.DiaryDetailDto;
import farm.teatimeapi.utils.ImageUtil;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.CommentRepository;
import farm.teatimedomain.reposiotry.DiaryRepository;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class DiaryService {
    private final DiaryRepository diaryRepository;
    private final UserRepository userRepository;
    private final ImageUtil imageUtil;

    @Transactional
    public DiaryDetailDto createDiary(Long userId, CreateDiaryDto createDiaryDto, MultipartFile image) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        user.writeDiary();
        return DiaryDetailDto.fromEntity(diaryRepository.save(Diary
                .fromDto(createDiaryDto.title(), createDiaryDto.content(), imageUtil.uploadImage(image), user)));
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
        diaryRepository.delete(diary);
    }
}
