package com.example.netbooks.dao.mappers;

import com.example.netbooks.models.Notification;
import com.example.netbooks.models.Review;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import java.sql.ResultSet;
import java.sql.SQLException;

@Component
public class NotificationMapper implements RowMapper {
    @Override
    public Object mapRow(ResultSet resultSet, int i) throws SQLException {
        return new Notification(resultSet.getInt("user_id"),
                resultSet.getDate("notif_date"),
                resultSet.getBoolean("is_read"),
                resultSet.getInt("from_user_id"),
                resultSet.getInt("notif_type_id"),
                resultSet.getInt("overview_id"),
                resultSet.getInt("review_id"),
                resultSet.getInt("book_id"),
                resultSet.getInt("achiev_id")
        );


    }
}

//int userId, Date date, boolean isRead, int fromUserId, int notiTypeId,
//                        int overviewId, int reviewId, int bookId, int achievId)
/* resultSet.getString("notif_text"),
                resultSet.getString("notif_title"),
                resultSet.getString("notif_name"),*/