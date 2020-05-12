package com.example.netbooks.exceptions.ExceptionHandler;

import com.example.netbooks.exceptions.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

    @ExceptionHandler(UserNotFoundException.class)
    protected ResponseEntity handleUserNotFoundException() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).
                body(new SimpleException("There is no such user"));
    }
    @ExceptionHandler(EmailNotFountException.class)
    protected ResponseEntity handleEmailNotFountException() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).
                body(new SimpleException("User with this email not found"));
    }
    @ExceptionHandler(UploadFileException.class)
    protected ResponseEntity handleUploadFileException() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).
                body(new SimpleException("Failde to upload file"));
    }
    @ExceptionHandler(DownloadFileException.class)
    protected ResponseEntity handleDownloadFileException() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).
                body(new SimpleException("Failde to load file"));
    }
    @ExceptionHandler(ValidationException.class)
    protected ResponseEntity handleValidationException() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).
                body(new SimpleException("Incorrect data"));
    }

    @ExceptionHandler(LoginExistException.class)
    protected ResponseEntity handleLoginExistException() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).
                body(new SimpleException("User with this login already exist"));
    }
    @ExceptionHandler(EmailExistException.class)
    protected ResponseEntity handleEmailExistException() {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).
                body(new SimpleException("User with this email already exist"));
    }
    @ExceptionHandler(TokenValidationException.class)
    protected ResponseEntity handleTokenValidationException() {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).
                body(new SimpleException("Link is broken or expired"));
    }
    @ExceptionHandler(Exception.class)
    protected ResponseEntity handleDefaultException() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).
                body(new SimpleException("An unexpected error has occurred. Please contact system administrator"));
    }


    @Data
    @AllArgsConstructor
    private static class SimpleException {
        private String message;
    }
}
