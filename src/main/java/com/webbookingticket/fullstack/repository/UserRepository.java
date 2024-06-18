package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUsername(String username);
    User findByEmail(String email);
    User getUserByUsername(String username);

}
