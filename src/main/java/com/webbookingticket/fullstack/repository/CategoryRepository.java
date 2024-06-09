package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    Category findByName(String name);
}
