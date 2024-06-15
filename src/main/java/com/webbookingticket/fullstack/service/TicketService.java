package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.TicketDto;
import com.webbookingticket.fullstack.model.Ticket;
import java.util.List;

public interface TicketService {
    TicketDto save(TicketDto ticket);
    List<String> getBookedSeatLabels(Long scheduleId);
}
