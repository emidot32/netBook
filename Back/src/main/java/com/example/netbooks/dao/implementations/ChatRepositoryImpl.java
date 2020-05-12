package com.example.netbooks.dao.implementations;

import com.example.netbooks.dao.interfaces.ChatRepository;
import com.example.netbooks.dao.mappers.ChatMapper;
import com.example.netbooks.dao.mappers.FriendMapper;
import com.example.netbooks.dao.mappers.MessageMapper;
import com.example.netbooks.models.Chat;
import com.example.netbooks.models.Message;
import com.example.netbooks.models.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@PropertySource("classpath:queries/chat.properties")
@Repository
@Slf4j
public class ChatRepositoryImpl implements ChatRepository {
    private DataSource dataSource;
    private NamedParameterJdbcTemplate namedJdbcTemplate;

    @Autowired
    public ChatRepositoryImpl(NamedParameterJdbcTemplate namedJdbcTemplate,
                              DataSource dataSource) {
        log.info("Class initialized");
        this.namedJdbcTemplate = namedJdbcTemplate;
        this.dataSource = dataSource;
    }

    @Value("${getChatsByUserId}")
    private String getChatsByUserId;

    @Value("${createNewChat}")
    private String createNewChat;

    @Value("${getChatMembers}")
    private String getChatMembers;

    @Value("${getMessagesByChatId}")
    private String getMessagesByChatId;

    @Value("${setMinRefreshDate}")
    private String setMinRefreshDate;

    @Value("${saveMessage}")
    private String saveMessage;

    @Value("${updateChat}")
    private String updateChat;

    @Override
    public List<Chat> getChatsByUserId(Long userId){
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("user_id", userId);
        return namedJdbcTemplate.query(getChatsByUserId, namedParams, new ChatMapper());
    }
    @Override
    public void createNewChat(String chatName, List<String> members) throws SQLException {
        log.info("Create new chat [{}]", chatName);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("chat_name", chatName);
        namedParams.put("members", dataSource.getConnection().createArrayOf("text", members.toArray()));
        namedJdbcTemplate.queryForObject(createNewChat, namedParams, String.class);
        log.info("Successful create new chat");
    }

    @Override
    public List<User> getChatMembers(Long chatId) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("chat_id", chatId);
        return namedJdbcTemplate.query(getChatMembers,
                namedParams, new FriendMapper());
    }

    @Override
    public List<Message> getMessagesByChatId(Long chatId) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("chat_id", chatId);
        return namedJdbcTemplate.query(getMessagesByChatId, namedParams, new MessageMapper());
    }

    @Override
    public void saveMessage(Message message){
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("chat_id", message.getToId());
        namedParams.put("user_login", message.getFromName());
        namedParams.put("messege", message.getMessage());
        namedParams.put("datetime_send", message.getDateSend());
        namedJdbcTemplate.queryForObject(saveMessage, namedParams, String.class);
    }

    @Override
    public void updateChat(Long chatId, String editedChatName,
                           List<String> addedMembers,
                           List<String> removedMembers,
                           String chatAvatar)
            throws SQLException {
        log.info("Update chat id[{}]", chatId);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("chat_name", editedChatName);
        namedParams.put("avatar_filepath", chatAvatar);
        namedParams.put("chat_id", chatId);
        namedParams.put("addedMembers", dataSource.getConnection()
                .createArrayOf("text", addedMembers.toArray()));
        namedParams.put("removedMembers", dataSource.getConnection()
                .createArrayOf("text", removedMembers.toArray()));
        namedJdbcTemplate.queryForObject(updateChat, namedParams, String.class);
        log.info("Successful update chat");
    }

}
