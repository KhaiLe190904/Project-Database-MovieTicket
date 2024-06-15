package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Schedule;
import com.webbookingticket.fullstack.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TicketRepository extends JpaRepository<Ticket,Integer> {
    @Query("SELECT t.seat FROM Ticket t WHERE t.schedule.id = :scheduleId")
    List<String> findBookedSeatLabelsByScheduleId(Long scheduleId);
}
