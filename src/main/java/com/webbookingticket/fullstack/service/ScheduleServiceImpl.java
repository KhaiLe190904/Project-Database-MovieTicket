package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.ScheduleDto;
import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.model.Room;
import com.webbookingticket.fullstack.model.Schedule;
import com.webbookingticket.fullstack.repository.MovieRepository;
import com.webbookingticket.fullstack.repository.RoomRepository;
import com.webbookingticket.fullstack.repository.ScheduleRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class  ScheduleServiceImpl implements ScheduleService {

    private final ScheduleRepository scheduleRepository;
    private final ScheduleRepository theScheduleRepository;
    private final RoomRepository theRoomRepository;
    private final MovieRepository theMovieRepository;


    private final ModelMapper modelMapper;

    @Override
    public ScheduleDto save(ScheduleDto scheduleDto) {
        Schedule schedule = toEntity(scheduleDto);
        schedule = theScheduleRepository.save(schedule);
        return toDto(schedule);
    }

    @Override
    public List<Schedule> getScheduleByMovieId(int movieId) {
        return scheduleRepository.findByMovieId(movieId);
    }

    private Schedule toEntity(ScheduleDto scheduleDto) {
        Optional<Movie> movie = theMovieRepository.findById(scheduleDto.getMovie_id());
        Optional<Room> room = theRoomRepository.findById(scheduleDto.getRoom_id());
        Schedule schedule = modelMapper.map(scheduleDto, Schedule.class);
        schedule.setRoom(room.orElse(null));
        schedule.setMovie(movie.orElse(null));
        return schedule;
    }

    private ScheduleDto toDto(Schedule schedule) {
        int roomId = schedule.getRoom().getId();
        int movieId = schedule.getMovie().getId();
        ScheduleDto scheduleDto = modelMapper.map(schedule, ScheduleDto.class);
        scheduleDto.setRoom_id(roomId);
        scheduleDto.setMovie_id(movieId);
        return scheduleDto;
    }
}
