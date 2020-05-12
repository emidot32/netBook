package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.ViewBook;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class ViewBookMapper implements RowMapper<ViewBook> {
    @Override
    public ViewBook mapRow(ResultSet resultSet, int i) throws SQLException {
        return new ViewBook(
                resultSet.getInt("book_id"),
                resultSet.getString("title"),
                (String[])resultSet.getArray("authors").getArray(),
                resultSet.getLong("likes"),
                resultSet.getString("image_path"),
                resultSet.getDate("release_date"),
                resultSet.getString("lang"),
                resultSet.getInt("pages"),
                (String[])resultSet.getArray("genres").getArray(),
                resultSet.getString("description"));
    }
}
