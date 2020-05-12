package com.example.netbooks;

import com.example.netbooks.dao.implementations.AchievementRepository;
import com.example.netbooks.dao.implementations.JdbcBookRepository;
import com.example.netbooks.services.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.mail.javamail.JavaMailSender;

import com.example.netbooks.services.EmailSender;

@SpringBootApplication
public class NetbooksApplication  {
	public static void main(String[] args) {
		SpringApplication.run(NetbooksApplication.class, args);
	}

}
