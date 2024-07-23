package org.example.Repository;

import org.example.Entity.Transaction;
import org.example.Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface TransactionRepository extends JpaRepository<Transaction,Integer> {

    List<Transaction> findAllBySender(User user);
    List<Transaction> findAllByReceiver(User user);
}
