package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.model.Category;
import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.model.Role;
import com.webbookingticket.fullstack.model.Schedule;
import com.webbookingticket.fullstack.repository.CategoryRepository;
import com.webbookingticket.fullstack.repository.MovieRepository;
import com.webbookingticket.fullstack.repository.ScheduleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MovieServiceImpl implements MovieService{

    private MovieRepository movieRepository;

    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    public MovieServiceImpl(MovieRepository theMovieRepository, CategoryRepository theCategoryRepository){
        movieRepository = theMovieRepository;
        categoryRepository = theCategoryRepository;
    }

    @Override
    public List<Movie> findAll() {
        return movieRepository.findAll();
    }

    @Override
    public Movie findById(int theId) {
        Optional<Movie> result = movieRepository.findById(theId);
        Movie theMovie = null;
        if(result.isPresent()){
            theMovie = result.get();
        } else{
            throw new RuntimeException("Didn't find the movie with id - " + theId);
        }
        return theMovie;
    }

    @Override
    public Movie save(Movie theMovie) {
        return movieRepository.save(theMovie);
    }

    @Override
    public void deleteById(int theId) {
        List<Schedule> schedules = scheduleRepository.findByMovieId(theId);
        if (!schedules.isEmpty()) {
            // Handle schedules before deleting movie
            // e.g., throw an exception or remove schedules
            throw new DataIntegrityViolationException("Cannot delete movie, as it is referenced by schedules.");
        }
        movieRepository.deleteById(theId);
    }

    @Override
    public Movie findMovieByName(String name) {
        return movieRepository.findMovieByName(name);
    }
}
