package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.model.User;

public interface UserService {
    User save(UserDto registrationDto);
    Boolean checkPasswordUser(String username, String password);
    Boolean checkUsernameUser(String username);
    User getUserByUsername(String username);
    User getUserById(int id);
}
