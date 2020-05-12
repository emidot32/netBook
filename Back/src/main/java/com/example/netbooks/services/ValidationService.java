package com.example.netbooks.services;

import com.example.netbooks.exceptions.ValidationException;
import com.example.netbooks.models.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class ValidationService {

    private static final String EMAIL_PATTERN =
            "^[_A-Za-z0-9-.]+@[A-Za-z0-9-]+(.[A-Za-z0-9]+)*(.[A-Za-z]{2,})$";
    private static final String PLAIN_Text_PATTERN =
            "^\\s*[a-zA-Z0-9а-яёАЯЁ_]+(?:\\s*[a-zA-Z0-9а-яёАЯЁ_]+)*\\s*$";
    private static final String LOGIN_PATTERN =
            "^[A-Za-z0-9-._]+$";

    public String stringValidation(String str, int minSize, int maxSize){
        if(str != null && str.length() >= minSize && str.length() <= maxSize){
            return str;
        }else{
            throw new ValidationException("Bad data");
        }
    }

    public String emailValidation(String email){
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(email);
        if (matcher.matches()) return stringValidation(email, 7, 25);
        else throw new ValidationException("Incorrect email");
    }
    public String plainTextValidation(String text, int minSize, int maxSize){
        if(text == null || minSize == text.length()) return null;
        Pattern pattern = Pattern.compile(PLAIN_Text_PATTERN);
        Matcher matcher = pattern.matcher(text);
        if (matcher.matches()) return stringValidation(text, minSize, maxSize);
        else { log.info("test {}", text); throw new ValidationException("Incorrect data");}
    }

    public String loginValidation(String login){
        Pattern pattern = Pattern.compile(LOGIN_PATTERN);
        Matcher matcher = pattern.matcher(login);
        if (matcher.matches()) return stringValidation(login, 2, 15);
        else throw new ValidationException("Incorrect login");
    }
    public String passwordValidation(String pass){
        return stringValidation(pass, 6, 20);
    }

    public User userValidation(User user){
        loginValidation(user.getLogin());
        emailValidation(user.getEmail());
        plainTextValidation(user.getName(), 4,30);
        plainTextValidation(user.getCity(), 0,20);
        plainTextValidation(user.getCountry(), 0,20);
        plainTextValidation(user.getStatus(), 0,50);
        plainTextValidation(user.getSex(), 0,25);
        return user;
    }
}
