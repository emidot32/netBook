package com.example.netbooks.models;



public class Announcement {
    private int announcment_id;
    private int announcement_book_id;
    private int user_id;
    private boolean approved;
    private String title;
    private String description;
    private String image_path;

    public Announcement(int announcment_id, int announcement_book_id, int user_id, boolean approved, String title, String description, String image_path) {
        this.announcment_id = announcment_id;
        this.announcement_book_id = announcement_book_id;
        this.user_id = user_id;
        this.approved = approved;
        this.title = title;
        this.description = description;
        this.image_path = image_path;
    }


    public int getAnnouncment_id() {return announcment_id;}

    public int getAnnouncement_book_id() {return announcement_book_id;}

    public int getUser_id() {return user_id;}

    public boolean isApproved() {return approved;}

    public String getTitle() {return title;}

    public String getDescription() {return description;}

    public String getImage_path() {return image_path;}

}
