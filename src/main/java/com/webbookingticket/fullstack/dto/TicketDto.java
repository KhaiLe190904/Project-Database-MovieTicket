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

    private int id;
    private String seat;
    private int userId;
    private int scheduleId;
    private BigDecimal price;

}
