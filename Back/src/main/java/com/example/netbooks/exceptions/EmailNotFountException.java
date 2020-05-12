package com.example.netbooks.exceptions;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
public class EmailNotFountException extends RuntimeException {
    private final String message;
    @Override
    public String getMessage() {
        return message;
    }
}
