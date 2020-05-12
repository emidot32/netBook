package com.example.netbooks.dao.implementations;

import com.example.netbooks.dao.interfaces.AuthorRepository;
import com.example.netbooks.models.Author;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@PropertySource("classpath:queries/author.properties")
@Repository
public class AuthorRepositoryImpl implements AuthorRepository {
    private final Environment env;
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper<Author> authorMapper;
    private final NamedParameterJdbcTemplate namedJdbcTemplate;

    @Autowired
    public AuthorRepositoryImpl(DataSource dataSource,
                                RowMapper<Author> authorMapper,
                                Environment env,
                                NamedParameterJdbcTemplate namedJdbcTemplate) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.authorMapper = authorMapper;
        this.env = env;
        this.namedJdbcTemplate = namedJdbcTemplate;
    }

    @Override
    public List<Author> getAllAuthors() {
        return jdbcTemplate.query(env.getRequiredProperty("getAllAuthors") , authorMapper);
    }

    @Override
    public void addRowIntoBookAuthor(int bookId, List<String> id) {
        for (String item : id) {
            MapSqlParameterSource namedParameters = new MapSqlParameterSource();
            namedParameters.addValue("bookId", bookId);
            namedParameters.addValue("fullname", item);


            boolean isThisAuthorExist = namedJdbcTemplate.queryForObject(env.getProperty("isThisAuthorExist"), namedParameters, Boolean.class);
            if (!isThisAuthorExist) {
                namedJdbcTemplate.update(env.getProperty("addAuthor"), namedParameters);
            }

            namedJdbcTemplate.update(env.getProperty("addRowIntoBookAuthor"), namedParameters);

        }
    }
}
