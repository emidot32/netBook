package com.example.netbooks.dao.implementations;


import com.example.netbooks.dao.mappers.FullAchievementMapper;
import com.example.netbooks.dao.mappers.UserAchievementMapper;
import com.example.netbooks.models.Achievement;
import com.example.netbooks.models.UserAchievement;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@PropertySource("classpath:queries/achievement.properties")
@Repository
public class AchievementRepository {
    private final DataSource dataSource;
    private final NamedParameterJdbcTemplate namedJdbcTemplate;
    private final Environment env;
    private final UserAchievementMapper userAchievementMapper;
    private final FullAchievementMapper fullAchievementMapper;

    public AchievementRepository(DataSource dataSource, NamedParameterJdbcTemplate namedJdbcTemplate, Environment env, UserAchievementMapper userAchievementMapper, FullAchievementMapper fullAchievementMapper) {
        this.dataSource = dataSource;
        this.namedJdbcTemplate = namedJdbcTemplate;
        this.env = env;
        this.userAchievementMapper = userAchievementMapper;
        this.fullAchievementMapper = fullAchievementMapper;
    }

    private final class AchievementMapper implements RowMapper<Achievement> {
        @Override
        public Achievement mapRow(ResultSet resultSet, int rowNum) throws SQLException {
            Achievement achievement = new Achievement();
            achievement.setTitle(resultSet.getString("title"));
            achievement.setDescription(resultSet.getString("description"));
            achievement.setAmount(resultSet.getInt("n"));
            achievement.setImagePath(resultSet.getString("image_path"));
            return achievement;
        }
    }
    public List<Achievement> findByAchievementId(Long id) {
        try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("user_id", id);
            return namedJdbcTemplate.query(env.getProperty("findByAchievementId"),
                    namedParams, new AchievementMapper());
        } catch (EmptyResultDataAccessException e) {
            log.info("Achievment not found - " + id);
            return null;
        }
    }
    public Long getAchvIdByDescription(String achvType, int n){
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("achvType", achvType);
        namedParameters.addValue("n", n);
        try {
            return namedJdbcTemplate.queryForObject(env.getProperty("getAchvIdByDesc"), namedParameters, Long.class);
        }
        catch (EmptyResultDataAccessException e) {
            return null;
        }

    }

    public void addAchievementForUser(long achvId, long userId){
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("achvId", achvId);
        namedParameters.addValue("userId", userId);
        namedJdbcTemplate.update(env.getProperty("addAchievementForUser"), namedParameters);
    }

    public boolean addAchievement(Achievement achievement){
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("add_achievement");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("achvTitle",achievement.getTitle())
                .addValue("amount", achievement.getAmount())
                .addValue("achvDescription", achievement.getDescription())
                .addValue("imagePath", achievement.getImagePath())
                .addValue("authorName", achievement.getAuthorName())
                .addValue("genreName", achievement.getGenreName())
                .addValue("favouriteBook", achievement.isFavourite())
                .addValue("readBook", achievement.isReadBook());
        return jdbcCall.executeFunction(Boolean.class, in);
    }

    public boolean checkAchievementAuthor(long bookId, long userId, String favOrRead) {
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("check_achievement_author");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("bookId", bookId)
                .addValue("userId", userId)
                .addValue("favOrRead", favOrRead);
        return jdbcCall.executeFunction(Boolean.class, in);
    }

    public boolean checkAchievementGenre(long bookId, long userId, String favOrRead) {
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("check_achievement_genre");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("bookId", bookId)
                .addValue("userId", userId)
                .addValue("favOrRead", favOrRead);
        return jdbcCall.executeFunction(Boolean.class, in);
    }

    public UserAchievement getLastUserAchievement(long userId){
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        return namedJdbcTemplate.queryForObject(env.getProperty("getLastUserAchievement"), namedParameters, userAchievementMapper);
    }
    public boolean checkAchvInUserAchv(long userId, long achvId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        namedParameters.addValue("achvId", achvId);
        return namedJdbcTemplate.queryForObject(env.getProperty("checkAchvInUserAchv"), namedParameters, Boolean.class);
    }
    public List<Achievement> getAchievements(int page, int size){
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("offset", page);
        namedParameters.addValue("count", size);
        return namedJdbcTemplate.query(env.getProperty("getAchievements"),  namedParameters, fullAchievementMapper);
    }
    public UserAchievement checkUserAchievement(long userId, String achievementType) throws NullPointerException {
        SimpleJdbcCall jdbcCall = null;
        switch (achievementType){
            case "review":
                jdbcCall = new
                    SimpleJdbcCall(dataSource).withProcedureName("check_review_achievement");
                break;
            case "bookInProfile":
                jdbcCall = new
                    SimpleJdbcCall(dataSource).withProcedureName("check_book_in_profile_achievement");
                break;
            case "addedBooks":
                jdbcCall = new
                        SimpleJdbcCall(dataSource).withProcedureName("check_add_book_or_announcement_achievement");
                break;
            case "friends":
                jdbcCall = new
                        SimpleJdbcCall(dataSource).withProcedureName("check_friend_achievement");
                break;
        }

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("userId", userId);
        Map<String, Object> out = jdbcCall.execute(in);
        UserAchievement userAchievement = new UserAchievement();
        userAchievement.setUserId(((Integer) out.get("user_id")).longValue());
        userAchievement.setAchvId(((Integer) out.get("achv_id")).longValue());
        userAchievement.setTitle((String) out.get("title"));
        userAchievement.setDescription((String) out.get("description"));
        userAchievement.setImagePath((String) out.get("image_path"));
        return userAchievement;
    }
    public void removeAchievement(long achvId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("achvId", achvId);
        namedJdbcTemplate.update(env.getProperty("deleteAchievement"),  namedParameters);
    }

}
