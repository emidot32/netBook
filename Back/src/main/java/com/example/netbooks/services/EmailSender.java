package com.example.netbooks.services;

import org.springframework.stereotype.Service;

import com.example.netbooks.controllers.AuthenticationController;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.tomcat.util.ExceptionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

@Service
public class EmailSender {
    private JavaMailSender emailSender;
	private final Logger logger = LogManager.getLogger(EmailSender.class);
    @Autowired
    public EmailSender(JavaMailSender emailSender) {
        this.emailSender = emailSender;
    }
	
	public void sendMessage(String emailTo, String subject, String message){
        SimpleMailMessage simpleMessage = new SimpleMailMessage();
        simpleMessage.setSubject(subject);
        simpleMessage.setText(message);
        simpleMessage.setTo(emailTo);
        
        try {
        	emailSender.send(simpleMessage);
        	logger.info("email for {} was sent", emailTo);
        }catch(Exception e) {
        	logger.error("ERROR: email for {} was not sent", emailTo);
        }
    }

}