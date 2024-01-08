package farm.teatimeapi.service;

import farm.teatimeapi.dto.diary.request.CreateDiaryDto;
import farm.teatimeapi.dto.diary.response.DiaryDetailDto;
import farm.teatimedomain.reposiotry.CommentRepository;
import farm.teatimedomain.reposiotry.DiaryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class DiaryService {
    private final DiaryRepository diaryRepository;

    @Transactional
    public DiaryDetailDto createDiary(Long userId, CreateDiaryDto createDiaryDto, MultipartFile image) {
        return DiaryDetailDto.builder().build();
    }

    public DiaryDetailDto getDiaryDetail(Long userId, Long diaryId) {
        return DiaryDetailDto.builder().build();
    }

    @Transactional
    public DiaryDetailDto updateDiary(Long userId, Long diaryId) {
        return DiaryDetailDto.builder().build();
    }

    @Transactional
    public void deleteDiary(Long userId, Long diaryId) {
    }
}
