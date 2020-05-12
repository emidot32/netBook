package com.example.netbooks.exceptions;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.http.HttpStatus;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
public class TokenValidationException extends RuntimeException{
    private final String message;
    private final HttpStatus httpStatus;
    @Override
    public String getMessage() {
        return message;
    }
}

