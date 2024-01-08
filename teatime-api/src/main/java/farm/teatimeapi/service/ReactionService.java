package farm.teatimeapi.service;

import farm.teatimecore.exception.CustomException;
import farm.teatimecore.exception.ErrorCode;
import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.Reaction;
import farm.teatimedomain.domain.User;
import farm.teatimedomain.reposiotry.DiaryRepository;
import farm.teatimedomain.reposiotry.ReactionRepository;
import farm.teatimedomain.reposiotry.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ReactionService {
    private final ReactionRepository reactionRepository;
    private final UserRepository userRepository;
    private final DiaryRepository diaryRepository;

    @Transactional
    public void postReaction(Long userId, Long diaryId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_USER));

        Diary diary = diaryRepository.findById(diaryId)
                .orElseThrow(() -> new CustomException(ErrorCode.NOT_FOUND_DIARY));

        reactionRepository.save(Reaction.fromDto(user, diary));
    }
}
