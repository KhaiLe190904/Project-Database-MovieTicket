package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.model.Movie;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SignInController {
    @GetMapping({"/signin"})
    public String checkSignIn(){
        return "Signin/Signin";
    }

    @GetMapping("/booking")
    public String checkBooking(){
        return "Booking/Booking";
    }
}
