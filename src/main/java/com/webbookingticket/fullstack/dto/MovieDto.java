package com.webbookingticket.fullstack.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MovieDto {

    private int movieId;
    private String movieName;
    private String trailerUrl;
    private String posterUrl;
    private int isShowing;
}
