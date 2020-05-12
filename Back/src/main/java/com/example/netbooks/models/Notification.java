package com.example.netbooks.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class Notification {

    @JsonProperty("notificationId")
    private Integer notificationId;
    @JsonProperty("userId")
    private Integer userId;
    @JsonProperty("notifDate")
    private Date date;
    @JsonProperty("isRead")
    private boolean isRead;
    private Integer fromUserId;
    @JsonProperty("notifTypeId")
    private Integer notifTypeId;
    private Integer overviewId;
    private Integer reviewId;
    @JsonProperty("bookId")
    private Integer bookId;
    private Integer achievId;
    private String overviewName;
    private String reviewName;
    private String fromUserName;
    private String bookName;
    private String achievName;
    @JsonProperty("notifTitle")
    private String notifTitle;
    @JsonProperty("notifText")
    private String notifText;


    public Notification() {}

    public Notification(Integer userId, Date date, boolean isRead, Integer fromUserId, Integer notifTypeId,
                        Integer overviewId, Integer reviewId, Integer bookId, Integer achievId) {
        this.userId = userId;
        this.date = date;
        this.isRead = isRead;
        this.fromUserId = fromUserId;
        this.notifTypeId = notifTypeId;
        this.overviewId = overviewId;
        this.reviewId = reviewId;
        this.bookId = bookId;
        this.achievId = achievId;
        this.overviewName = null;
        this.reviewName = null;
        this.bookName = null;
        this.achievName = null;
    }

    public Notification(int notificationId, int bookId, boolean isRead,Date date,int notifTypeId, String overviewName,String reviewName,String fromUserName,String bookName,String achievName,String notifTitle,String notifText) {
        this.notificationId=notificationId;
        this.bookId=bookId;
        this.isRead=isRead;
        this.date = date;
        this.notifTypeId = notifTypeId;
        this.overviewName = overviewName;
        this.reviewName = reviewName;
        this.bookName = bookName;
        this.achievName = achievName;
        this.fromUserName=fromUserName;
        this.notifTitle=notifTitle;
        this.notifText=notifText;

    }

    
    
    
    public boolean getIsRead() {
        return isRead;
    }
}
