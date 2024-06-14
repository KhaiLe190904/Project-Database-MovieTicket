package com.webbookingticket.fullstack.controller;


import com.webbookingticket.fullstack.dto.TicketDto;
import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.service.TicketService;
import com.webbookingticket.fullstack.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/tickets")
@RequiredArgsConstructor
@SessionAttributes("user")
public class TicketController {

    private UserService userService;

    @ModelAttribute("user")
    public UserDto userDto() {
        return new UserDto();
    }

    private final TicketService ticketService;
    @PostMapping("/post")
    @Operation(summary = "Luu 1 ve vao database",
            description = "")
    public ResponseEntity<TicketDto> save(@RequestBody @Valid TicketDto ticketDto) {
       return  ResponseEntity.ok(ticketService.save(ticketDto));
    }

}
