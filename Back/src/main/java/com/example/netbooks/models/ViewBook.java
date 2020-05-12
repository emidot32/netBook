package com.example.netbooks.models;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.Date;
import java.util.List;

@Data
@Getter
@Setter
public class ViewBook {
    @JsonProperty("bookId")
    private long bookId;
    @JsonProperty("title")
    private String title;
    @JsonProperty("authors")
    private String[] authors;
    private long likes;
    @JsonProperty("imagePath")
    private String imagePath;
    private Date releaseDate;
    private String lang;
    private int pages;
    private String[] genres;
    private String description;
    public ViewBook(long bookId, String title,
                    String[] authors, long likes,
                    String imagePath, Date releaseDate,
                    String lang, int pages,
                    String[] genres, String description) {
        this.bookId = bookId;
        this.title = title;
        this.authors = authors;
        this.likes = likes;
        this.imagePath = imagePath;
        this.releaseDate = releaseDate;
        this.lang = lang;
        this.pages = pages;
        this.genres = genres;
        this.description = description;
    }

    @JsonProperty("favourite")
    private Boolean favourite;
    @JsonProperty("reading")
    private Boolean reading;
    @JsonProperty("read")
    private Boolean read;
    public ViewBook() {}
}
