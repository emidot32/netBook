package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Message;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class MessageMapper implements RowMapper<Message> {
    @Override
    public Message mapRow(ResultSet resultSet, int i) throws SQLException {
        Message message = new Message();
        message.setDateSend(resultSet.getTimestamp("datetime_send").toLocalDateTime());
        message.setFromName(resultSet.getString("login"));
        message.setMessage(resultSet.getString("messege"));
        return message;
    }
}
