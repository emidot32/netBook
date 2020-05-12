package com.example.netbooks.services;

import com.example.netbooks.dao.implementations.ChatRepositoryImpl;
import com.example.netbooks.models.Chat;
import com.example.netbooks.models.Message;
import com.example.netbooks.models.User;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class ChatService {
    private ChatRepositoryImpl chatRepository;
    private FileStorageService fileStorageService;
    @Autowired
    public ChatService(FileStorageService fileStorageService,
                       ChatRepositoryImpl chatRepository) {
        this.fileStorageService = fileStorageService;
        this.chatRepository = chatRepository;
    }

    public List<Chat> getChatsByUserId(Long userId) {
        return chatRepository.getChatsByUserId(userId);
    }

    public List<Message> getMessagesByChatId(Long chatId) {
        return chatRepository.getMessagesByChatId(chatId);
    }

    public void saveMessage(Message message) {
        chatRepository.saveMessage(message);
    }

    public void createNewChat(String chatName, List<String> members) throws SQLException {
        chatRepository.createNewChat(chatName, members);
    }

    public List<User> getChatMembers(Long chatId) {
        return chatRepository.getChatMembers(chatId);
    }

    public void updateChat(Long chatId, String editedChatName,
                           List<String> addedMembers,
                           List<String> removedMembers,
                           MultipartFile file, String oldChatAvatar) throws SQLException {
        addedMembers.add("");
        removedMembers.add("");
        String newChatAvatar = oldChatAvatar;
        if (file != null) {
            fileStorageService.deleteFile(oldChatAvatar);
            newChatAvatar = UUID.randomUUID().toString();
            fileStorageService.saveFile(file, newChatAvatar);
        }
        chatRepository.updateChat(chatId, editedChatName, addedMembers, removedMembers, newChatAvatar);
    }

    public boolean isMemberOfChat(Long chatId, String login){
        List<User> members = chatRepository.getChatMembers(chatId);
        for(User member: members){
            if(member.getLogin().equals(login))
                return true;
        }
        return false;
    }
}
