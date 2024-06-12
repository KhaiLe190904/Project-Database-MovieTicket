package com.webbookingticket.fullstack.controller;

import com.webbookingticket.fullstack.dto.ScheduleDto;
import com.webbookingticket.fullstack.model.Schedule;
import com.webbookingticket.fullstack.service.ScheduleService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin/schedules")
@RequiredArgsConstructor
public class ScheduleController {

    private final ScheduleService scheduleService;

    @PostMapping ("/save")
    @Operation(summary = "Luu 1 lich vao database",
               description = "123")
    public ResponseEntity<ScheduleDto> save(@RequestBody @Valid ScheduleDto scheduleDto) {
        return ResponseEntity.ok(scheduleService.save(scheduleDto));
    }

    @GetMapping("/list")
    public ResponseEntity<List<ScheduleDto>> getAllSchedules() {
        return ResponseEntity.ok(scheduleService.getAllSchedules());
    }

    @RequestMapping("")
    public String Schedulelist() {
        return "Admin/Schedules/schedule";
    }

}
