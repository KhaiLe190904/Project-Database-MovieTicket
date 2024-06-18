package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.ScheduleDto;
import com.webbookingticket.fullstack.dto.UserDto;
import com.webbookingticket.fullstack.model.Movie;
import com.webbookingticket.fullstack.model.Schedule;
import com.webbookingticket.fullstack.service.MovieService;
import com.webbookingticket.fullstack.service.ScheduleService;
import com.webbookingticket.fullstack.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/schedules")
@RequiredArgsConstructor
@SessionAttributes("user")
public class ScheduleController {

    private final ScheduleService scheduleService;
    private UserService userService;

    @Autowired
    private MovieService movieService;

    @ModelAttribute("user")
    public UserDto userDto() {
        return new UserDto();
    }

    @PostMapping ("/save")
    @Operation(summary = "Luu 1 lich vao database",
               description = "123")
    public ResponseEntity<ScheduleDto> save(@RequestBody @Valid ScheduleDto scheduleDto) {
        return ResponseEntity.ok(scheduleService.save(scheduleDto));
    }

    @GetMapping
    public String listSchedule(@ModelAttribute("user") UserDto userDto, Model model,
                             @RequestParam(defaultValue = "0") int page,
                             @RequestParam(defaultValue = "5") int size) {
        if (userDto.getUsername() == null){
            return "redirect:/access-denied";
        }
        Page<Movie> moviePage = movieService.findPaginated(PageRequest.of(page, size));
        model.addAttribute("movies", moviePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", moviePage.getTotalPages());
        return "Admin/Schedules/schedule";
    }

    // add mapping for "/list"
//    @GetMapping("/list")
//    public ResponseEntity<List<ScheduleDto>> getScheduleByMovieId() {
//        return ResponseEntity.ok(scheduleService.getScheduleByMovieId());
//    }

    @RequestMapping("")
    public String scheduleList() {
        return "Admin/Schedules/schedule";
    }

}
