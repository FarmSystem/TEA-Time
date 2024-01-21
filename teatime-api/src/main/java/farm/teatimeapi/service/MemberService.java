package farm.teatimeapi.service;

import farm.teatimeapi.dto.member.request.UpdateUserinfoDto;
import farm.teatimeapi.dto.member.response.MemberCalendarDto;
import farm.teatimeapi.dto.member.response.MemberInfoDto;
import farm.teatimeapi.dto.member.response.MemberLevelDto;
import farm.teatimeapi.dto.member.response.MyDiaryDto;
import farm.teatimeapi.utils.ImageUtil;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.DiaryRepository;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final UserRepository userRepository;
    private final DiaryRepository diaryRepository;
    private final ImageUtil imageUtil;

    public String getNickname(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        return user.getNickname();
    }

    public MemberInfoDto getUserInfo(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        Long diaryCount = diaryRepository.countDiariesByUser(user);
        return MemberInfoDto.fromEntity(user, diaryCount);
    }

    public MemberCalendarDto getCalendar(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        List<Diary> diaries = diaryRepository.findDiariesByUserAndCreatedAtBetween(
                user, LocalDate.now().minusMonths(1), LocalDate.now().plusMonths(1)
        );
        return MemberCalendarDto.fromEntity(diaries);
    }

    @Transactional
    public void updateProfile(Long userId, UpdateUserinfoDto requestDto, MultipartFile image) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        if (image != null) {
            String imageUrl = imageUtil.uploadImage(image);
            user.updateUserInfo(requestDto.nickname(), requestDto.introduction(), requestDto.isPublic(), imageUrl);
        } else {
            user.updateUserInfo(requestDto.nickname(), requestDto.introduction(), requestDto.isPublic(), "default");
        }
    }

    public MemberLevelDto getMemberLevel(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        return MemberLevelDto.fromEntity(user);
    }

    public MyDiaryDto getMyDiaries(Long userId, int page, int size) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        Page<Diary> diaries = diaryRepository.findAllByUser(user, PageRequest.of(page, size));
        return MyDiaryDto.fromEntity(diaries.getContent());
    }
}
