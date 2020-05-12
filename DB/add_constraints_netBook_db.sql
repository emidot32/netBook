alter table person
	add constraint link_on_role FOREIGN KEY (role_id) REFERENCES roles (role_id) ON DELETE NO ACTION ON UPDATE CASCADE;
	
alter table friends
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_friend FOREIGN KEY (friend_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table user_book 
	add constraint link_on_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE;

alter table book_author 
	add constraint link_on_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_author FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table book_genre
	add constraint link_on_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_genre FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table user_token 
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table user_achievement
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_achievement FOREIGN KEY (achv_id) REFERENCES  achievement (achv_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table moderator_permission
	add constraint link_on_permission FOREIGN KEY (permission_id) REFERENCES permsn (permission_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_moderator FOREIGN KEY (moderator_id) REFERENCES  person (person_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table overview
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table review
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_book FOREIGN KEY (book_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table announcement
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE NO ACTION ON UPDATE CASCADE,
	add constraint link_on_announcement_book FOREIGN KEY (announcement_book_id) REFERENCES book (book_id) ON DELETE CASCADE ON UPDATE CASCADE;

alter table notification
	add constraint link_on_person FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE;

alter table chat_member
	add constraint link_on_chat FOREIGN KEY (chat_id) REFERENCES chat (chat_id) ON DELETE CASCADE ON UPDATE CASCADE,
	add constraint link_on_user FOREIGN KEY (user_id) REFERENCES person (person_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
alter table message
	add constraint link_on_member FOREIGN KEY (member_id) REFERENCES chat_member (member_id) ON DELETE CASCADE ON UPDATE CASCADE;
	
	
	
	
	
	
	
	
	

