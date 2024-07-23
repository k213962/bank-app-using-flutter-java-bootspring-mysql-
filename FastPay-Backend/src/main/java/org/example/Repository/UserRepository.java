package org.example.Repository;

import org.example.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@EnableJpaRepositories
@Repository
public interface UserRepository extends JpaRepository<User,Integer> {
    User findOneByEmail(String email);
    User findOneByEmailAndPinCode(String email,String pinCode);

    void deleteByUserId(int userId);

    User findOneByUserId(int Id);

}
