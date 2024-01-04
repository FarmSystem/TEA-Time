package farm.teatimeapi;

import jakarta.annotation.PostConstruct;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import java.util.TimeZone;

@SpringBootApplication(scanBasePackages = {"farm.teatimeapi", "farm.teatimedomain"})
@EntityScan(basePackages = "farm.teatimedomain")
@EnableJpaRepositories(basePackages = "farm.teatimedomain")
public class TeatimeApiApplication {
    @PostConstruct
    public void init() {
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
    }

    public static void main(String[] args) {
        SpringApplication.run(TeatimeApiApplication.class, args);
    }

}
