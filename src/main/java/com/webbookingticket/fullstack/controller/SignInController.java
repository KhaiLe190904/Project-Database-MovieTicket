package com.webbookingticket.fullstack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SignInController {
    @GetMapping("/signin")
    public String showSeat(){
        return "Signin";
    }
}
