package com.example.netbooks.controllers;

import com.example.netbooks.models.Role;
import com.example.netbooks.models.SearchIn;
import com.example.netbooks.models.User;
import com.example.netbooks.services.UserManager;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@RequestMapping(value = "/find-persons")
@Slf4j
public class FindPersonController {

    private UserManager userManager;

    @Autowired
    public FindPersonController(UserManager userManager) {
        this.userManager = userManager;
    }

    @GetMapping("/{login}")
    public List<User> getUser(@PathVariable("login") String login,
            @RequestParam("sought") String sought, @RequestParam("where") int where,
            @RequestParam("cnt") int cntPersons, @RequestParam("offset") int offset) {
        if (sought == null) { sought = ""; }
        return userManager.getPersonsBySought(login, sought, cntPersons, offset, SearchIn.values()[where],
                userManager.getCurrentUserRole());
    }
}
