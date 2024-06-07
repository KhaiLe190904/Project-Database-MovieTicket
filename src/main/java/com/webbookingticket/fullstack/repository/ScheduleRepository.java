package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
}
