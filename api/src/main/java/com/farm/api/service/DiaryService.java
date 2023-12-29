package com.farm.api.service;

import com.farm.api.domain.Diary;
import com.farm.api.domain.EnumType.ReactionType;
import com.farm.api.domain.MetaType.MetaDiary;
import com.farm.api.domain.Reaction;
import com.farm.api.domain.User;
import com.farm.api.dto.diary.request.DiaryCreateRequestDto;
import com.farm.api.dto.diary.response.DiaryUpdateResponseDto;
import com.farm.api.exception.CustomException;
import com.farm.api.exception.ErrorCode;
import com.farm.api.repository.DiaryRepository;
import com.farm.api.repository.ReactionRepository;
import com.farm.api.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class DiaryService {
    private final DiaryRepository diaryRepository;
    private final UserRepository userRepository;
    private final ReactionRepository reactionRepository;

    public Long createDiary(String socialId, DiaryCreateRequestDto requestDto, MultipartFile image) throws IOException {
        String filePath = uploadImage(image);
        MetaDiary metaDiary = new MetaDiary(requestDto.getTitle(), requestDto.getContent(), filePath, requestDto.getEmotion(), requestDto.getIsPrivate().equals("true"));
        User user = userRepository.findBySocialId(socialId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        return diaryRepository.save(new Diary(user, metaDiary)).getId();
    }

    public DiaryUpdateResponseDto updateDiary(Long diaryId) {
        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));
        MetaDiary metaDiary = diary.getDiary();
        diary.updateDiaryPrivacy(metaDiary);
        return new DiaryUpdateResponseDto(diaryId, metaDiary.getTitle(), metaDiary.getContent(), metaDiary.getEmoji(), String.valueOf(metaDiary.isPrivate()));
    }

    public Long deleteDiary(Long diaryId) {
        diaryRepository.deleteById(diaryId);
        return diaryId;
    }

    public String postReaction(Long diaryId, String reaction, String socialId) {
        Diary diary = diaryRepository.findById(diaryId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));
        User user = userRepository.findBySocialId(socialId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        reactionRepository.save(new Reaction(ReactionType.getReactionType(reaction), diary, user));
        return "";
    }

    private static String uploadImage(MultipartFile file) throws IOException {
        String dirPath = System.getProperty("user.dir") + File.separator + "images" + File.separator + "diary";
        File directory = new File(dirPath);
        if (!directory.exists()) {
            directory.mkdirs();
        }

        String extension = getFileExtension(file.getOriginalFilename());
        String fileName = UUID.randomUUID() + (extension.isEmpty() ? "" : "." + extension);
        String filePath = dirPath + File.separator + fileName;

        file.transferTo(new File(filePath));
        return filePath;
    }

    private static String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
}
