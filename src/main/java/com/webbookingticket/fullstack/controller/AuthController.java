package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.config.UserAlreadyExistsException;
import com.webbookingticket.fullstack.dto.UserRegistrationDto;
import com.webbookingticket.fullstack.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/signup")
public class AuthController {
//    private UserService userService;
//
//    public AuthController(UserService userService) {
//        this.userService = userService;
//    }

    @ModelAttribute("user")
    public UserRegistrationDto getUserRegistrationDto() {
        return new UserRegistrationDto();
    }

    @GetMapping
    public String showRegistrationForm() {
        return "Signup/Signup";
    }

//    @PostMapping
//    public String registerUserAccount(@ModelAttribute("user") UserRegistrationDto registrationDto, Model model) {
//        try {
//            userService.save(registrationDto);
//        } catch (UserAlreadyExistsException e) {
//            model.addAttribute("error", e.getMessage());
//            return "Signup/Signup";
//        }
//        return "redirect:/signup?success";
//    }
}
