package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.config.UserAlreadyExistsException;
import com.webbookingticket.fullstack.dto.UserRegistrationDto;
import com.webbookingticket.fullstack.model.Role;
import com.webbookingticket.fullstack.model.User;
import com.webbookingticket.fullstack.repository.RoleRepository;
import com.webbookingticket.fullstack.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User save(UserRegistrationDto registrationDto) {
        if (userRepository.findByUsername(registrationDto.getUsername()) != null || userRepository.findByEmail(registrationDto.getEmail()) != null) {
            throw new UserAlreadyExistsException("User with this username or email already exists.");
        }
        Role userRole = roleRepository.findByName("ROLE_USER");
        if (userRole == null) {
            userRole = new Role("ROLE_USER");
            userRole = roleRepository.save(userRole);
        }
        String password = passwordEncoder.encode(registrationDto.getPassword());
        registrationDto.setPassword(password);
        User user = new User(registrationDto.getUsername(),
                            registrationDto.getPassword(),
                            registrationDto.getFullName(),
                            registrationDto.getEmail(),
                            registrationDto.getAddress(),
                            registrationDto.getSdt(),
                            Arrays.asList(userRole));
        return userRepository.save(user);
    }

}
