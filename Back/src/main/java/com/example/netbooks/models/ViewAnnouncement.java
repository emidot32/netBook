package com.example.netbooks.models;


import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ViewAnnouncement {

    private int announcmentId;
    private String releaseDate;
    private String title;
    private String description;
    private String imagePath;
    private String[] authors;
    private String[] genres;

    public int getAnnouncmentId() {
        return announcmentId;
    }
}
