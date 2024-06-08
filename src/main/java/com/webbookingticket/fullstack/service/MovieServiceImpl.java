package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MovieServiceImpl implements MovieService{

    private MovieRepository movieRepository;

    @Autowired
    public MovieServiceImpl(MovieRepository theMovieRepository){
        movieRepository = theMovieRepository;
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
        movieRepository.deleteById(theId);
    }

    @Override
    public Movie findMovieByName(String name) {
        return movieRepository.findMovieByName(name);
    }
}
