package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.MovieDto;
import com.webbookingticket.fullstack.model.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;

public interface MovieService {
    List<Movie> findAll();
    Movie findById(int theId);
    Movie save(Movie theMovie);
    void deleteById(int theId);
    public Movie findMovieByName(String name);
    MovieDto getMovieDtoById(int movieId);
    List<MovieDto> getAll();
    Page<Movie> findPaginated(PageRequest pageRequest);
    List<Movie> findByNameOrDescriptionOrCategory(String keyword);
}
