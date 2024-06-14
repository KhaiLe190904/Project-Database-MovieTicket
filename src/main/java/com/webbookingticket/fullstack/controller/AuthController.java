package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.service.UserService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@AllArgsConstructor
@RequestMapping("/signup")
public class AuthController {
    private UserService userService;

    @ModelAttribute("user")
    public UserDto getUserRegistrationDto() {
        return new UserDto();
    }

    @GetMapping
    public String showRegistrationForm() {
        return "Signup/Signup";
    }

    @PostMapping
    public String registerUserAccount(@ModelAttribute("user") UserDto registrationDto, Model model) {
        if (userService.checkUsernameUser(registrationDto.getUsername())) {
            return "redirect:/signup?username_exist";
        }
        userService.save(registrationDto);
        return "redirect:/signup?success";
    }
}
