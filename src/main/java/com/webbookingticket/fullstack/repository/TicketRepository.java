package com.webbookingticket.fullstack.repository;

import com.webbookingticket.fullstack.model.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TicketRepository extends JpaRepository<Ticket,Integer> {
}
