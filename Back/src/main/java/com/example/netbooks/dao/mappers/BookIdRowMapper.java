package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Author;
import com.example.netbooks.models.Book;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class BookIdRowMapper implements RowMapper<Book> {
    @Override
    public Book mapRow(ResultSet resultSet, int i) throws SQLException {
        return new Book(
                resultSet.getInt("book_id")
        );
    }
}
