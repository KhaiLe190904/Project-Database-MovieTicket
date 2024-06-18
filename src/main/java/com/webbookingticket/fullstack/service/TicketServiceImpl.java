package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.TicketDto;
import com.webbookingticket.fullstack.model.*;
import com.webbookingticket.fullstack.repository.ScheduleRepository;
import com.webbookingticket.fullstack.repository.TicketRepository;
import com.webbookingticket.fullstack.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class TicketServiceImpl  implements TicketService {

    private final ModelMapper modelMapper;
    private final ScheduleRepository scheduleRepository;
    private final UserRepository userRepository;
    private final TicketRepository ticketRepository;

    @Override
    public TicketDto save(TicketDto ticketDTO) {
        Ticket ticket = toEntity(ticketDTO);
        ticketRepository.save(ticket);
        return toDto(ticket);
    }

    @Override
    public List<String> getBookedSeatLabels(Long scheduleId) {
        // Implement this method to fetch booked seat labels from the database
        return ticketRepository.findBookedSeatLabelsByScheduleId(scheduleId);
    }


    private Ticket toEntity(TicketDto ticketDto) {
        Optional<Schedule> schedule = scheduleRepository.findById(ticketDto.getScheduleId());
        Optional<User> user = userRepository.findById(ticketDto.getUserId());
        Ticket ticket = modelMapper.map(ticketDto, Ticket.class);
        ticket.setUser(user.orElse(null));
        ticket.setSchedule(schedule.orElse(null));
        ticket.setId(null);
        return ticket;
    }

    private TicketDto toDto(Ticket ticket) {
        int user_id = ticket.getUser().getId();
        int schedule_id = ticket.getSchedule().getId();
        TicketDto ticketDTO = modelMapper.map(ticket, TicketDto.class);
        ticketDTO.setUserId(user_id);
        ticketDTO.setScheduleId(schedule_id);
        return ticketDTO;
    }

}
