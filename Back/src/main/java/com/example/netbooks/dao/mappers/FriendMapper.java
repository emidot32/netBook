package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.User;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class FriendMapper implements RowMapper<User> {
    @Override
    public User mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        User user = new User();
        user.setLogin(resultSet.getString("login"));
        user.setName(resultSet.getString("person_name"));
        user.setAvatarFilePath(resultSet.getString("avatar_filepath"));
        return user;
    }
}