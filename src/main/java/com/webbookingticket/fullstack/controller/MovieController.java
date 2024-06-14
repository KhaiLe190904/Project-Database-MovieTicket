package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.model.Category;
import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.repository.CategoryRepository;
import com.webbookingticket.fullstack.service.MovieService;
import com.webbookingticket.fullstack.service.MovieServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin/movies")
public class MovieController {
    private final MovieServiceImpl movieServiceImpl;
    private MovieService movieService;

    @Autowired
    private CategoryRepository categoryRepository;

    @Value("${category}")
    private List<String> category;

    @Autowired
    public MovieController(MovieService theMovieService, MovieServiceImpl movieServiceImpl, CategoryRepository categoryRepository) {
        this.movieService = theMovieService;
        this.movieServiceImpl = movieServiceImpl;
        this.categoryRepository = categoryRepository;
    }


    @ModelAttribute("user")
    public UserDto getUserRegistrationDto() {
        return new UserDto();
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
        theModel.addAttribute("category", category);
        return "Admin/Movies/movie-form";
    }

    @PostMapping("/save")
    public String saveMovie(@ModelAttribute("movie") Movie theMovie, RedirectAttributes redirectAttributes){
        Category movieCategory = categoryRepository.findByName(theMovie.getMovieCategory());
        if (movieCategory != null) {
            theMovie.setCategories(Arrays.asList(movieCategory));
        } else {
            throw new RuntimeException("Category not found");
        }
        movieService.save(theMovie);
        redirectAttributes.addFlashAttribute("message", "Movie updated successfully");
        return "redirect:/admin/movies/list";
    }

    @GetMapping("/showFormForUpdate")
    public String showFormForUpdate(@RequestParam("movieId") int theId, Model theModel){
        Movie theMovie = movieService.findById(theId);
        theModel.addAttribute("movie", theMovie);
        theModel.addAttribute("category", category);
        return "Admin/Movies/movie-form";
    }

    @GetMapping("/delete")
    public String deleteMovie(@RequestParam("movieId") int theId, RedirectAttributes redirectAttributes) {
        try {
            movieService.deleteById(theId);
            redirectAttributes.addFlashAttribute("message", "Movie deleted successfully");
        } catch (DataIntegrityViolationException e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Cannot delete movie, as it is referenced by schedules.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "An unexpected error occurred.");
        }
        return "redirect:/admin/movies/list";
    }

    @GetMapping("/list/{name}")
    public Movie findMovieName(@PathVariable String name){
        Movie theMovie = movieService.findMovieByName(name);
        return theMovie;
    }
}
