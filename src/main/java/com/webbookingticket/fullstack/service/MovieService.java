package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.model.Movie;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface MovieService {
    List<Movie> findAll();
    Movie findById(int theId);
    Movie save(Movie theEmployee);
    void deleteById(int theId);
    public Movie findMovieByName(String name);
}
