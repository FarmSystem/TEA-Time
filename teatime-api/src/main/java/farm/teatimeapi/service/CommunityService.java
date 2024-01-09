package farm.teatimeapi.service;

import farm.teatimeapi.dto.community.response.CommunityDto;
import farm.teatimeapi.dto.community.response.FindMemberDto;
import farm.teatimeapi.dto.community.response.GetCommunityDto;
import farm.teatimeapi.dto.community.response.MemberProfileDto;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.Following;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.DiaryRepository;
import farm.teatimedomain.reposiotry.FollowingRepository;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CommunityService {
    private final UserRepository userRepository;
    private final DiaryRepository diaryRepository;
    private final FollowingRepository followingRepository;
    public GetCommunityDto getCommunity(int page, int size) {
        if (page < 0 || size < 0) {
            throw new CustomException(ErrorCode.INVALID_PARAMETER_ERROR);
        }
        Page<Diary> diaries = diaryRepository.findAllDiaries(PageRequest.of(page, size));
        return GetCommunityDto.fromEntity(diaries.getContent());
    }

    public FindMemberDto findMember(Long userId) {
        Page<User> users = userRepository.findAllByIdNot(userId, PageRequest.of(0, 50));
        List<User> userList = users.getContent();

        Collections.shuffle(userList);
        return FindMemberDto.fromEntity(userList.subList(0, Math.min(5, userList.size())));
    }

    public void followMember(Long userId, Long memberId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        User member = userRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));

        if (user.getId().equals(member.getId())) {
            throw new CustomException(ErrorCode.USER_EQUAL_MEMBER);
        }

        if (user.getFollowings().stream().anyMatch(following -> following.getFollowing().getId().equals(member.getId()))) {
            throw new CustomException(ErrorCode.ALREADY_FOLLOWING);
        }

        Following.of(user, member);
    }

    public void unfollowMember(Long userId, Long memberId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        User member = userRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));

        if (user.getId().equals(member.getId())) {
            throw new CustomException(ErrorCode.USER_EQUAL_MEMBER);
        }

        Following following = user.getFollowings().stream()
                .filter(f -> f.getFollowing().getId().equals(member.getId()))
                .findFirst()
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_FOLLOWING));

        followingRepository.delete(following);
    }

    public MemberProfileDto getMemberProfile(Long memberId, int page, int size) {
        if (page < 0 || size < 0) {
            throw new CustomException(ErrorCode.INVALID_PARAMETER_ERROR);
        }

        User user = userRepository.findById(memberId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        Page<Diary> diaries = diaryRepository.findAllByUser(user, PageRequest.of(page, size));

        return MemberProfileDto.fromEntity(user, diaries.getContent());
    }
}
