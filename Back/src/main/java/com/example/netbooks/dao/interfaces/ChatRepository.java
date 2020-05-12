package com.example.netbooks.dao.interfaces;

import com.example.netbooks.models.Chat;
import com.example.netbooks.models.Message;
import com.example.netbooks.models.User;

import java.sql.SQLException;
import java.util.List;

public interface ChatRepository {

    List<Chat> getChatsByUserId(Long userId) throws SQLException;
    List<Message> getMessagesByChatId(Long chatId);
    List<User> getChatMembers(Long chatId);

    void saveMessage(Message message);
    void createNewChat(String chatName, List<String> members) throws SQLException;

    void updateChat(Long chatId, String editedChatName, List<String> addedMembers,
                    List<String> removedMembers, String chatAvatar)
            throws SQLException;
}
