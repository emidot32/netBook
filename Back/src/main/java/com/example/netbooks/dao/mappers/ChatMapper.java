package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Chat;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class ChatMapper implements RowMapper<Chat> {
    @Override
    public Chat mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        Chat chat = new Chat();
        chat.setChatName(resultSet.getString("chat_name"));
        chat.setChatId(resultSet.getLong("chat_id"));
        chat.setChatAvatar(resultSet.getString("avatar_file_path"));
        return chat;
    }
}
