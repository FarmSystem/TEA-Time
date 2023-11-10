package com.farm.api.repository;

import com.farm.api.domain.EnumType.LoginPlatform;
import com.farm.api.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query(value = "SELECT u FROM User u WHERE u.socialId = :socialId")
    Optional<User> findBySocialId(@Param("socialId") String socialId);

    @Query(value = "SELECT u FROM User u WHERE u.socialId = :socialId AND u.refreshToken = :refreshToken")
    Optional<User> findBySocialIdAndRefreshToken(@Param("socialId") String socialId, @Param("refreshToken") String refreshToken);

    Optional<User> findBySocialIdAndProvider(@Param("socialId") String socialId, @Param("provider") LoginPlatform provider);

    Optional<User> findBySocialIdAndIsLogin(@Param("socialId") String socialId, @Param("isLogin") boolean isLogin);
}
