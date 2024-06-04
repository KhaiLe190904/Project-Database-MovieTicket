package com.webbookingticket.fullstack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SignInController {
    @GetMapping("/signin")
    public String checkSignIn(@RequestParam(value = "userName", required = false) String userName,
                              @RequestParam(value = "passWord", required = false) String passWord){
        System.out.println("UserName: " + userName + "\n" + "Password: " + passWord);
        return "Navbar/Navbar";
    }
}
