package com.example.netbooks.models;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class Achievement {
    private Long  achievementId;
    @JsonProperty("title")
    private String title;
    @JsonProperty("description")
    private String description;
    @JsonProperty("amount")
    private int amount;
    @JsonProperty("image_path")
    private String imagePath;
    private String achvType;
    private Long achvRuleId;
    private String authorName;
    private String genreName;
    private boolean favourite;
    private boolean readBook;
}
