package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.ScheduleDto;

import java.util.List;

public interface ScheduleService {
    ScheduleDto save(ScheduleDto schedule);
    List<ScheduleDto> getAllSchedules();
}
