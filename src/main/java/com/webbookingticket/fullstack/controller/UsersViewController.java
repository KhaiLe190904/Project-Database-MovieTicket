package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.MovieDto;
import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.service.MovieService;
import com.webbookingticket.fullstack.service.ScheduleService;
import com.webbookingticket.fullstack.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@AllArgsConstructor
@SessionAttributes("user")
public class UsersViewController {
    private MovieService movieService;
    private ScheduleService scheduleService;
    private UserService userService;

    @ModelAttribute("user")
    public UserDto userDto() {
        return new UserDto();
    }

    @GetMapping({"/signin"})
    public String showSignInForm(){
        return "Signin/Signin";
    }

    @PostMapping("/signin")
    public String Login(@ModelAttribute("user") UserDto userDto, Model model){
        if(userService.checkUsernameUser(userDto.getUsername())==false){
            return "redirect:/signin?usernamewrong";
        }
        if(userService.checkPasswordUser(userDto.getUsername(),userDto.getPassword())){
            int id = userService.getUserByUsername(userDto.getUsername()).getId();
            return "redirect:/signin?success=" + id;
        }
        return "redirect:/signin?passwordwrong";
    }

    @GetMapping("/home")
    public String listMovieAtHome(Model theModel){
        return "Navbar/Navbar";
    }

    @GetMapping("/info")
    public String showInfo(){
        return "Info/Info";
    }

    @GetMapping("/contact")
    public String showContact(){
        return "Contact/Contact";
    }

    @GetMapping("/booking/{movie_id}")
    public String Booking(@ModelAttribute("user") UserDto userDto,@PathVariable Long movie_id, Model theModel) {
        if (userDto.getUsername() == null) {
            return "redirect:/signin";
        }
        return "Booking/Booking";
    }


    @GetMapping("/movies_list")
    public ResponseEntity<List<MovieDto>> getAllMovies(){
        return ResponseEntity.ok(movieService.getAll());
    }

    @GetMapping("/access-denied")
    public String showAccessDenied() {
        return "Admin/access-denied";
    }

    @GetMapping("/logout")
    public String Logout(@ModelAttribute("user") UserDto userDto, WebRequest request, SessionStatus status){
        // xóa session user ra khoi vi tri
        status.setComplete(); // da hoan thanh
        request.removeAttribute("user", WebRequest.SCOPE_SESSION); // thuc hien xoa user ra khoi tam cua session
        return "redirect:/signin?logout";
    }
}
