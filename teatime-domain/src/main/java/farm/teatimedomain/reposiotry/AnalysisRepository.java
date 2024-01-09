package farm.teatimedomain.reposiotry;

import farm.teatimedomain.domain.Analysis;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.Optional;

@Repository
public interface AnalysisRepository extends JpaRepository<Analysis, Long> {
    @Query("select a from Analysis a where a.diary.id = :diaryId")
    Optional<Analysis> findByDiaryId(Long diaryId);
}
