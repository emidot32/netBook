package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Achievement;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class FullAchievementMapper implements RowMapper<Achievement> {
    @Override
    public Achievement mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        Achievement achievement = new Achievement();
        achievement.setAchievementId(resultSet.getLong("achv_id"));
        achievement.setTitle(resultSet.getString("title"));
        achievement.setDescription(resultSet.getString("description"));
        achievement.setAmount(resultSet.getInt("n"));
        achievement.setImagePath(resultSet.getString("image_path"));
        achievement.setAchvType(resultSet.getString("achv_type"));
        achievement.setAchvRuleId(resultSet.getLong("achv_rule_id"));
        achievement.setAuthorName(resultSet.getString("author_name"));
        achievement.setGenreName(resultSet.getString("genre_name"));
        achievement.setFavourite(resultSet.getBoolean("favourite"));
        achievement.setReadBook(resultSet.getBoolean("read_book"));
        return achievement;
    }
}
