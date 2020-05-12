package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Event;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class EventMapper implements RowMapper<Event> {
    @Override
    public Event mapRow(ResultSet resultSet, int i) throws SQLException {
        return new Event(
                resultSet.getString("title"),
                resultSet.getString("date"),
                resultSet.getInt("id"));
    }
}
