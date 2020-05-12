package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Book;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class BookRowMapper implements RowMapper<Book> {
    @Override
    public Book mapRow(ResultSet resultSet, int i) throws SQLException {
        return new Book(
                resultSet.getLong("book_id"),
                resultSet.getString("title"),
                resultSet.getString("image_path"),
                resultSet.getString("release_date"),
                resultSet.getString("description"));
    }
}
