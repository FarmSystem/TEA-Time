package farm.teatimeapi.service;

import farm.teatimedomain.reposiotry.ReactionRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ReactionService {
    private final ReactionRepository reactionRepository;

    @Transactional
    public void postReaction(Long userId, Long diaryId) {

    }
}
