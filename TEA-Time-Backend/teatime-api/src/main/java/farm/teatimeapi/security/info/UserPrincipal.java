package farm.teatimeapi.security.info;

import farm.teatimedomain.reposiotry.UserRepository;
import farm.teatimedomain.type.ERole;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

@Slf4j
@Builder
@RequiredArgsConstructor
public class UserPrincipal implements UserDetails {
    @Getter private final Long id;
    @Getter private final ERole role;
    private final String password;
    private final Collection<? extends GrantedAuthority> authorities;

    public static UserPrincipal create(UserRepository.UserSecurityForm form) {
        return UserPrincipal.builder()
                .id(form.getId())
                .role(form.getRole())
                .password(form.getPassword())
                .authorities(Collections.singleton(new SimpleGrantedAuthority(form.getRole().getSecurityName())))
                .build();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return id.toString();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
