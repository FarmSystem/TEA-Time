package com.farm.api.repository;

import com.farm.api.domain.DiaryResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DiaryResultRepository extends JpaRepository<DiaryResult, Long> {
}
