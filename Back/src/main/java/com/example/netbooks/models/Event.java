package com.example.netbooks.models;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class Event {
    private String title;
    private String date;
    private int id;

    public Event(String title, String date, int id) {
        this.title = title;
        this.date = date;
        this.id = id;
    }


}
