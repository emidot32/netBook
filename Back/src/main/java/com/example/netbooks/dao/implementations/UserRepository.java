package com.example.netbooks.dao.implementations;

import com.example.netbooks.controllers.AuthenticationController;
import com.example.netbooks.dao.mappers.FriendMapper;
import com.example.netbooks.dao.mappers.UserMapper;
import com.example.netbooks.exceptions.CustomException;
import com.example.netbooks.exceptions.EmailNotFountException;
import com.example.netbooks.exceptions.UserNotFoundException;
import com.example.netbooks.models.Role;
import com.example.netbooks.models.SearchIn;
import com.example.netbooks.models.User;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@PropertySource("classpath:queries/user.properties")
@Repository
@Slf4j
public class UserRepository implements com.example.netbooks.dao.interfaces.UserRepository {
	private final NamedParameterJdbcTemplate namedJdbcTemplate;
    @Autowired
    public UserRepository(DataSource dataSource) {
        log.info("Class initialized");
        this.namedJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Value("${saveUser}")
    private String saveUser;

    @Value("${updateUser}")
    private String updateUser;

    @Value("${updateUserById}")
    private String updateUserById;

    @Value("${getAllUsers}")
    private String getAllUsers;

    @Value("${getUserIdByLogin}")
    private String getUserIdByLogin;

    @Value("${countFriendsForUser}")
    private String countFriendsForUser;

    @Value("${findUserByEmail}")
    private String findUserByEmail;

    @Value("${findByLogin}")
    private String findByLogin;

    @Value("${findByUserId}")
    private String findByUserId;

    @Value("${removeUserById}")
    private String removeUserById;

    @Value("${activateUser}")
    private String activateUser;

    @Value("${deActivateUser}")
    private String deActivateUser;

    @Value("${setMinRefreshDate}")
    private String setMinRefreshDate;

    @Value("${getPersonsBySought}")
    private String getPersonsBySought;

    @Value("${getFriendsByLogin}")
    private String getFriendsByLogin;

    @Value("${getClientPersonsBySought}")
    private String getClientPersonsBySought;

    @Value("${getFriendsBySought}")
    private String getFriendsBySought;

    @Value("${getUserRole}")
    private String getUserRole;

    @Value("${getCountFriendsBySought}")
    private String getCountFriendsBySought;

    @Value("${getCountPersonsBySought}")
    private String getCountPersonsBySought;

    @Value("${isSubscribe}")
    private String isSubscribe;

    @Value("${acceptFriendRequest}")
    private String acceptFriendRequest;

    @Value("${addFriend}")
    private String addFriend;

    @Value("${isFriend}")
    private String isFriend;

    @Value("${deleteFriend}")
    private String deleteFriend;

    @Value("${getSubscribersByLogin}")
    private String getSubscribersByLogin;

    @Value("${getFriendsByUsername}")
    private String getFriendsByUsername;

    @Value("${checkUserIsUser}")
    private String checkUserIsUser;

    @Override
    public void save(User user) {
        log.info("Save new user [{}]", user.getLogin());
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("login", user.getLogin());
        namedParams.put("passw", user.getPassword());
        namedParams.put("person_name", user.getName());
        namedParams.put("mail", user.getEmail());
        namedParams.put("avatar_filepath", user.getAvatarFilePath());
        namedParams.put("sex", user.getSex());
        namedParams.put("country", user.getCountry());
        namedParams.put("city", user.getCity());
        namedParams.put("description", user.getStatus());
        namedParams.put("activity", user.isActivity());
        namedParams.put("turn_on_notif", user.isTurnOnNotif());
        namedParams.put("reg_date", user.getRegDate());
        namedParams.put("role_id", user.getRole().ordinal() + 1);
        namedParams.put("min_refresh_date",  user.getMinRefreshDate());
        namedJdbcTemplate.update(saveUser, namedParams);
        log.info("Successful save new user");
    }
    @Override
    public void updateUser(User user) {
        log.info("Update user [{}]", user.getLogin());
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("login", user.getLogin());
        namedParams.put("passw", user.getPassword());
        namedParams.put("person_name", user.getName());
        namedParams.put("mail", user.getEmail());
        namedParams.put("avatar_filepath", user.getAvatarFilePath());
        namedParams.put("sex", user.getSex());
        namedParams.put("country", user.getCountry());
        namedParams.put("city", user.getCity());
        namedParams.put("description", user.getStatus());
        namedParams.put("activity", user.isActivity());
        namedParams.put("turn_on_notif", user.isTurnOnNotif());
        namedParams.put("reg_date", user.getRegDate());
        namedParams.put("role_id", user.getRole().ordinal() + 1);
        namedParams.put("min_refresh_date",  user.getMinRefreshDate());
        namedJdbcTemplate.update(updateUser, namedParams);
        log.info("Successful update user");
    }
    @Override
    public void updateUserById(User user, Long id) {
        log.info("Update user by id [{}]", user.getUserId());
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("login", user.getLogin());
        namedParams.put("passw", user.getPassword());
        namedParams.put("person_name", user.getName());
        namedParams.put("mail", user.getEmail());
        namedParams.put("avatar_filepath", user.getAvatarFilePath());
        namedParams.put("sex", user.getSex());
        namedParams.put("country", user.getCountry());
        namedParams.put("city", user.getCity());
        namedParams.put("description", user.getStatus());
        namedParams.put("activity", user.isActivity());
        namedParams.put("turn_on_notif", user.isTurnOnNotif());
        namedParams.put("reg_date", user.getRegDate());
        namedParams.put("role_id", user.getRole().ordinal() + 1);
        namedParams.put("min_refresh_date",  user.getMinRefreshDate());
        namedParams.put("person_id", id);
        namedJdbcTemplate.update(updateUserById, namedParams);
        log.info("Successful update user");
    }
    @Override
    public Iterable<User> getAllUsers() {
        return namedJdbcTemplate.query(getAllUsers, new UserMapper());
    }
    @Override
    public Integer getUserIdByLogin(String login){
        SqlParameterSource namedParameters = new MapSqlParameterSource("login", login);
        return namedJdbcTemplate.queryForObject(getUserIdByLogin, namedParameters, Integer.class);
    }

    @Override
    public Integer countFriendsForUser(long userId) {
        SqlParameterSource namedParameters = new MapSqlParameterSource("userId", userId);
        return namedJdbcTemplate.queryForObject(countFriendsForUser, namedParameters, Integer.class);

    }
    @Override
    public User findByEmail(String email) {
        try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("mail", email);
            return namedJdbcTemplate.queryForObject(findUserByEmail, namedParams, new UserMapper());
        } catch (EmptyResultDataAccessException e) {
            throw new EmailNotFountException("User with this email not found");
        }
    }
    @Override
    public User findByLogin(String login) {
        try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("login", login);
            return namedJdbcTemplate.queryForObject(findByLogin, namedParams, new UserMapper());
        } catch (EmptyResultDataAccessException e) {
            throw new UserNotFoundException("User [" + login + "] not found ");
        }
    }
    @Override
    public User findByUserId(Long id) {
        try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("person_id", id);
            return namedJdbcTemplate.queryForObject(findByUserId, namedParams, new UserMapper());
        } catch (EmptyResultDataAccessException e) {
            throw new UserNotFoundException("User id[" + id + "] not found ");
        }
    }
    @Override
    public Boolean isExistByLogin(String login) {
        try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("login", login);
            namedJdbcTemplate.queryForObject(findByLogin, namedParams, new UserMapper());
            return true;
        } catch (EmptyResultDataAccessException e) {
            return false;
        }
    }
    @Override
    public Boolean isExistByMail(String mail) {
        try {
            Map<String, Object> namedParams = new HashMap<>();
            namedParams.put("mail", mail);
            namedJdbcTemplate.queryForObject(findUserByEmail, namedParams, new UserMapper());
            return true;
        } catch (EmptyResultDataAccessException e) {
            return false;
        }
    }
    @Override
    public void removeUserById(Long id) {
    	Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("person_id", id);
        namedJdbcTemplate.update(removeUserById, namedParams);
    }
    @Override
    public void activateUser(Long id) {
        log.info("Activate user - id[{}]", id);
    	Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("person_id", id);
        namedJdbcTemplate.update(activateUser, namedParams);
        log.info("Successful activate user");
    }
    @Override
    public void deActivateUser(Long id) {
        log.info("Deactivate user - id[{}]", id);
    	Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("person_id", id);
        namedJdbcTemplate.update(deActivateUser, namedParams);
        log.info("Successful deactivate user");
    }
    @Override
	public void setMinRefreshDate(String login, Date date) {
        log.info("Set min refresh date for user - {}", login);
		Map<String, Object> namedParams = new HashMap<>();
		namedParams.put("min_refresh_date", date);
		namedParams.put("login", login);
        namedJdbcTemplate.update(setMinRefreshDate, namedParams);
	}
    @Override
    public List<User> getFriendsByLogin(String login, int cntFriends, int offset) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("id", findByLogin(login).getUserId());
        namedParams.put("offset", offset);
        namedParams.put("cnt", cntFriends);
        return namedJdbcTemplate.query(getFriendsByLogin, namedParams, new FriendMapper());
    }
    public List<User> getFriendsByUsername(String login) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("id", findByLogin(login).getUserId());
        return namedJdbcTemplate.query(getFriendsByUsername, namedParams, new FriendMapper());
    }

    public List<User> getSubscribersByLogin(String login) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("id", findByLogin(login).getUserId());
        return namedJdbcTemplate.query(getSubscribersByLogin, namedParams, new FriendMapper());
    }

    @Override
    public List<User> getPersonsBySought(String login, String sought, int cntPersons, int offset,
                                         SearchIn where, Role userRole) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("sought", "%" + sought + "%");
        namedParams.put("offset", offset);
        namedParams.put("cnt", cntPersons);
        namedParams.put("login", login);
        if(where == SearchIn.FRIENDS){
            return namedJdbcTemplate.query(getFriendsBySought, namedParams, new FriendMapper());
        } else if(userRole == Role.ROLE_CLIENT){
            return namedJdbcTemplate.query(getClientPersonsBySought, namedParams, new FriendMapper());
        } else
        return namedJdbcTemplate.query(getPersonsBySought, namedParams, new FriendMapper());
    }

    @Override
    public String getUserRole(String login) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("login", login);
        return namedJdbcTemplate.queryForObject(getUserRole, namedParams, String.class);
    }
    @Override
    public void addFriend(String ownLogin, String friendLogin) {
        log.info("{} adding {} to friend", ownLogin, friendLogin);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("ownLogin", ownLogin);
        namedParams.put("friendLogin", friendLogin);
        namedJdbcTemplate.queryForObject(addFriend, namedParams, String.class);
        log.info("Successful adding friend");
    }
    @Override
    public Integer isFriend(String ownLogin, String friendLogin) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("ownLogin", ownLogin);
        namedParams.put("friendLogin", friendLogin);
        return namedJdbcTemplate.queryForObject(isFriend, namedParams, Integer.class);

    }
    @Override
    public void deleteFriend(String ownLogin, String friendLogin) {
        log.info("{} remove {} from friend", ownLogin, friendLogin);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("ownId", findByLogin(ownLogin).getUserId());
        namedParams.put("friendId", findByLogin(friendLogin).getUserId());
        namedJdbcTemplate.update(deleteFriend, namedParams);
        log.info("Successful remove friend");
    }
    public boolean checkPersonIsUser(long userId) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("userId", userId);
        return Objects.equals(namedJdbcTemplate.queryForObject(checkUserIsUser, namedParams, Boolean.class), true);
    }
}

