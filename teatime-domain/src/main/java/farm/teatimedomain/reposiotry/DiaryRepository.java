package farm.teatimedomain.reposiotry;

import farm.teatimedomain.domain.Diary;
import farm.teatimedomain.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface DiaryRepository extends JpaRepository<Diary, Long> {
    @Query("select d from Diary d order by d.createdAt desc")
    Page<Diary> findAllDiaries(Pageable pageable);

    @Query("select d from Diary d where d.user = :user order by d.createdAt desc")
    Page<Diary> findAllByUser(User user, Pageable pageable);

    @Query("select count(d) from Diary d where d.user = :user")
    Long countDiariesByUser(User user);

    @Query("select d from Diary d where d.user = :user and d.createdAt between :startDate and :endDate order by d.createdAt asc")
    List<Diary> findDiariesByUserAndCreatedAtBetween(User user, LocalDate startDate, LocalDate endDate);
}
