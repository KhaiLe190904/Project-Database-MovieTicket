package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Bill;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BillRepository extends JpaRepository<Bill, Integer> {
}
