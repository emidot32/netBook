package com.example.netbooks.models;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Data
@Getter
@Setter
public class Message {
    @JsonProperty("message")
    private String message;
    @JsonProperty("dateTimeSend")
    private LocalDateTime dateSend;
    @JsonProperty("fromName")
    private String fromName;
    @JsonProperty("toId")
    private Long toId;

}
