package com.example.netbooks.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class UserAchievement {
    private Long userId;
    private Long  achvId;
    private String title;
    private String description;
    private String imagePath;
}
