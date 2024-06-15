package com.webbookingticket.fullstack.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {
    private int id;
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String address;
    private String sdt;
    private List<String> roles;
}
