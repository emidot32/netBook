package com.example.netbooks.dao.implementations;

import com.example.netbooks.controllers.AuthenticationController;
import com.example.netbooks.exceptions.CustomException;
import com.example.netbooks.exceptions.TokenValidationException;
import com.example.netbooks.models.VerificationToken;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
@PropertySource("classpath:queries/token.properties")
public class VerificationTokenRepository implements com.example.netbooks.dao.interfaces.VerificationTokenRepository {

	private final Logger logger = LogManager.getLogger(AuthenticationController.class);
	private final NamedParameterJdbcTemplate namedJdbcTemplate;

    @Autowired
    public VerificationTokenRepository(DataSource dataSource) {
		super();
		this.namedJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
	}

    @Value("${saveToken}")
    private String saveToken;

    @Value("${deleteToken}")
    private String deleteToken;

    @Value("${findByVerificationToken}")
    private String findByVerificationToken;

    @Value("${findByVerificationTokenByUserId}")
    private String findByVerificationTokenByUserId;

    private static final class TokenMapper implements RowMapper<VerificationToken> {
        @Override
        public VerificationToken mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        	VerificationToken token = new VerificationToken();        
        	token.setCreatedDate(resultSet.getDate("created_date"));
        	token.setTokenId(resultSet.getLong("token_id"));
        	token.setUserId (resultSet.getInt("user_id"));
        	token.setVerificationToken(resultSet.getString("token_name"));
        	return token;     
        }
    }
    @Override
    public void save(VerificationToken token) {
    	Map<String, Object> namedParams = new HashMap<>();
    	namedParams.put("created_date", token.getCreatedDate());
    	//namedParams.put("token_id", token.getTokenId());
    	namedParams.put("user_id", token.getUserId());
    	namedParams.put("token_name", token.getVerificationToken());
        
        namedJdbcTemplate.update(saveToken, namedParams);
    }
    @Override
    public void removeVerificationToken(String token) {
    	Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("token_name", token);
        namedJdbcTemplate.update(deleteToken, namedParams);
    }

    @Override
    public VerificationToken findByVerificationToken(String token) {
    	try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("token_name", token);
            return namedJdbcTemplate.queryForObject(findByVerificationToken, namedParams, new TokenMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.info("Token is broken or expired - " + token);
            throw new TokenValidationException("Link is broken or expired", HttpStatus.NOT_FOUND);
        }
    }
    @Override
    public VerificationToken findByVerificationTokenByUserId(Long id) {
    	try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("user_id", id);
            return namedJdbcTemplate.queryForObject(findByVerificationTokenByUserId,
            		namedParams, new TokenMapper());
        } catch (EmptyResultDataAccessException e) {
            logger.info("Token not found - " + id);
            return null;
        }
    }
}
