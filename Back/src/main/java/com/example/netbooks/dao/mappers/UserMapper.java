package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public final class UserMapper implements RowMapper<User> {
    @Override
    public User mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        User user = new User();
        user.setUserId(resultSet.getLong("person_id"));
        user.setLogin(resultSet.getString("login"));
        user.setPassword(resultSet.getString("passw"));
        user.setName(resultSet.getString("person_name"));
        user.setEmail(resultSet.getString("mail"));
        user.setAvatarFilePath(resultSet.getString("avatar_filepath"));
        user.setSex(resultSet.getString("sex"));
        user.setCountry(resultSet.getString("country"));
        user.setCity(resultSet.getString("city"));
        user.setStatus(resultSet.getString("description"));
        user.setActivity(resultSet.getBoolean("activity"));
        user.setTurnOnNotif(resultSet.getBoolean("turn_on_notif"));
        user.setRegDate(resultSet.getDate("reg_date").toLocalDate());
        user.setRoleInt(resultSet.getInt("role_id"));
        user.setMinRefreshDate(resultSet.getDate("min_refresh_date"));
        return user;
    }
}
