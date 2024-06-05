package com.webbookingticket.fullstack.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SignInController {
    @GetMapping({"/signin"})
    public String checkSignIn(){
        return "Signin/Signin";
    }
    @GetMapping("/")
    public String checkHome(@RequestParam(value = "signInUserName", required = false) String userName,
                            @RequestParam(value = "signInPassWord", required = false) String passWord){
        System.out.println("UserName: " + userName + "\n" + "Password: " + passWord);
        return "Navbar/Navbar";
    }
    @GetMapping("/signup")
    public String checkSignup(){
        return "Signup/Signup";
    }
}
