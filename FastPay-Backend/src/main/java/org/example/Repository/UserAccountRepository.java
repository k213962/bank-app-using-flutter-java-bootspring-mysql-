package org.example.Repository;
import org.example.Entity.User;
import org.example.Entity.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@EnableJpaRepositories
@Repository
public interface UserAccountRepository extends JpaRepository<UserAccount,String> {

    UserAccount findOneByAccountNo(String accountNo);

    UserAccount findByUser(User user);

}
