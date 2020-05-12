package com.example.netbooks.controllers;

import com.example.netbooks.models.Notification;
import com.example.netbooks.services.NotificationService;
import com.example.netbooks.services.UserManager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@RequestMapping("/notifications")
@Slf4j
public class NotificationController {



    @Autowired
    private NotificationService notificationService;
    @Autowired
    private UserManager userManager;

    @GetMapping("/all")
    public List<Notification> getNotificationsForUser(@RequestParam("cnt")int cnt, @RequestParam("offset")int offset) {
        long id = userManager.getUserIdByName(((UserDetails) SecurityContextHolder
                .getContext().getAuthentication()
                .getPrincipal()).getUsername());
        log.info("Getting all notifications for user with id {}", id);
        return notificationService.getAllViewNotificationsByUserId(id, cnt, offset);
    }

    @GetMapping("/unread-only")
    public List<Notification> getAllUnreadViewNotificationsByUserId(@RequestParam("cnt")int cnt, @RequestParam("offset")int offset) {
        long id = userManager.getUserIdByName(((UserDetails) SecurityContextHolder
                .getContext().getAuthentication()
                .getPrincipal()).getUsername());
        log.info("Getting unread notifications for user with id {}", id);
        return notificationService.getAllUnreadViewNotificationsByUserId(id, cnt, offset);
    }

    @GetMapping("/count")
    public ResponseEntity<?> getNotifCount() {

        long id = userManager.getUserIdByName(((UserDetails) SecurityContextHolder
                .getContext().getAuthentication()
                .getPrincipal()).getUsername());
        //log.info("Get count of unread notifications for user with id {}",id);
        return ResponseEntity.ok(notificationService.getNotifCount(id));
    }

    @PutMapping("/mark")
    public void markAllAsRead(){
        long userId = userManager.getUserIdByName(((UserDetails) SecurityContextHolder
                .getContext().getAuthentication()
                .getPrincipal()).getUsername());
        log.info("Mark all notification as read for user with id {} ",userId);
        notificationService.markAllAsRead(userId);
    }

    @PutMapping("mark-one")
    public void markNotifAsReadByNotifId(@RequestBody Notification notification){
        log.info("UPDATE/mark one with notif id {}", notification.getNotificationId());
        notificationService.markNotifAsReadByNotifId(notification);
    }

    @DeleteMapping("/delete-all")
    public void deleteAllNotificationsByUserId(){
        long userId = userManager.getUserIdByName(((UserDetails) SecurityContextHolder
                .getContext().getAuthentication()
                .getPrincipal()).getUsername());
        log.info("delete-all by userId {}",userId );
        notificationService.deleteAllNotificationsByUserId(userId);
    }

}
