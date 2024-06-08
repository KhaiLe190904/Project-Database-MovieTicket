package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.UserRegistrationDto;
import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.model.User;
import com.webbookingticket.fullstack.service.MovieService;
import com.webbookingticket.fullstack.service.MovieServiceImpl;
import jakarta.persistence.Column;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MovieController {
    private final MovieServiceImpl movieServiceImpl;
    private MovieService movieService;

    @Autowired
    public MovieController(MovieService theMovieService, MovieServiceImpl movieServiceImpl){
        movieService = theMovieService;
        this.movieServiceImpl = movieServiceImpl;
    }

    @ModelAttribute("user")
    public UserRegistrationDto getUserRegistrationDto() {
        return new UserRegistrationDto();
    }

    @GetMapping("")
    public String listMovieAtHome(Model theModel){
        // get the movies from db
        List<Movie> theMovies = movieService.findAll();
        // filter the movies to include only those that are showing
        List<Movie> showingMovies = theMovies.stream()
                .filter(movie -> movie.getIsShowing() == 1)
                .collect(Collectors.toList());
        // add to the spring model
        theModel.addAttribute("movies", showingMovies);
        return "Navbar/Navbar";
    }

    // add mapping for "/list"
    @GetMapping("/list")
    public String listMovie(Model theModel){

        // get the movies from db
        List<Movie> theMovies = movieService.findAll();
        // add to the spring model
        theModel.addAttribute("movies", theMovies);
        return "Admin/Movies/list-movies";
    }

    @GetMapping("/showFormForAdd")
    public String showFormForAdd(Model theModel){
        // create model attribute to bind form data
        Movie theMovie = new Movie();
        theModel.addAttribute("movie", theMovie);
        return "Admin/Movies/movie-form";
    }

    @PostMapping("/save")
    public String saveMovie(@ModelAttribute("movie") Movie theMovie){
        movieService.save(theMovie);
        return "redirect:/movies/list";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForUpdate(@RequestParam("movieId") int theId, Model theModel){
        Movie theMovie = movieService.findById(theId);
        theModel.addAttribute("movie", theMovie);
        return "Admin/Movies/movie-form";
    }

    @GetMapping("/delete")
    public String deleteMovie(@RequestParam("movieId") int theId){
        movieService.deleteById(theId);
        return "redirect:/movies/list";
    }

    @GetMapping("/list/{name}")
    public Movie findMovieName(@PathVariable String name){
        Movie theMovie = movieService.findMovieByName(name);
        return theMovie;
    }
}
