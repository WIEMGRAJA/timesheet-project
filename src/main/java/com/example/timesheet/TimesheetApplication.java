package com.example.timesheet;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class TimesheetApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(TimesheetApplication.class, args);
    }
    
    @GetMapping("/")
    public String home() {
        return "Timesheet Application is running!";
    }
    
    @GetMapping("/users")
    public String getUsers() {
        return "List of users";
    }
}
