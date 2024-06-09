package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
    List<Schedule> findByMovieId(int theId);
}
