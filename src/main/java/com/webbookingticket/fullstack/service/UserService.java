package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.UserRegistrationDto;
import com.webbookingticket.fullstack.model.User;

public interface UserService {
    User save(UserRegistrationDto registrationDto);
}
