package farm.teatimeapi.controller;

import farm.teatimeapi.dto.member.request.UpdateUserinfoDto;
import farm.teatimeapi.dto.member.response.MemberCalendarDto;
import farm.teatimeapi.dto.member.response.MemberInfoDto;
import farm.teatimeapi.dto.member.response.MemberLevelDto;
import farm.teatimeapi.service.MemberService;
import farm.teatimecore.annotation.UserId;
import farm.teatimecore.dto.ResponseDto;
import io.micrometer.common.lang.Nullable;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/me")
@RequiredArgsConstructor
@Tag(name = "My Page", description = "마이페이지 관련 API")
public class MemberController {
    private final MemberService memberService;

    @Operation(summary  = "회원 닉네임 불러오기", description = "회원의 닉네임을 불러옵니다.")
    @GetMapping("/nickname")
    public ResponseDto<?> getNickname(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(memberService.getNickname(userId));
    }

    @Operation(summary = "마이페이지 달력 화면 불러오기", description = "마이페이지 달력 화면을 불러옵니다.")
    @GetMapping("/calendar")
    public ResponseDto<MemberCalendarDto> getCalendar(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(memberService.getCalendar(userId));
    }

    @Operation(summary = "본인 프로필 화면 보기", description = "사용자의 프로필 화면을 불러옵니다.")
    @GetMapping("")
    public ResponseDto<MemberInfoDto> getMyProfile(
//            @UserId Long userId
    ) {
        Long userId = 1L;
        return ResponseDto.ok(memberService.getUserInfo(userId));
    }

    @Operation(summary = "프로필 수정하기", description = "사용자의 프로필을 수정합니다.")
    @PatchMapping(value = "/profile", consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.MULTIPART_FORM_DATA_VALUE})
    public ResponseDto<?> updateProfile(
//            @UserId Long userId,
            @Nullable @RequestPart("image") MultipartFile image,
            @RequestParam("data")UpdateUserinfoDto updateUserinfoDto
            ) {
        Long userId = 1L;
        memberService.updateProfile(userId, updateUserinfoDto, image);
        return ResponseDto.ok(null);
    }
}
