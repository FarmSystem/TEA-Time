package farm.teatimedomain.reposiotry;

import farm.teatimedomain.domain.Analysis;
import farm.teatimedomain.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AnalysisRepository extends JpaRepository<Analysis, Long> {
    @Query("select a from Analysis a where a.diary.id = :diaryId")
    Optional<Analysis> findByDiaryId(Long diaryId);

    @Query("select a from Analysis a where a.diary.user = :user and a.diary.createdAt between :startDate and :endDate")
    List<Analysis> findByUserAndDate(User user, LocalDate startDate, LocalDate endDate);
}
