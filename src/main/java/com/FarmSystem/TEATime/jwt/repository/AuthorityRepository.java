package com.FarmSystem.TEATime.jwt.repository;

import com.FarmSystem.TEATime.jwt.domain.Authority;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AuthorityRepository extends JpaRepository<Authority, String> {
}
