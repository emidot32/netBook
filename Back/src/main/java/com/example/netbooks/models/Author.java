package com.example.netbooks.models;

import lombok.Data;

@Data
public class Author {
    private long authorId;
    private String fullName;


    public Author() {}

    public Author(String fullName) {
        this.fullName = fullName;
    }

    public Author(long authorId, String fullName) {
        this.authorId = authorId;
        this.fullName = fullName;
    }

    public String getFullName() {
        return fullName;
    }
}
