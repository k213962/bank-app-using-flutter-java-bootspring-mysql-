package org.example.Repository;

import jakarta.persistence.criteria.CriteriaBuilder;
import org.example.Entity.PendingDeposits;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface PendingDepositRepository extends JpaRepository<PendingDeposits, Integer> {

  void deleteById(int pendingDepositId);


}
