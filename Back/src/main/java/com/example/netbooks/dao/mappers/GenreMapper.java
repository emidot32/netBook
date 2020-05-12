package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Genre;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class GenreMapper implements RowMapper<Genre> {
    @Override
    public Genre mapRow(ResultSet resultSet, int i) throws SQLException {
        return new Genre(
                resultSet.getLong("genre_id"),
                resultSet.getString("genre_name"));
    }
}
