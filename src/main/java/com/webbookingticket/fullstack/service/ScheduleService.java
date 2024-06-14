package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.ScheduleDto;
import com.webbookingticket.fullstack.model.Schedule;

import java.util.List;

public interface ScheduleService {
    ScheduleDto save(ScheduleDto schedule);
    List<Schedule> getScheduleByMovieId(int movieId);
}
