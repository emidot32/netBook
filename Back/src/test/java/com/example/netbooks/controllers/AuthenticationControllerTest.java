package com.example.netbooks.controllers;

import com.example.netbooks.dao.implementations.UserRepository;
import com.example.netbooks.models.User;
import com.example.netbooks.security.JwtProvider;
import com.example.netbooks.services.EmailSender;
import com.example.netbooks.services.UserManager;
import com.example.netbooks.services.VerificationTokenManager;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import java.util.HashMap;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
class AuthenticationControllerTest {
    @Autowired
    private AuthenticationController authenticationController;

    @Autowired
    private UserManager userManager;
    @Autowired
    private VerificationTokenManager verificationTokenManager;

    @Autowired
    private MockMvc mockMvc;

    /*register -> verification -> singin -> recovery/password -> change/pass -> signin -> rmUser*/

    @Test
    void registerTest() throws Exception{
        /*
        this.mockMvc.perform(post("/user-service/register/user")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\n" +
                        "  \"username\" : \"test47\",\n" +
                        "  \"email\" : \"test47@mail\",\n" +
                        "  \"name\" : \"test47\",\n" +
                        "  \"password\" : \"123456\"\n" +
                        "}"))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

        User user = userManager.getUserByLogin("test47");
        String token = verificationTokenManager.findVerificationTokenByUserId(user.getUserId()).getVerificationToken();
        this.mockMvc.perform(put("/user-service/verification/user")
                .param("token", token))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

        this.mockMvc.perform(post("/user-service/signin")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\n" +
                        "  \"username\" : \"test47\",\n" +
                        "  \"password\" : \"123456\"\n" +
                        "}"))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

        this.mockMvc.perform(post("/user-service/recovery/password")
                .contentType(MediaType.TEXT_PLAIN)
                .content("test47@mail"))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

        user = userManager.getUserByLogin("test47");
        token = verificationTokenManager.findVerificationTokenByUserId(user.getUserId()).getVerificationToken();

        this.mockMvc.perform(put("/user-service/change/password")
                .param("token", token)
                .contentType(MediaType.TEXT_PLAIN)
                .content("1234567"))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

        this.mockMvc.perform(post("/user-service/signin")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\n" +
                        "  \"username\" : \"test47\",\n" +
                        "  \"password\" : \"1234567\"\n" +
                        "}"))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

        user = userManager.getUserByLogin("test47");
        this.mockMvc.perform(delete("/user-service/remove/" + user.getUserId()))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());

         */
    }
/*
    @Test
    void test2() throws Exception{
        User user = userManager.getUserByLogin("test47");
        this.mockMvc.perform(delete("/user-service/rmuser/" + user.getUserId()))
                .andDo(print())
                .andExpect(status().is2xxSuccessful());
    }
*/

}
