package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Integer> {
}
