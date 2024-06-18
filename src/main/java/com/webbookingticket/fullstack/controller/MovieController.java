package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.model.Category;
import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.repository.CategoryRepository;
import com.webbookingticket.fullstack.service.MovieService;
import com.webbookingticket.fullstack.service.MovieServiceImpl;
import com.webbookingticket.fullstack.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin/movies")
@SessionAttributes("user")
public class MovieController {
    private final MovieServiceImpl movieServiceImpl;
    private MovieService movieService;
    private UserService userService;

    @Autowired
    private CategoryRepository categoryRepository;

    @ModelAttribute("user")
    public UserDto getUserDto() {
        return new UserDto();
    }

    @Value("${category}")
    private List<String> category;

    @Autowired
    public MovieController(MovieService theMovieService, MovieServiceImpl movieServiceImpl, CategoryRepository categoryRepository) {
        this.movieService = theMovieService;
        this.movieServiceImpl = movieServiceImpl;
        this.categoryRepository = categoryRepository;
    }

    // TIM KIEM
    @GetMapping
    public String listMovies(Model model, @RequestParam(name = "keyword", required = false) String keyword) {

        List<Movie> movies;

        if (keyword != null && !keyword.isEmpty()) {
            movies = movieService.findByNameOrDescriptionOrCategory(keyword);
        } else {
            movies = movieService.findAll();
        }

        model.addAttribute("movies", movies);
        return "Admin/Movies/find-movie";
    }

    @GetMapping("/list")
    public String listMovie(@ModelAttribute("user") UserDto userDto, Model theModel, @RequestParam(defaultValue = "0") int page, @RequestParam(defaultValue = "5") int size) {
        if (userDto.getUsername() == null || userDto.getPassword().equals("test123")) {
//            if(!userDto.getRoles().equals("ROLE_ADMIN")) {
//                return "redirect:/access-denied";
//            }
            return "redirect:/access-denied";
        }
        Page<Movie> moviePage = movieService.findPaginated(PageRequest.of(page, size));
        theModel.addAttribute("movies", moviePage.getContent());
        theModel.addAttribute("currentPage", page);
        theModel.addAttribute("totalPages", moviePage.getTotalPages());
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

}
