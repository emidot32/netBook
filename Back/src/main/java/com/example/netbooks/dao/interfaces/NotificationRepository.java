package com.example.netbooks.dao.interfaces;

import com.example.netbooks.models.Notification;

import java.util.List;
import java.util.Optional;

public interface NotificationRepository {

    List<Notification> getAllNotificationsByUserId(long userId);

    List<Notification> getAllViewNotificationsByUserId(long userId,int cntNotifsForView,int offset);

    List<Notification> getAllUnreadViewNotificationsByUserId(long userId ,int cntNotifForView,int offset);

    void addNotification(Notification notification);

    void markAllAsRead(long id);

    void markNotifAsReadByNotifId(Integer notifId);

    void deleteAllNotificationsByUserId(long id);

    int getNotifCount(long userId);

}
