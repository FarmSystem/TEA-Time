package farm.teatimedomain.reposiotry;

import farm.teatimedomain.domain.User;
import farm.teatimedomain.type.ERole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    @Query("select u.id as id, u.role as role, u.password as password from User u where u.id = :id and u.isLogin = true")
    Optional<UserSecurityForm> findSecurityFormById(Long id);

    @Query("select u.id as id, u.role as role, u.password as password from User u where u.email = :email")
    Optional<UserSecurityForm> findSecurityFormByEmail(String email);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.refreshToken = :refreshToken, u.isLogin = :isLogin where u.id = :id")
    void updateRefreshTokenAndLoginStatus(Long id, String refreshToken, Boolean isLogin);
    interface UserSecurityForm {
        Long getId();
        ERole getRole();
        String getPassword();
    }
}
