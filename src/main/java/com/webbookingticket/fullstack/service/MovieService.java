package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.MovieDto;
import com.webbookingticket.fullstack.model.Movie;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MovieService {
    List<Movie> findAll();
    Movie findById(int theId);
    Movie save(Movie theMovie);
    void deleteById(int theId);
    public Movie findMovieByName(String name);
    MovieDto getMovieDtoById(int movieId);
    List<MovieDto> getAll();
}
