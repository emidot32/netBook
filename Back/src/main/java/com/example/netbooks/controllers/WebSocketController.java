package com.example.netbooks.controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;

import com.example.netbooks.models.Message;
import com.example.netbooks.security.WebSocketConfig;
import com.example.netbooks.services.ChatService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;

import com.google.gson.Gson;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping(value = "/socket")
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@Import(WebSocketConfig.class)
@Slf4j
public class WebSocketController {
    private SimpMessagingTemplate simpMessagingTemplate;
    private ChatService chatService;
    @Autowired
    public WebSocketController(SimpMessagingTemplate simpMessagingTemplate, ChatService chatService) {
        this.simpMessagingTemplate = simpMessagingTemplate;
        this.chatService = chatService;
    }

    @MessageMapping("/send/message/{toChatId}")
    public Message sendMessage(Message message, @DestinationVariable Long toChatId) {
        message.setDateSend(LocalDateTime.now());
        message.setToId(toChatId);
        chatService.saveMessage(message);
        this.simpMessagingTemplate.convertAndSend("/socket-publisher/" +
                message.getToId(), message);
        return message;
    }
}
