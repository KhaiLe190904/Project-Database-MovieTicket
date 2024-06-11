package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class UsersViewController {
    private MovieService movieService;

    @Autowired
    public UsersViewController(MovieService movieService) {
        this.movieService = movieService;
    }

    @GetMapping({"/signin"})
    public String checkSignIn(){
        return "Signin/Signin";
    }

    @GetMapping("/home")
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

    @GetMapping("/booking")
    public String checkBooking(){
        return "Booking/Booking";
    }

    @GetMapping("/access-denied")
    public String showAccessDenied() {
        return "Admin/access-denied";
    }
}
