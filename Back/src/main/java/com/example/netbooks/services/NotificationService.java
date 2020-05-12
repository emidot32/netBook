package com.example.netbooks.services;

import com.example.netbooks.dao.interfaces.NotificationRepository;
import com.example.netbooks.models.Notification;
import com.example.netbooks.models.User;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Data
@Service
@Slf4j
public class NotificationService {

    @Autowired
    NotificationRepository notificationRepository;
    @Autowired
    UserManager userManager;

    public List<Notification> getAllNotificationsByUserId(long userId) {
        return notificationRepository.getAllNotificationsByUserId(userId);
    }


    public List<Notification> getAllViewNotificationsByUserId(long userId,int cntNotifsForView,int offset) {
        List<Notification> notifList = notificationRepository.getAllViewNotificationsByUserId(userId,cntNotifsForView,offset);
        String userName = userManager.getUserById(userId).getName();
        for (Notification notif : notifList) {
            notifList.set(notifList.indexOf(notif), parseViewNotif(notif, userName));
        }
        log.info("Get all  notifications for user by id {}", userId);
        return notifList;
    }

    public List<Notification> getAllUnreadViewNotificationsByUserId(long userId,int cntNotifsForView,int offset) {
        List<Notification> notifList = notificationRepository.getAllUnreadViewNotificationsByUserId(userId,cntNotifsForView,offset);
        String userName = userManager.getUserById(userId).getName();
        for (Notification notif : notifList) {
            notifList.set(notifList.indexOf(notif), parseViewNotif(notif, userName));
        }
        log.info("Get all unread notifications for user by id {}", userId);
        return notifList;
    }

    @Async
    public void createAndSaveReviewNotif(long fromUserId, List<User> friends, long bookId, long reviewId) {
        for (User user : friends) {
            Notification notification = new Notification();
            notification.setNotifTypeId(4);
            notification.setUserId((int) userManager.getUserIdByName(user.getLogin()));
            notification.setFromUserId((int) fromUserId);
            notification.setBookId((int) bookId);
            notification.setReviewId((int) reviewId);
            addNotification(notification);
        }
    }

    @Async
    public void createAndSaveAchievNotif(long fromUserId, long achvId) {
        User tmpUser = userManager.getUserById(fromUserId);
        List<User> friends = userManager.getFriendsByUsername(tmpUser.getLogin());
        List<User> subscribers = userManager.getSubscribersByLogin(tmpUser.getLogin());
        friends.addAll(subscribers);
        friends.add(tmpUser);
        for (User user : friends) {
            Notification notification = new Notification();
            notification.setNotifTypeId(3);
            notification.setUserId((int) userManager.getUserIdByName(user.getLogin()));
            notification.setFromUserId((int) fromUserId);
            notification.setAchievId((int) achvId);
            addNotification(notification);
        }
    }

    public Notification parseViewNotif(Notification notif) {
        String notifText = notif.getNotifText();
        notifText = notifText.replaceAll("user_name", notif.getFromUserName());
        notifText = notifText.replaceAll("book_name", notif.getBookName());
        notifText = notifText.replaceAll("achiev_name", notif.getAchievName());
        notif.setNotifText(notifText);
        return notif;
    }

    public Notification parseViewNotif(Notification notif, String userName) {
        String notifText = notif.getNotifText();
        if (notif.getFromUserName().equals(userName)) {
            notifText = notifText.replaceAll("User user_name", "You");
        } else {
            notifText = notifText.replaceAll("user_name", notif.getFromUserName());
        }
        notifText = notifText.replaceAll("book_name", notif.getBookName());
        notifText = notifText.replaceAll("achiev_name", notif.getAchievName());
        notif.setNotifText(notifText);

        return notif;
    }

    @Async
    public void addNotification(Notification notification) {

        java.util.Date now = new java.util.Date();
        notification.setDate(new Date(now.getTime()));
        notificationRepository.addNotification(notification);
        log.info("Add notification for user with id {}", notification.getUserId());
    }

    @Async
    public void createAndSaveAddBookNotif(long fromUserId, long bookId) {
        User tmpUser = userManager.getUserById(fromUserId);
        List<User> friends = userManager.getFriendsByUsername(tmpUser.getLogin());
        List<User> subscribers = userManager.getSubscribersByLogin(tmpUser.getLogin());
        friends.addAll(subscribers);
        for (User user : friends) {
            Notification notification = new Notification();
            notification.setNotifTypeId(2);
            notification.setUserId((int) userManager.getUserIdByName(user.getLogin()));
            notification.setFromUserId((int) (tmpUser.getUserId()));
            notification.setBookId((int) bookId);
            addNotification(notification);
        }
    }

    public void markAllAsRead(long id) {
        notificationRepository.markAllAsRead(id);
        log.info("Mark all notifications as read where usere id {}",id);
    }

    public void markNotifAsReadByNotifId(Notification notification) {
        Integer id = notification.getNotificationId();
        notificationRepository.markNotifAsReadByNotifId(id);
        log.info("Mark notification as read by notif id {}", notification.getNotificationId());
    }

    public int getNotifCount(long userId) {
        //log.info("get count of unread notifications for user with id {}",userId);
        return notificationRepository.getNotifCount(userId);
    }

    public void deleteAllNotificationsByUserId(long id) {
        notificationRepository.deleteAllNotificationsByUserId(id);
        log.info("Delete all notifications for user with id {}", id);
    }

}
