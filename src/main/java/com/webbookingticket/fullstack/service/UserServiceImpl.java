package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.config.UserAlreadyExistsException;
import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.model.Role;
import com.webbookingticket.fullstack.model.User;
import com.webbookingticket.fullstack.repository.RoleRepository;
import com.webbookingticket.fullstack.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;

//    @Autowired
//    private PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
//        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User save(UserDto registrationDto) {
        if (userRepository.findByUsername(registrationDto.getUsername()) != null || userRepository.findByEmail(registrationDto.getEmail()) != null) {
            throw new UserAlreadyExistsException("User with this email already exists.");
        }
        Role userRole = roleRepository.findByName("ROLE_USER");
        if (userRole == null) {
            userRole = new Role("ROLE_USER");
            userRole = roleRepository.save(userRole);
        }
//        String password = passwordEncoder.encode(registrationDto.getPassword());
//        registrationDto.setPassword(password);
        User user = new User(registrationDto.getUsername(),
                            registrationDto.getPassword(),
                            registrationDto.getFullName(),
                            registrationDto.getEmail(),
                            registrationDto.getAddress(),
                            registrationDto.getSdt(),
                            Arrays.asList(userRole));
        return userRepository.save(user);
    }

    @Override
    public Boolean checkPasswordUser(String username, String password) {
        User user = userRepository.findByUsername(username);
        if (user.getPassword().equals(password)) return true;
        return false;
    }

    @Override
    public Boolean checkUsernameUser(String username) {
        User user = userRepository.findByUsername(username);
        if (user==null) return false;
        return true;
    }

    @Override
    public User getUserByUsername(String username) {
        return userRepository.getUserByUsername(username);
    }

    @Override
    public User getUserById(int id) {
        return userRepository.getById(id);
    }



}
