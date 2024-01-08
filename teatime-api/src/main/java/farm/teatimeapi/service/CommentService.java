package farm.teatimeapi.service;

import farm.teatimedomain.reposiotry.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CommentService {
    private final CommentRepository commentRepository;

    @Transactional
    public void createComment(Long userId, Long diaryId, String content) {

    }
}
