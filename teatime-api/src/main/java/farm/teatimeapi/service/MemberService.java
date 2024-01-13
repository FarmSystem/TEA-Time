package farm.teatimeapi.service;

import farm.teatimeapi.dto.member.request.UpdateUserinfoDto;
import farm.teatimeapi.dto.member.response.MemberLevelDto;
import farm.teatimeapi.utils.ImageUtil;
import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final UserRepository userRepository;
    private final ImageUtil imageUtil;

    public String getNickname(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
        return user.getNickname();
    }

    public void getCalendar(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));
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
}
