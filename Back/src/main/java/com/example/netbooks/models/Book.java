package com.example.netbooks.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


import java.util.List;

@Data
public class Book {
    private long bookId;
    private String title;
    private List<String> authors;
    private List<String> genres;
    private int like;
    private String imagePath;
    private String release_date;
    private String language;
    private int pages;
    private String description;
    private boolean approved;
    private String user;


    public String getUser() {
        return user;
    }

    public long getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public List<String> getAuthor() {
        return authors;
    }

    public List<String> getGenre() {
        return genres;
    }

    public int getLike() {
        return like;
    }

    public String getImagePath() {
        return imagePath;
    }

    public String getRelease_date() {
        return release_date;
    }

    public String getLanguage() {
        return language;
    }

    public int getPages() {
        return pages;
    }

    public String getDescription() {
        return description;
    }

    public boolean isApproved() {
        return approved;
    }

    //public Book() {}

    public Book() {}

    public Book(long bookId, String title, List<String> authors, List<String> genre, int like,
                String imagePath, String release_date, String language, int pages, String description,
                boolean approved, String user) {
        this.bookId = bookId;
        this.title = title;
        this.authors = authors;
        this.genres = genre;
        this.like = like;
        this.imagePath = imagePath;
        this.release_date = release_date;
        this.language = language;
        this.pages = pages;
        this.description = description;
        this.approved = approved;
        this.user = user;
    }

    public Book(long bookId, String title, String imagePath, String release_date, String description) {
        this.bookId = bookId;
        this.title = title;
        this.imagePath = imagePath;
        this.release_date = release_date;
        this.description = description;
    }

    public Book(long bookId) {
        this.bookId = bookId;
    }
}
