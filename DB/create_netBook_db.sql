create table roles (
	role_id serial primary key,
	role_name varchar(50) NOT NULL
);


create table person (
	person_id serial primary key,
	person_name varchar(50) UNIQUE,
	mail varchar(50) UNIQUE,
	login varchar(60) NOT NULL,
	passw varchar(100) NOT NULL,
	sex char(1),
	reg_date date,
	avatar_filepath varchar(300),
	country varchar (70),
	city varchar(50),
	description text,
	activity boolean DEFAULT TRUE,
	turn_on_notif boolean DEFAULT TRUE,
	role_id serial NOT NULL
);

create table friends (
	user_id serial,
	friend_id serial
);

create table user_token (
	token_id serial primary key,
	token_name varchar(500) UNIQUE,
	user_id serial NOT NULL,
	created_date date,
);

create table book (
	book_id serial primary key,
	title varchar(150) NOT NULL,
	likes integer,
	image_path varchar(300),
	release_date date,
	lang varchar(3),
	pages integer,
	approved boolean
);

create table user_book (
	book_id serial,
	user_id serial,
	read_date date,
	reading boolean,
	favourite boolean DEFAULT FALSE
);

create table author(
	author_id serial primary key,
	firstname varchar(50),
	lastname varchar(70)
);

create table book_author (
	book_id serial,
	author_id serial
);

create table genre (
	genre_id serial primary key,
	genre_name varchar(30) NOT NULL
);

create table book_genre (
	book_id serial,
	genre_id serial
);

create table achievement(
	achv_id serial primary key,
	title varchar(50),
	n_books integer,
	description text,
	image_path varchar(300)
);

create table user_achievement(
	user_id serial,
	achv_id serial
);

create table permsn(
	permission_id serial primary key,
	permission_name varchar(40) NOT NULL
);

create table moderator_permission (
	permission_id serial,
	moderator_id serial
);

create table announcement(
	announcment_id serial primary key,
	announcement_book_id serial,
	user_id serial,
	approved boolean,
	title varchar(100) UNIQUE,
	description text,
	image_path varchar(200)
);

create table overview (
	overview_id serial primary key,
	user_id serial, 
	book_id serial,
	approved boolean,
	photo_path varchar(300),
	short_desc text,
	some_file varchar(300)
);

create table review (
	review_id serial primary key,
	user_id serial, 
	book_id serial,
	approved boolean,
	review_text text,
	rating integer
);

create table notification (
	notification_id serial primary key,
	person_id serial,
	notif_name varchar(50),
	notif_title varchar(50),
	notif_text text,
	notif_date date,
	notif_time time
);
create table chat (
	chat_id serial primary key,
	chat_name varchar(50)
);
create table chat_member (
	member_id serial primary key,
	user_id int,
	chat_id int
);

create table message (
	message_id serial primary key,
	member_id int,
	messege text,
	datetime_send timestamp
);















