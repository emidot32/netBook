package com.example.netbooks.models;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Map;

import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.base.Strings;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.example.netbooks.dao.implementations.UserRepository;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;


@Data
@NoArgsConstructor
public class User {
	@JsonProperty("id")
	private long userId;
	@JsonProperty("firstName")
	@JSONField(name="firstName")
	private String name;
	@JsonProperty("username")
	@JSONField(name="username")
	private String login;
	@JsonProperty("email")
	private String email;
	@JsonProperty("password")
    private String password;
	@JsonProperty("sex")
	private String sex;
	@JsonProperty("regDate")
	@JSONField(name="regDate", deserialize=false)
	private LocalDate regDate;
	@JsonProperty("avatarFilePath")
    private String avatarFilePath;
	@JsonProperty("country")
    private String country;
	@JsonProperty("city")
    private String city;
	@JsonProperty("status")
    private String status;
    private boolean activity;
    private boolean turnOnNotif;
	@JsonProperty("role")
	private Role role;
    private Date minRefreshDate;

	public void setRoleInt(int roleId) {
		this.role = Role.values()[roleId - 1];
	}

	public void compareAndReplace(User user) {
		this.name = user.name;
		this.email = user.email;
		this.password = (Strings.isNullOrEmpty(user.getPassword()))
				? this.password : user.password;
		this.sex = user.sex;
		this.country = user.country;
		this.city = user.city;
		this.status = user.status;
	}

}

