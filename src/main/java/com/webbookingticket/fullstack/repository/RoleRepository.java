package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Integer> {
    Role findByName(String name);
}
