package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Achievement;
import com.example.netbooks.models.UserAchievement;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class UserAchievementMapper implements RowMapper<UserAchievement> {
    @Override
    public UserAchievement mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        UserAchievement userAchievement = new UserAchievement();
        userAchievement.setAchvId(resultSet.getLong("achv_id"));
        userAchievement.setUserId(resultSet.getLong("user_id"));
        userAchievement.setTitle(resultSet.getString("title"));
        userAchievement.setDescription(resultSet.getString("description"));
        userAchievement.setImagePath(resultSet.getString("image_path"));
        return userAchievement;
    }
}
