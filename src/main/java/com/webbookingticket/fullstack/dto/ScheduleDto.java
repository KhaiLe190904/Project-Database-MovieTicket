package com.webbookingticket.fullstack.dto;

import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.model.Room;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ScheduleDto {

    private Long id;

    private Date start;

    private int movie_id;

    private int room_id;

}
