package com.example.netbooks.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.netbooks.exceptions.TokenValidationException;
import com.example.netbooks.models.Role;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.filter.GenericFilterBean;
import org.springframework.web.filter.OncePerRequestFilter;

import com.example.netbooks.controllers.AuthenticationController;
import com.example.netbooks.exceptions.CustomException;
import org.springframework.web.cors.CorsUtils;
@Slf4j
@Component
public class JwtFilter extends OncePerRequestFilter {
    private JwtProvider jwtProvider;
    @Autowired
    public JwtFilter(JwtProvider jwtProvider) {
        this.jwtProvider = jwtProvider;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain) throws ServletException, IOException {
        attemptAuthentication(httpServletRequest, httpServletResponse, filterChain);
        String token = jwtProvider.resolveToken(httpServletRequest);
        try {
            log.debug("bearer_{}", token);
            if (token != null && jwtProvider.validateToken(token)) {
                Authentication auth = jwtProvider.getAuthentication(token);
                SecurityContextHolder.getContext().setAuthentication(auth);
            }
        } catch (TokenValidationException ex) {
            SecurityContextHolder.clearContext();
            HttpServletResponse response = (HttpServletResponse) httpServletResponse;
            //response.setHeader("Access-Control-Allow-Origin", "http://localhost:4200");
            response.setHeader("Access-Control-Allow-Origin", "https://netbooksfront.herokuapp.com");
            response.setHeader("Access-Control-Allow-Credentials", "true");
            response.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT, OPTIONS, DELETE");
            response.setHeader("Access-Control-Max-Age", "3600");
            response.setHeader("Access-Control-Allow-Headers", "X-Requested-With, " +
                    "Content-Type, Authorization, Origin, Accept, Access-Control-Request-Method, " +
                    "Access-Control-Request-Headers");

            httpServletResponse.sendError(ex.getHttpStatus().value(), ex.getMessage());
            return;
        }
        filterChain.doFilter(httpServletRequest, httpServletResponse);
    }

    private void attemptAuthentication(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain) throws ServletException, IOException {
            httpServletResponse.setStatus(HttpServletResponse.SC_OK);
            //httpServletResponse.setHeader("Access-Control-Allow-Origin", "http://localhost:4200");
            httpServletResponse.setHeader("Access-Control-Allow-Origin", "https://netbooksfront.herokuapp.com");
            httpServletResponse.setHeader("Access-Control-Allow-Credentials", "true");
            httpServletResponse.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT, OPTIONS, DELETE");
            httpServletResponse.setHeader("Access-Control-Max-Age", "3600");
            httpServletResponse.setHeader("Access-Control-Allow-Headers", "X-Requested-With, " +
                    "Content-Type, Authorization, Origin, Accept, Access-Control-Request-Method, " +
                    "Access-Control-Request-Headers");
    }
}
