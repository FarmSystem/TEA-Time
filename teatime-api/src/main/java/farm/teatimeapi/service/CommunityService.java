package farm.teatimeapi.service;

import farm.teatimeapi.dto.community.response.FindMemberDto;
import farm.teatimeapi.dto.community.response.GetCommunityDto;
import farm.teatimeapi.dto.community.response.MemberProfileDto;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.DiaryRepository;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class CommunityService {
    private final UserRepository userRepository;
    private final DiaryRepository diaryRepository;
    public GetCommunityDto getCommunity(Long userId, int page, int size) {
        if (page < 0 || size < 0) {
            throw new CustomException(ErrorCode.INVALID_PARAMETER_ERROR);
        }
        Page<Diary> diaries = diaryRepository.findAllDiariesNotUser(userId, PageRequest.of(page, size));
        return GetCommunityDto.fromEntity(diaries.getContent());
    }

    public FindMemberDto findMember(Long userId) {
        Page<User> users = userRepository.findAllByIdNot(userId, PageRequest.of(0, 50));
        List<User> userList = new ArrayList<>(users.getContent());

        Collections.shuffle(userList);
        return FindMemberDto.fromEntity(userList.subList(0, Math.min(5, userList.size())));
    }

    public MemberProfileDto getMemberProfile(Long memberId, int page, int size) {
        if (page < 0 || size < 0) {
            throw new CustomException(ErrorCode.INVALID_PARAMETER_ERROR);
        }

        User user = userRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        Page<Diary> diaries = diaryRepository.findAllByUser(user, PageRequest.of(page, size));

        return MemberProfileDto.fromEntity(user, diaries.getContent());
    }

    public FindMemberDto searchMember(String nickname) {
        List<User> users = userRepository.findByNickname(nickname);
        return FindMemberDto.fromEntity(users);
    }
}
