package com.example.netbooks.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class JwtConfigurer extends WebSecurityConfigurerAdapter {
  private JwtProvider jwtProvider;
  @Autowired
  public JwtConfigurer(JwtProvider jwtProvider) {
    this.jwtProvider = jwtProvider;
  }

  @Override
  protected void configure(HttpSecurity http) throws Exception {
    http.csrf().disable();
    http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
    http.authorizeRequests()
        .antMatchers("/user-service/interrupt-sessions").authenticated()
        .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
        .antMatchers("/user-service/send-admin-reg-mail").hasRole("SUPER_ADMIN")
            .antMatchers("/user-service/send-moder-reg-mail").hasRole("SUPER_ADMIN")
            .antMatchers("/chat/**").hasRole("CLIENT")
            .antMatchers("/profile/{login}/book-list").hasRole("CLIENT")
        //.antMatchers("/notifications}/user").authenticated()
        //.antMatchers("/user-service/users").authenticated()
        //.antMatchers("/user-service/users").hasRole("ADMIN")
        .anyRequest().permitAll();

    http.apply(new JwtFilterConfigurer(jwtProvider));

  }
  @Bean
  public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
  }
  @Override
  @Bean
  public AuthenticationManager authenticationManagerBean() throws Exception {
      return super.authenticationManagerBean();
  }
}
