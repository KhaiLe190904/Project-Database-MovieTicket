package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.MovieDto;
import com.webbookingticket.fullstack.model.*;
import com.webbookingticket.fullstack.repository.CategoryRepository;
import com.webbookingticket.fullstack.repository.MovieRepository;
import com.webbookingticket.fullstack.repository.ScheduleRepository;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MovieServiceImpl implements MovieService{

    private final ModelMapper modelMapper;

    private final MovieRepository movieRepository;

    @Autowired
    private ScheduleRepository scheduleRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Movie> findAll() {
        return movieRepository.findAll();
    }

    @Override
    public List<Movie> findByNameOrDescriptionOrCategory(String keyword) {
        return movieRepository.findByNameContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrMovieCategoryContainingIgnoreCase(keyword, keyword, keyword);
    }

    @Override
    public Page<Movie> findPaginated(PageRequest pageRequest) {
        return movieRepository.findAll(pageRequest);
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

    @Override
    public MovieDto getMovieDtoById(int movieId) {
        return null;
    }

    @Override
    public List<MovieDto> getAll() {
        List<Movie> movies = movieRepository.findAll();
        return movies.stream().map(this::toDto).toList();
    }

    private Movie toEntity(MovieDto movieDto) {
        Movie movie = modelMapper.map(movieDto, Movie.class);
        return movie;
    }

    private MovieDto toDto(Movie movie) {
        MovieDto movieDto = modelMapper.map(movie, MovieDto.class);
        return movieDto;
    }


}
