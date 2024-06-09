package com.webbookingticket.fullstack.service;

import com.webbookingticket.fullstack.dto.UserRegistrationDto;
import com.webbookingticket.fullstack.model.Role;
import com.webbookingticket.fullstack.model.User;
import com.webbookingticket.fullstack.repository.RoleRepository;
import com.webbookingticket.fullstack.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;

@Service
public class UserServiceImpl implements UserService {

    private UserRepository userRepository;
    private RoleRepository roleRepository;

//    @Autowired
//    private BCryptPasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    @Override
    public User save(UserRegistrationDto registrationDto) {
        Role userRole = roleRepository.findByName("ROLE_USER");
        if (userRole == null) {
            userRole = new Role("ROLE_USER");
            userRole = roleRepository.save(userRole);
        }
        String password = registrationDto.getPassword();
        password = "{noop}" + password;
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
