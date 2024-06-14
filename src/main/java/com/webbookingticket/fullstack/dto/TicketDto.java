package com.webbookingticket.fullstack.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TicketDto {
    private String seat_name;
    private int userId;
    private int scheduleId;
    private BigDecimal price;
}
