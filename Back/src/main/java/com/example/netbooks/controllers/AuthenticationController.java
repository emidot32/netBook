package com.example.netbooks.controllers;

import com.example.netbooks.exceptions.CustomException;
import com.example.netbooks.models.Role;
import com.example.netbooks.models.User;
import com.example.netbooks.models.VerificationToken;
import com.example.netbooks.security.JwtProvider;
import com.example.netbooks.services.EmailSender;
import com.example.netbooks.services.UserManager;
import com.example.netbooks.services.ValidationService;
import com.example.netbooks.services.VerificationTokenManager;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@RequestMapping(value = "/user-service")
@Slf4j
public class AuthenticationController {
    private UserManager userManager;
    private EmailSender emailSender;
    private PasswordEncoder passwordEncoder;
    private AuthenticationManager authenticationManager;
    private JwtProvider jwtProvider;
    private VerificationTokenManager verificationTokenManager;
    private ValidationService validationService;

    @Autowired
    public AuthenticationController(UserManager userManager,
                                    EmailSender emailSender,
                                    PasswordEncoder passwordEncoder,
                                    AuthenticationManager authenticationManager,
                                    JwtProvider jwtProvider,
                                    VerificationTokenManager verificationTokenManager,
                                    ValidationService validationService) {
        log.info("Class initialized");
        this.userManager = userManager;
        this.emailSender = emailSender;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.jwtProvider = jwtProvider;
        this.verificationTokenManager = verificationTokenManager;
        this.validationService = validationService;
    }

    @GetMapping("/get-id-name")
    public int getIdByUserName(@RequestParam("name") String name){
        return userManager.getUserIdByName(name);
    }

    @PutMapping("/interrupt-sessions/{login}")
    public void interrupt(@PathVariable("login") String login) {
        log.info("PUT /interrupt-sessions/{}", login);
        userManager.setMinRefreshDate(login, null);
    }

    @PostMapping("/register/user")
    public void register(@RequestBody User user){
        log.info("POST /register/user [{}, {}]", user.getLogin(), user.getEmail());
        user.setPassword(passwordEncoder.encode(validationService.passwordValidation(user.getPassword())));
        user.setRole(Role.ROLE_CLIENT);
        userManager.register(validationService.userValidation(user));
    }

    @PutMapping("/verification/user")
    public void confirmUserAccount(@RequestParam("token") String verificationToken) {
        log.info("PUT /verification/user");
        userManager.confirmUserAccount(verificationToken);
    }

    @PostMapping("/signin")
    public ResponseEntity<Map> signin(@RequestBody User user) {
        log.info("POST /signin [{}]", user.getLogin());
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(user.getLogin(), user.getPassword()));
        String role = userManager.getUserRole(user.getLogin());
        Map<Object, Object> response = new HashMap<>();
        response.put("token", jwtProvider.createToken(user.getLogin(), user.getRole()));
        response.put("username", user.getLogin());
        response.put("role", role);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/refresh-token")
    public ResponseEntity<Map> refreshToken() {
        Map<Object, Object> response = new HashMap<>();
        SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        UserDetails currentUserDetails
                = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        response.put("token", jwtProvider.createToken(
                currentUserDetails.getUsername(),
                (Role) (currentUserDetails.getAuthorities().iterator().next())));
        response.put("username", currentUserDetails.getUsername());
        response.put("role", ((Role)currentUserDetails.getAuthorities().iterator().next()).ordinal() + 1);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/remove/{id}")
    public void removeUser(@PathVariable("id") long id) {
        userManager.removeUserById(id);
    }

    @PostMapping("/register/admin")
    public ResponseEntity<Map> register(@RequestBody User user, @RequestParam("token") String verificationToken) {
        if (!userManager.isExistByLogin(user.getLogin())
                && !userManager.isExistByMail(user.getEmail())) {
            VerificationToken token = verificationTokenManager.findVerificationToken(verificationToken);
            if (token != null) {
                user.setPassword(passwordEncoder.encode(user.getPassword()));
                user.setRole(userManager.getUserById(token.getUserId()).getRole());
                user.setRegDate(LocalDate.now());
                userManager.updateUserById(user, token.getUserId());
                userManager.activateUser(token.getUserId());
                verificationTokenManager.removeVerificationToken(verificationToken);
                log.info("Complete Admin Registration! {}", user.getLogin());

                Map<Object, Object> response = new HashMap<>();
                response.put("msg", "Successful registration");
                return ResponseEntity.ok(response);
            } else {
                throw new CustomException("Admin token is invalid.", HttpStatus.UNPROCESSABLE_ENTITY);
            }
        } else {
            throw new CustomException("Username is already in use", HttpStatus.UNPROCESSABLE_ENTITY);
        }
    }

    @PostMapping("/send-admin-reg-mail")
    public ResponseEntity<Map> sendAdminRegMail(@RequestBody String mail) throws IOException {
        User user = userManager.createAndSaveTempAdmin();
        VerificationToken verificationToken = new VerificationToken(
                userManager.getUserByLogin(user.getLogin()).getUserId());
        verificationTokenManager.saveToken(verificationToken);

        String message = "To register your admin account, please click here : "
                + "https://netbooksfront.herokuapp.com/verification-admin?token="
                + verificationToken.getVerificationToken();
        emailSender.sendMessage(mail, "Register admin account!", message);

        Map<Object, Object> response = new HashMap<>();
        response.put("msg", "Successful admin mail snet!");
        return ResponseEntity.ok(response);
    }

    @PostMapping("/send-moder-reg-mail")
    public ResponseEntity<Map> sendModerRegMail(@RequestBody String mail) throws IOException {
        User user = userManager.createAndSaveTempModer();
        VerificationToken verificationToken = new VerificationToken(
                userManager.getUserByLogin(user.getLogin()).getUserId());
        verificationTokenManager.saveToken(verificationToken);

        String message = "To register your moderator account, please click here : "
                + "https://netbooksfront.herokuapp.com/verification-admin?token="
                + verificationToken.getVerificationToken();
        emailSender.sendMessage(mail, "Register moderator account!", message);
        
        Map<Object, Object> response = new HashMap<>();
        response.put("msg", "Successful moder mail snet!");
        return ResponseEntity.ok(response);
    }


    /**
     * Sent link for recovery password on user email
     * @param email user email
     * @exception com.example.netbooks.exceptions.EmailNotFountException when email not found
     */
    @PostMapping("/recovery/password")
    public void requestFroRecoveryPass(@RequestBody String email) {
        log.info("POST /recovery/password for {}", email);
        userManager.requestForRecoveryPass(validationService.emailValidation(email));
    }

    /**
     * Change user password
     * @param verificationToken verification token
     * @param newPass new password
     */
    @PutMapping("/change/password")
    public void recoveryPass(@RequestParam("token") String verificationToken,
                             @RequestBody String newPass) {
        log.info("PUT /change/password");
        userManager.recoveryPass(verificationToken, passwordEncoder.encode(
                validationService.passwordValidation(newPass)));
    }
}
