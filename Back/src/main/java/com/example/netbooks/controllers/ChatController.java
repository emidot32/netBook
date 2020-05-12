package com.example.netbooks.controllers;


import com.example.netbooks.models.Chat;
import com.example.netbooks.models.Message;
import com.example.netbooks.models.User;
import com.example.netbooks.services.ChatService;
import com.example.netbooks.services.UserManager;
import com.example.netbooks.services.ValidationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.sql.SQLException;
import java.util.List;

@RestController
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@RequestMapping(value = "/chat")
@Slf4j
public class ChatController {
    private ChatService chatService;
    private UserManager userManager;
    private ValidationService validationService;
    @Autowired
    public ChatController(ChatService chatService,
                          UserManager userManager,
                          ValidationService validationService) {
        log.info("Class initialized");
        this.chatService = chatService;
        this.userManager = userManager;
        this.validationService = validationService;
    }

    //get chat list by login
    @GetMapping("/{login}/chats")
    public List<Chat> getChatsByLogin(@PathVariable("login")String login) {
        if(!userManager.getCurrentUserLogin().equals(login)) return null;
        return chatService.getChatsByUserId(
                userManager.getUserByLogin(login).getUserId());
    }

    //get chat messages history
    @GetMapping("/{chatId}")
    public List<Message> getMessagesByChatId(@PathVariable("chatId") Long chatId){
        if(!chatService.isMemberOfChat(chatId, userManager.getCurrentUserLogin())) return null;
        return chatService.getMessagesByChatId(chatId);
    }
    @GetMapping("/{chatId}/members")
    public List<User> getChatMembers(@PathVariable("chatId") Long chatId){
        if(!chatService.isMemberOfChat(chatId, userManager.getCurrentUserLogin())) return null;
        return chatService.getChatMembers(chatId);
    }

    @PostMapping("/create/{chatName}")
    public void createNewChat(@PathVariable("chatName")String chatName,
                              @RequestBody List<String> members) throws SQLException {
        log.info("POST /create/{}", chatName);
        chatService.createNewChat(validationService.plainTextValidation(chatName, 2,20), members);
    }

    @PutMapping("/{chatId}/update/{editedChatName}")
    public void updateChat(@PathVariable("chatId") Long chatId,
                           @RequestParam("removedMembers") List<String> removedMembers,
                           @RequestParam("addedMembers") List<String> addedMembers,
                           @RequestParam("oldChatAvatar") String oldChatAvatar,
                           @PathVariable("editedChatName") String editedChatName,
                           @RequestParam(value = "file", required = false) MultipartFile file) throws SQLException {
        log.info("POST /{}/update/{} by {}", chatId, editedChatName, userManager.getCurrentUserLogin());
        if(!chatService.isMemberOfChat(chatId, userManager.getCurrentUserLogin())) return;
        chatService.updateChat(chatId, validationService.plainTextValidation(editedChatName, 2, 20),
                addedMembers, removedMembers, file, oldChatAvatar);
    }
}
