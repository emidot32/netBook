--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Ubuntu 11.6-1.pgdg16.04+1)
-- Dumped by pg_dump version 11.4 (Ubuntu 11.4-1.pgdg18.04+1)

-- Started on 2019-11-27 01:46:38 EET


--
-- TOC entry 223 (class 1259 OID 6371172)
-- Name: achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.achievement (
    achv_id integer NOT NULL,
    title character varying(50),
    n_books integer,
    description text,
    image_path character varying(300)
);


--
-- TOC entry 222 (class 1259 OID 6371170)
-- Name: achievement_achv_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.achievement_achv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 222
-- Name: achievement_achv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.achievement_achv_id_seq OWNED BY public.achievement.achv_id;


--
-- TOC entry 235 (class 1259 OID 6371213)
-- Name: announcement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.announcement (
    announcment_id integer NOT NULL,
    announcement_book_id integer NOT NULL,
    user_id integer NOT NULL,
    approved boolean,
    title character varying(100),
    description text,
    image_path character varying(200)
);


--
-- TOC entry 233 (class 1259 OID 6371209)
-- Name: announcement_announcement_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcement_announcement_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 233
-- Name: announcement_announcement_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcement_announcement_book_id_seq OWNED BY public.announcement.announcement_book_id;


--
-- TOC entry 232 (class 1259 OID 6371207)
-- Name: announcement_announcment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcement_announcment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 232
-- Name: announcement_announcment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcement_announcment_id_seq OWNED BY public.announcement.announcment_id;


--
-- TOC entry 234 (class 1259 OID 6371211)
-- Name: announcement_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.announcement_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 234
-- Name: announcement_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.announcement_user_id_seq OWNED BY public.announcement.user_id;


--
-- TOC entry 213 (class 1259 OID 6371138)
-- Name: author; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.author (
    author_id integer NOT NULL,
    fullname character varying(50)
);


--
-- TOC entry 212 (class 1259 OID 6371136)
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 212
-- Name: author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.author_author_id_seq OWNED BY public.author.author_id;


--
-- TOC entry 208 (class 1259 OID 6371120)
-- Name: book; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book (
    book_id integer NOT NULL,
    title character varying(150) NOT NULL,
    likes integer,
    image_path character varying(300),
    release_date date,
    lang character varying(30),
    pages integer,
    approved boolean,
    description text,
    user_id integer
);


--
-- TOC entry 216 (class 1259 OID 6371148)
-- Name: book_author; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_author (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 6371146)
-- Name: book_author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 215
-- Name: book_author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_author_author_id_seq OWNED BY public.book_author.author_id;


--
-- TOC entry 214 (class 1259 OID 6371144)
-- Name: book_author_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_author_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 214
-- Name: book_author_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_author_book_id_seq OWNED BY public.book_author.book_id;


--
-- TOC entry 207 (class 1259 OID 6371118)
-- Name: book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 207
-- Name: book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_book_id_seq OWNED BY public.book.book_id;


--
-- TOC entry 221 (class 1259 OID 6371165)
-- Name: book_genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_genre (
    book_id integer NOT NULL,
    genre_id integer NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 6371161)
-- Name: book_genre_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_genre_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 219
-- Name: book_genre_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_genre_book_id_seq OWNED BY public.book_genre.book_id;


--
-- TOC entry 220 (class 1259 OID 6371163)
-- Name: book_genre_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.book_genre_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 220
-- Name: book_genre_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.book_genre_genre_id_seq OWNED BY public.book_genre.genre_id;


--
-- TOC entry 249 (class 1259 OID 7428783)
-- Name: chat; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chat (
    chat_id integer NOT NULL,
    chat_name character varying(50)
);


--
-- TOC entry 248 (class 1259 OID 7428781)
-- Name: chat_chat_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chat_chat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 248
-- Name: chat_chat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chat_chat_id_seq OWNED BY public.chat.chat_id;


--
-- TOC entry 251 (class 1259 OID 7428791)
-- Name: chat_member; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chat_member (
    member_id integer NOT NULL,
    user_id integer,
    chat_id integer
);


--
-- TOC entry 250 (class 1259 OID 7428789)
-- Name: chat_member_member_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.chat_member_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 250
-- Name: chat_member_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.chat_member_member_id_seq OWNED BY public.chat_member.member_id;


--
-- TOC entry 203 (class 1259 OID 6371097)
-- Name: friends; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.friends (
    user_id integer NOT NULL,
    friend_id integer NOT NULL,
    status boolean
);


--
-- TOC entry 202 (class 1259 OID 6371095)
-- Name: friends_friend_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.friends_friend_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 202
-- Name: friends_friend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.friends_friend_id_seq OWNED BY public.friends.friend_id;


--
-- TOC entry 201 (class 1259 OID 6371093)
-- Name: friends_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.friends_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 201
-- Name: friends_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.friends_user_id_seq OWNED BY public.friends.user_id;


--
-- TOC entry 218 (class 1259 OID 6371155)
-- Name: genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genre (
    genre_id integer NOT NULL,
    genre_name character varying(30) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 6371153)
-- Name: genre_genre_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genre_genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 217
-- Name: genre_genre_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genre_genre_id_seq OWNED BY public.genre.genre_id;


--
-- TOC entry 253 (class 1259 OID 7428799)
-- Name: message; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message (
    message_id integer NOT NULL,
    member_id integer,
    messege text,
    datetime_send timestamp without time zone
);


--
-- TOC entry 252 (class 1259 OID 7428797)
-- Name: message_message_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 252
-- Name: message_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_message_id_seq OWNED BY public.message.message_id;


--
-- TOC entry 231 (class 1259 OID 6371202)
-- Name: moderator_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.moderator_permission (
    permission_id integer NOT NULL,
    moderator_id integer NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 6371200)
-- Name: moderator_permission_moderator_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.moderator_permission_moderator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 230
-- Name: moderator_permission_moderator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.moderator_permission_moderator_id_seq OWNED BY public.moderator_permission.moderator_id;


--
-- TOC entry 229 (class 1259 OID 6371198)
-- Name: moderator_permission_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.moderator_permission_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 229
-- Name: moderator_permission_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.moderator_permission_permission_id_seq OWNED BY public.moderator_permission.permission_id;


--
-- TOC entry 246 (class 1259 OID 6371264)
-- Name: notification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification (
    notification_id integer NOT NULL,
    user_id integer NOT NULL,
    notif_name character varying(50),
    notif_title character varying(50),
    notif_text text,
    notif_date timestamp without time zone,
    is_read boolean NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 6371260)
-- Name: notification_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 244
-- Name: notification_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_notification_id_seq OWNED BY public.notification.notification_id;


--
-- TOC entry 245 (class 1259 OID 6371262)
-- Name: notification_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 245
-- Name: notification_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_person_id_seq OWNED BY public.notification.user_id;


--
-- TOC entry 239 (class 1259 OID 6371232)
-- Name: overview; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.overview (
    overview_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    approved boolean,
    photo_path character varying(300),
    short_desc text,
    some_file character varying(300)
);


--
-- TOC entry 238 (class 1259 OID 6371230)
-- Name: overview_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.overview_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 238
-- Name: overview_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.overview_book_id_seq OWNED BY public.overview.book_id;


--
-- TOC entry 236 (class 1259 OID 6371226)
-- Name: overview_overview_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.overview_overview_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 236
-- Name: overview_overview_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.overview_overview_id_seq OWNED BY public.overview.overview_id;


--
-- TOC entry 237 (class 1259 OID 6371228)
-- Name: overview_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.overview_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 237
-- Name: overview_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.overview_user_id_seq OWNED BY public.overview.user_id;


--
-- TOC entry 228 (class 1259 OID 6371192)
-- Name: permsn; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permsn (
    permission_id integer NOT NULL,
    permission_name character varying(40) NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 6371190)
-- Name: permsn_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permsn_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 227
-- Name: permsn_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permsn_permission_id_seq OWNED BY public.permsn.permission_id;


--
-- TOC entry 200 (class 1259 OID 6371077)
-- Name: person; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.person (
    person_id integer NOT NULL,
    person_name character varying(50),
    mail character varying(50),
    login character varying(60) NOT NULL,
    passw character varying(100) NOT NULL,
    sex character(1),
    reg_date date,
    avatar_filepath character varying(300),
    country character varying(70),
    city character varying(50),
    description text,
    activity boolean DEFAULT true,
    turn_on_notif boolean DEFAULT true,
    role_id integer NOT NULL,
    min_refresh_date timestamp without time zone
);


--
-- TOC entry 198 (class 1259 OID 6371073)
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 198
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_person_id_seq OWNED BY public.person.person_id;


--
-- TOC entry 199 (class 1259 OID 6371075)
-- Name: person_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.person_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 199
-- Name: person_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.person_role_id_seq OWNED BY public.person.role_id;


--
-- TOC entry 243 (class 1259 OID 6371249)
-- Name: review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.review (
    review_id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    approved boolean,
    review_text text,
    rating integer
);


--
-- TOC entry 242 (class 1259 OID 6371247)
-- Name: review_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.review_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 242
-- Name: review_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.review_book_id_seq OWNED BY public.review.book_id;


--
-- TOC entry 240 (class 1259 OID 6371243)
-- Name: review_review_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.review_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 240
-- Name: review_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.review_review_id_seq OWNED BY public.review.review_id;


--
-- TOC entry 241 (class 1259 OID 6371245)
-- Name: review_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.review_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 241
-- Name: review_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.review_user_id_seq OWNED BY public.review.user_id;


--
-- TOC entry 197 (class 1259 OID 6371067)
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


--
-- TOC entry 196 (class 1259 OID 6371065)
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 196
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- TOC entry 226 (class 1259 OID 6371185)
-- Name: user_achievement; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_achievement (
    user_id integer NOT NULL,
    achv_id integer NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 6371183)
-- Name: user_achievement_achv_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_achievement_achv_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_achievement_achv_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_achievement_achv_id_seq OWNED BY public.user_achievement.achv_id;


--
-- TOC entry 224 (class 1259 OID 6371181)
-- Name: user_achievement_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_achievement_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_achievement_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_achievement_user_id_seq OWNED BY public.user_achievement.user_id;


--
-- TOC entry 211 (class 1259 OID 6371130)
-- Name: user_book; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_book (
    book_id integer NOT NULL,
    user_id integer NOT NULL,
    read_date date,
    reading boolean,
    favourite boolean DEFAULT false
);


--
-- TOC entry 209 (class 1259 OID 6371126)
-- Name: user_book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 209
-- Name: user_book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_book_book_id_seq OWNED BY public.user_book.book_id;


--
-- TOC entry 210 (class 1259 OID 6371128)
-- Name: user_book_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_book_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 210
-- Name: user_book_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_book_user_id_seq OWNED BY public.user_book.user_id;


--
-- TOC entry 206 (class 1259 OID 6371106)
-- Name: user_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_token (
    token_id integer NOT NULL,
    token_name character varying(500),
    user_id integer NOT NULL,
    created_date timestamp without time zone
);


--
-- TOC entry 204 (class 1259 OID 6371102)
-- Name: user_token_token_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_token_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_token_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_token_token_id_seq OWNED BY public.user_token.token_id;


--
-- TOC entry 205 (class 1259 OID 6371104)
-- Name: user_token_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_token_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 205
-- Name: user_token_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_token_user_id_seq OWNED BY public.user_token.user_id;


--
-- TOC entry 247 (class 1259 OID 7426329)
-- Name: view_announcement_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.view_announcement_list AS
SELECT
    NULL::integer AS announcment_id,
    NULL::character varying(100) AS title,
    NULL::character varying[] AS authors,
    NULL::character varying(200) AS image_path,
    NULL::text AS description,
    NULL::character varying[] AS genres,
    NULL::boolean AS approved,
    NULL::date AS release_date;


--
-- TOC entry 254 (class 1259 OID 7618711)
-- Name: view_book_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.view_book_list AS
SELECT
    NULL::integer AS book_id,
    NULL::character varying(150) AS title,
    NULL::character varying[] AS authors,
    NULL::integer AS likes,
    NULL::character varying(300) AS image_path,
    NULL::date AS release_date,
    NULL::character varying(30) AS lang,
    NULL::integer AS pages,
    NULL::character varying[] AS genres,
    NULL::text AS description,
    NULL::boolean AS approved;


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 254
-- Name: VIEW view_book_list; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON VIEW public.view_book_list IS 'View for books with authors and genres arrays.';


--
-- TOC entry 3887 (class 2604 OID 6371175)
-- Name: achievement achv_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement ALTER COLUMN achv_id SET DEFAULT nextval('public.achievement_achv_id_seq'::regclass);


--
-- TOC entry 3893 (class 2604 OID 6371216)
-- Name: announcement announcment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement ALTER COLUMN announcment_id SET DEFAULT nextval('public.announcement_announcment_id_seq'::regclass);


--
-- TOC entry 3894 (class 2604 OID 6371217)
-- Name: announcement announcement_book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement ALTER COLUMN announcement_book_id SET DEFAULT nextval('public.announcement_announcement_book_id_seq'::regclass);


--
-- TOC entry 3895 (class 2604 OID 6371218)
-- Name: announcement user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement ALTER COLUMN user_id SET DEFAULT nextval('public.announcement_user_id_seq'::regclass);


--
-- TOC entry 3881 (class 2604 OID 6371141)
-- Name: author author_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.author ALTER COLUMN author_id SET DEFAULT nextval('public.author_author_id_seq'::regclass);


--
-- TOC entry 3877 (class 2604 OID 6371123)
-- Name: book book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book ALTER COLUMN book_id SET DEFAULT nextval('public.book_book_id_seq'::regclass);


--
-- TOC entry 3882 (class 2604 OID 6371151)
-- Name: book_author book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author ALTER COLUMN book_id SET DEFAULT nextval('public.book_author_book_id_seq'::regclass);


--
-- TOC entry 3883 (class 2604 OID 6371152)
-- Name: book_author author_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author ALTER COLUMN author_id SET DEFAULT nextval('public.book_author_author_id_seq'::regclass);


--
-- TOC entry 3885 (class 2604 OID 6371168)
-- Name: book_genre book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_genre ALTER COLUMN book_id SET DEFAULT nextval('public.book_genre_book_id_seq'::regclass);


--
-- TOC entry 3886 (class 2604 OID 6371169)
-- Name: book_genre genre_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_genre ALTER COLUMN genre_id SET DEFAULT nextval('public.book_genre_genre_id_seq'::regclass);


--
-- TOC entry 3904 (class 2604 OID 7428786)
-- Name: chat chat_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat ALTER COLUMN chat_id SET DEFAULT nextval('public.chat_chat_id_seq'::regclass);


--
-- TOC entry 3905 (class 2604 OID 7428794)
-- Name: chat_member member_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_member ALTER COLUMN member_id SET DEFAULT nextval('public.chat_member_member_id_seq'::regclass);


--
-- TOC entry 3873 (class 2604 OID 6371100)
-- Name: friends user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friends ALTER COLUMN user_id SET DEFAULT nextval('public.friends_user_id_seq'::regclass);


--
-- TOC entry 3874 (class 2604 OID 6371101)
-- Name: friends friend_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friends ALTER COLUMN friend_id SET DEFAULT nextval('public.friends_friend_id_seq'::regclass);


--
-- TOC entry 3884 (class 2604 OID 6371158)
-- Name: genre genre_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre ALTER COLUMN genre_id SET DEFAULT nextval('public.genre_genre_id_seq'::regclass);


--
-- TOC entry 3906 (class 2604 OID 7428802)
-- Name: message message_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message ALTER COLUMN message_id SET DEFAULT nextval('public.message_message_id_seq'::regclass);


--
-- TOC entry 3891 (class 2604 OID 6371205)
-- Name: moderator_permission permission_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderator_permission ALTER COLUMN permission_id SET DEFAULT nextval('public.moderator_permission_permission_id_seq'::regclass);


--
-- TOC entry 3892 (class 2604 OID 6371206)
-- Name: moderator_permission moderator_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderator_permission ALTER COLUMN moderator_id SET DEFAULT nextval('public.moderator_permission_moderator_id_seq'::regclass);


--
-- TOC entry 3902 (class 2604 OID 6371267)
-- Name: notification notification_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification ALTER COLUMN notification_id SET DEFAULT nextval('public.notification_notification_id_seq'::regclass);


--
-- TOC entry 3903 (class 2604 OID 6371268)
-- Name: notification user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification ALTER COLUMN user_id SET DEFAULT nextval('public.notification_person_id_seq'::regclass);


--
-- TOC entry 3896 (class 2604 OID 6371235)
-- Name: overview overview_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overview ALTER COLUMN overview_id SET DEFAULT nextval('public.overview_overview_id_seq'::regclass);


--
-- TOC entry 3897 (class 2604 OID 6371236)
-- Name: overview user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overview ALTER COLUMN user_id SET DEFAULT nextval('public.overview_user_id_seq'::regclass);


--
-- TOC entry 3898 (class 2604 OID 6371237)
-- Name: overview book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overview ALTER COLUMN book_id SET DEFAULT nextval('public.overview_book_id_seq'::regclass);


--
-- TOC entry 3890 (class 2604 OID 6371195)
-- Name: permsn permission_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permsn ALTER COLUMN permission_id SET DEFAULT nextval('public.permsn_permission_id_seq'::regclass);


--
-- TOC entry 3869 (class 2604 OID 6371080)
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person ALTER COLUMN person_id SET DEFAULT nextval('public.person_person_id_seq'::regclass);


--
-- TOC entry 3872 (class 2604 OID 6371083)
-- Name: person role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person ALTER COLUMN role_id SET DEFAULT nextval('public.person_role_id_seq'::regclass);


--
-- TOC entry 3899 (class 2604 OID 6371252)
-- Name: review review_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review ALTER COLUMN review_id SET DEFAULT nextval('public.review_review_id_seq'::regclass);


--
-- TOC entry 3900 (class 2604 OID 6371253)
-- Name: review user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review ALTER COLUMN user_id SET DEFAULT nextval('public.review_user_id_seq'::regclass);


--
-- TOC entry 3901 (class 2604 OID 6371254)
-- Name: review book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review ALTER COLUMN book_id SET DEFAULT nextval('public.review_book_id_seq'::regclass);


--
-- TOC entry 3868 (class 2604 OID 6371070)
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- TOC entry 3888 (class 2604 OID 6371188)
-- Name: user_achievement user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement ALTER COLUMN user_id SET DEFAULT nextval('public.user_achievement_user_id_seq'::regclass);


--
-- TOC entry 3889 (class 2604 OID 6371189)
-- Name: user_achievement achv_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement ALTER COLUMN achv_id SET DEFAULT nextval('public.user_achievement_achv_id_seq'::regclass);


--
-- TOC entry 3878 (class 2604 OID 6371133)
-- Name: user_book book_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_book ALTER COLUMN book_id SET DEFAULT nextval('public.user_book_book_id_seq'::regclass);


--
-- TOC entry 3879 (class 2604 OID 6371134)
-- Name: user_book user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_book ALTER COLUMN user_id SET DEFAULT nextval('public.user_book_user_id_seq'::regclass);


--
-- TOC entry 3875 (class 2604 OID 6371109)
-- Name: user_token token_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_token ALTER COLUMN token_id SET DEFAULT nextval('public.user_token_token_id_seq'::regclass);


--
-- TOC entry 3876 (class 2604 OID 6371110)
-- Name: user_token user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_token ALTER COLUMN user_id SET DEFAULT nextval('public.user_token_user_id_seq'::regclass);


--
-- TOC entry 4126 (class 0 OID 6371172)
-- Dependencies: 223
-- Data for Name: achievement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.achievement (achv_id, title, n_books, description, image_path) VALUES (2, 'True book lover!', 100, 'Read 100 books!', 'https://i.pinimg.com/originals/c7/80/5e/c7805ee9aa1a16baaa33a7b1be2f220e.png');
INSERT INTO public.achievement (achv_id, title, n_books, description, image_path) VALUES (1, 'Nice start!', 10, 'Read 10 books!', 'https://static.thenounproject.com/png/81527-200.png');
INSERT INTO public.achievement (achv_id, title, n_books, description, image_path) VALUES (3, 'Guru!', 1000, 'Read 1000 books!', 'https://previews.123rf.com/images/vectorstockcompany/vectorstockcompany1808/vectorstockcompany180812928/106925983-achievement-icon-vector-isolated-on-white-background-for-your-web-and-mobile-app-design-achievement-.jpg');


--
-- TOC entry 4138 (class 0 OID 6371213)
-- Dependencies: 235
-- Data for Name: announcement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (51, 42, 15, true, 'TEstAnnouncement', 'Test1', 'Test1');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (7, 14, 15, true, 'Test7', 'some text 7', 'Ring.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (53, 43, 15, false, 'TestSunday', 'TestTest', 'Test');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (8, 14, 15, true, 'Test8', 'some text 8', 'Ring.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (54, 1051, 15, true, 'TestAnnouncement', 'SomeTestText', 'Test');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (49, 34, 15, true, 'TestWork', 'TestWork some', 'TestWork');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (5, 5, 15, true, 'The Adventures of Sherlock Holmes', 'Story about Holms and his friend Doctor', 'Holms.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (4, 4, 15, true, 'The Lord of the Rings', 'Story about o One Ring to rule them all, One Ring to find them,
One Ring to bring them all and in the darkness bind them', 'Ring.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (3, 3, 15, true, 'The Picture of Dorian Gray', 'Story about Dorian Gray and his picture', 'Dorian.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (2, 2, 15, true, 'The Hound of the Baskervilles', 'Story about detective Sherlock and his friend', 'Holms.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (1, 1, 15, true, 'Harry Potter', 'Story about magic school and Harry Potter', 'Harry.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (14, 14, 15, false, 'Test1', 'some text 1', 'Harry.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (45, 14, 15, false, 'Test5', 'some text 5', 'Ring.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (47, 5, 15, false, 'Test2', 'Some test text2', 'Harry.jpg');
INSERT INTO public.announcement (announcment_id, announcement_book_id, user_id, approved, title, description, image_path) VALUES (50, 35, 15, false, 'TestWORK2', 'TestWORK2TestWORK2TestWORK2', 'TestWORK2');


--
-- TOC entry 4116 (class 0 OID 6371138)
-- Dependencies: 213
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.author (author_id, fullname) VALUES (1, 'Joanne Rowling');
INSERT INTO public.author (author_id, fullname) VALUES (2, 'Arthur Conan Doyle');
INSERT INTO public.author (author_id, fullname) VALUES (3, 'Oscar Wild');
INSERT INTO public.author (author_id, fullname) VALUES (4, 'John Tolkien');
INSERT INTO public.author (author_id, fullname) VALUES (5, 'Illia Ilf');
INSERT INTO public.author (author_id, fullname) VALUES (6, 'Evgeniy Petrov');
INSERT INTO public.author (author_id, fullname) VALUES (17, 'author1');
INSERT INTO public.author (author_id, fullname) VALUES (18, 'author2');
INSERT INTO public.author (author_id, fullname) VALUES (19, 'TestWork');
INSERT INTO public.author (author_id, fullname) VALUES (20, 'TestWORK2');
INSERT INTO public.author (author_id, fullname) VALUES (21, 'Test23');
INSERT INTO public.author (author_id, fullname) VALUES (22, 'TestNow');
INSERT INTO public.author (author_id, fullname) VALUES (23, 'Test1');
INSERT INTO public.author (author_id, fullname) VALUES (24, 'Test2');
INSERT INTO public.author (author_id, fullname) VALUES (25, 'Test3');
INSERT INTO public.author (author_id, fullname) VALUES (26, 'Kisliy');
INSERT INTO public.author (author_id, fullname) VALUES (27, 'Naymenko');
INSERT INTO public.author (author_id, fullname) VALUES (28, 'Yaremenko');
INSERT INTO public.author (author_id, fullname) VALUES (29, 'Tanos');
INSERT INTO public.author (author_id, fullname) VALUES (30, 'Dread');
INSERT INTO public.author (author_id, fullname) VALUES (31, 'Ns');
INSERT INTO public.author (author_id, fullname) VALUES (32, 'savjns');
INSERT INTO public.author (author_id, fullname) VALUES (33, 'TestSunday1');
INSERT INTO public.author (author_id, fullname) VALUES (34, 'TestSunday2');
INSERT INTO public.author (author_id, fullname) VALUES (38, 'cracker');


--
-- TOC entry 4111 (class 0 OID 6371120)
-- Dependencies: 208
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (25, 'Test1', 0, 'Test1', '2019-11-17', 'en', 123, false, 'kek mikek', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (26, 'Test2', 0, 'test2', '2019-11-17', 'ru', 123, false, 'some text', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (27, 'Test3', 0, 'test3', '2019-11-17', 'be', 1234, false, 'It is work!', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (28, 'Title1', 0, 'test', '2019-11-18', 'uk', 12345, false, 'popup', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (29, 'Dub', 0, 'Test1', '2019-11-17', 'be', 1234, false, 'popup', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (30, 'Harry', 0, 'test4', '2019-11-18', 'be', 1234, false, 'git', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (31, 'Harry', 0, 'test4', '2019-11-18', 'be', 1234, false, 'git', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (32, 'Monday', 0, 'image', '2019-11-18', 'ge', 1516, false, 'no coments', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (33, 'Tuesday', 0, '', '2019-11-18', 'ru', 1516, false, NULL, NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (34, 'TestWork', 0, 'TestWork', '2019-11-11', 'en', 220, false, 'TestWork some', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (35, 'TestWORK2', 0, 'TestWORK2', '2019-05-05', 'ru', 150, false, 'TestWORK2TestWORK2TestWORK2', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (36, 'Test23', 0, 'Test23', '2019-09-09', 'ru', 215, false, 'Test23Test23', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (37, 'TestNow', 0, 'TestNow', '1999-05-05', 'en', 123, false, 'TestNowTestNow', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (38, 'Test', 0, 'Test', '2000-05-05', 'ru', 2, false, 'TestTest', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (39, 'Vanya', 0, 'Test', '2005-05-05', 'ru', 200, false, 'TestTest', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (40, 'TestFinal', 0, 'children.jpg', '2019-11-11', 'ru', 1234, false, 'Some text description', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (41, 'Tesvsd', 0, 'sfvsv', '2000-05-05', 'ru', 123, false, 'wsvesrberb', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (42, 'TEstAnnouncement', 0, 'Test1', '2000-05-05', 'ru', 123, false, 'Test1', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (43, 'TestSunday', 0, 'TestSunday', '2019-05-05', 'ru', 123, false, 'TestSunday', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (44, 'qwe', 0, 'qwe', '2019-11-24', 'ru', 12, false, 'rgbfdvsdc', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (1049, 'Priivet ot netcrackera0', 0, 'qwe', '2019-11-24', 'ru', 12, false, 'rgbfdvsdc', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (1050, 'nettest', 0, 'ocherednoyTest', '2019-11-11', 'uk', 1234, false, 'i don''t like this shit', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (1051, 'TestAnnouncement', 0, 'Test', '2019-11-25', 'ru', 123, false, 'SomeTestText', NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (14, 'The twelve chairs', 6, 'twelvechairs.jpeg', '1928-05-09', 'ru', 250, true, NULL, NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (1, 'Harry Potter', 0, 'https://www.rulit.me/data/programs/images/garri-potter-i-filosofskij-kamin_147517.jpg', '1997-10-21', 'en', 213, true, NULL, NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (3, 'The Picture of Dorian Gray', 0, 'https://img.yakaboo.ua/media/catalog/product/cache/1/image/398x565/234c7c011ba026e66d29567e1be1d1f7/2/6/264108_22092077.jpg', '1891-05-21', 'en', 350, true, NULL, NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (4, 'The Lord of the Rings', 0, 'https://images-na.ssl-images-amazon.com/images/I/51EstVXM1UL._SX331_BO1,204,203,200_.jpg', '1955-02-15', 'en', 310, true, NULL, NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (5, 'The Adventures of Sherlock Holmes', 0, 'https://images-na.ssl-images-amazon.com/images/I/51%2Bwcjjs1ML._SX321_BO1,204,203,200_.jpg', '1930-07-02', 'en', 350, true, NULL, NULL);
INSERT INTO public.book (book_id, title, likes, image_path, release_date, lang, pages, approved, description, user_id) VALUES (2, 'The Hound of the Baskervilles', 0, 'https://cdn1.ozone.ru/multimedia/c650/1013202471.jpg', '1902-07-02', 'en', 150, true, NULL, NULL);


--
-- TOC entry 4119 (class 0 OID 6371148)
-- Dependencies: 216
-- Data for Name: book_author; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.book_author (book_id, author_id) VALUES (1, 1);
INSERT INTO public.book_author (book_id, author_id) VALUES (2, 2);
INSERT INTO public.book_author (book_id, author_id) VALUES (3, 3);
INSERT INTO public.book_author (book_id, author_id) VALUES (4, 4);
INSERT INTO public.book_author (book_id, author_id) VALUES (1049, 38);
INSERT INTO public.book_author (book_id, author_id) VALUES (5, 2);
INSERT INTO public.book_author (book_id, author_id) VALUES (14, 5);
INSERT INTO public.book_author (book_id, author_id) VALUES (14, 6);
INSERT INTO public.book_author (book_id, author_id) VALUES (1051, 23);
INSERT INTO public.book_author (book_id, author_id) VALUES (1051, 24);
INSERT INTO public.book_author (book_id, author_id) VALUES (26, 1);
INSERT INTO public.book_author (book_id, author_id) VALUES (27, 17);
INSERT INTO public.book_author (book_id, author_id) VALUES (27, 18);
INSERT INTO public.book_author (book_id, author_id) VALUES (28, 1);
INSERT INTO public.book_author (book_id, author_id) VALUES (29, 1);
INSERT INTO public.book_author (book_id, author_id) VALUES (32, 1);
INSERT INTO public.book_author (book_id, author_id) VALUES (33, 1);
INSERT INTO public.book_author (book_id, author_id) VALUES (33, 6);
INSERT INTO public.book_author (book_id, author_id) VALUES (34, 19);
INSERT INTO public.book_author (book_id, author_id) VALUES (35, 20);
INSERT INTO public.book_author (book_id, author_id) VALUES (35, 20);
INSERT INTO public.book_author (book_id, author_id) VALUES (36, 21);
INSERT INTO public.book_author (book_id, author_id) VALUES (37, 22);
INSERT INTO public.book_author (book_id, author_id) VALUES (39, 26);
INSERT INTO public.book_author (book_id, author_id) VALUES (39, 27);
INSERT INTO public.book_author (book_id, author_id) VALUES (39, 28);
INSERT INTO public.book_author (book_id, author_id) VALUES (40, 29);
INSERT INTO public.book_author (book_id, author_id) VALUES (40, 30);
INSERT INTO public.book_author (book_id, author_id) VALUES (40, 31);
INSERT INTO public.book_author (book_id, author_id) VALUES (41, 32);
INSERT INTO public.book_author (book_id, author_id) VALUES (42, 23);
INSERT INTO public.book_author (book_id, author_id) VALUES (42, 24);
INSERT INTO public.book_author (book_id, author_id) VALUES (42, 25);
INSERT INTO public.book_author (book_id, author_id) VALUES (43, 33);
INSERT INTO public.book_author (book_id, author_id) VALUES (43, 34);


--
-- TOC entry 4124 (class 0 OID 6371165)
-- Dependencies: 221
-- Data for Name: book_genre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.book_genre (book_id, genre_id) VALUES (1, 2);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (1, 3);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (1, 4);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (2, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (3, 3);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (4, 2);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (4, 5);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (5, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (1049, 21);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (5, 4);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (14, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (14, 4);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (1051, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (1051, 2);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (1051, 3);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (26, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (27, 13);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (27, 14);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (27, 15);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (28, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (29, 16);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (32, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (33, 4);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (34, 17);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (35, 18);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (35, 18);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (35, 18);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (36, 19);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (37, 20);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (39, 3);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (39, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (39, 2);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (40, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (40, 2);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (40, 5);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (40, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (41, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (42, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (42, 5);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (42, 6);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (43, 1);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (43, 3);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (43, 5);
INSERT INTO public.book_genre (book_id, genre_id) VALUES (44, 21);


--
-- TOC entry 4151 (class 0 OID 7428783)
-- Dependencies: 249
-- Data for Name: chat; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.chat (chat_id, chat_name) VALUES (2, 'mark - alex');
INSERT INTO public.chat (chat_id, chat_name) VALUES (3, 'testttt');
INSERT INTO public.chat (chat_id, chat_name) VALUES (6, 'bsgsg');
INSERT INTO public.chat (chat_id, chat_name) VALUES (7, 'fdfvd');
INSERT INTO public.chat (chat_id, chat_name) VALUES (4, 'qwe');
INSERT INTO public.chat (chat_id, chat_name) VALUES (5, 'test222');
INSERT INTO public.chat (chat_id, chat_name) VALUES (1, 'mark- rer');
INSERT INTO public.chat (chat_id, chat_name) VALUES (8, 'wwwwwwwww');


--
-- TOC entry 4153 (class 0 OID 7428791)
-- Dependencies: 251
-- Data for Name: chat_member; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (1, 26, 1);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (2, 2, 1);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (3, 2, 2);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (4, 7, 2);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (5, 46, 2);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (6, 2, 4);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (7, 7, 4);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (8, 27, 4);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (9, 46, 4);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (10, 2, 5);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (11, 46, 5);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (12, 2, 6);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (13, 7, 6);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (14, 2, 7);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (15, 7, 7);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (16, 4, 5);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (17, 7, 5);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (18, 2, 8);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (19, 4, 8);
INSERT INTO public.chat_member (member_id, user_id, chat_id) VALUES (20, 46, 8);


--
-- TOC entry 4106 (class 0 OID 6371097)
-- Dependencies: 203
-- Data for Name: friends; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.friends (user_id, friend_id, status) VALUES (2, 46, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (2, 29, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (2, 27, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (2, 4, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (80, 53, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (80, 27, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (80, 50, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (80, 6, NULL);
INSERT INTO public.friends (user_id, friend_id, status) VALUES (26, 4, NULL);


--
-- TOC entry 4121 (class 0 OID 6371155)
-- Dependencies: 218
-- Data for Name: genre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.genre (genre_id, genre_name) VALUES (1, 'Detective');
INSERT INTO public.genre (genre_id, genre_name) VALUES (2, 'Fantasy');
INSERT INTO public.genre (genre_id, genre_name) VALUES (3, 'Drama');
INSERT INTO public.genre (genre_id, genre_name) VALUES (4, 'Adventure');
INSERT INTO public.genre (genre_id, genre_name) VALUES (5, 'Science Fiction');
INSERT INTO public.genre (genre_id, genre_name) VALUES (6, 'Comedy');
INSERT INTO public.genre (genre_id, genre_name) VALUES (7, 'Science');
INSERT INTO public.genre (genre_id, genre_name) VALUES (8, 'Romantic');
INSERT INTO public.genre (genre_id, genre_name) VALUES (13, 'genr1');
INSERT INTO public.genre (genre_id, genre_name) VALUES (14, 'genr2');
INSERT INTO public.genre (genre_id, genre_name) VALUES (15, 'genr3');
INSERT INTO public.genre (genre_id, genre_name) VALUES (16, 'Mistika');
INSERT INTO public.genre (genre_id, genre_name) VALUES (17, 'TestWork');
INSERT INTO public.genre (genre_id, genre_name) VALUES (18, 'TestWORK2');
INSERT INTO public.genre (genre_id, genre_name) VALUES (19, 'Test23');
INSERT INTO public.genre (genre_id, genre_name) VALUES (20, 'TestNow');
INSERT INTO public.genre (genre_id, genre_name) VALUES (21, 'qwe');


--
-- TOC entry 4155 (class 0 OID 7428799)
-- Dependencies: 253
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (1, 1, 'msg from test2 to mark 1', '2019-11-24 11:01:50.633927');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (2, 2, 'msg from mark to test2 2', '2019-11-24 11:04:30.220747');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (3, 3, 'msg from mark to alex 1', '2019-11-24 11:06:41.121218');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (4, 2, 'test1', '2019-11-24 18:58:45.813');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (5, 1, 'dfgsdfg', '2019-11-25 18:11:21.361');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (6, 1, 'dfgsdfgfffffff', '2019-11-25 18:11:24.403');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (7, 2, 'fgfg', '2019-11-25 18:11:34.836');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (8, 12, 'dgfdfg', '2019-11-25 18:16:18.7');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (9, 12, 'fghj', '2019-11-25 18:16:53.755');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (10, 12, 'fghj', '2019-11-25 18:16:55.381');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (11, 12, 'fghj', '2019-11-25 18:16:56.948');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (12, 12, 'fghj', '2019-11-25 18:16:58.557');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (13, 12, 'fghj', '2019-11-25 18:17:00.116');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (14, 12, 'hjlkh', '2019-11-25 18:17:04.612');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (15, 12, 'hjklhjkl', '2019-11-25 18:17:08.436');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (16, 12, 'hjlkhjkl', '2019-11-25 18:17:10.733');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (17, 12, 'hjlkhjkl', '2019-11-25 18:17:13.124');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (18, 1, 'gfhdfghdgh111', '2019-11-26 16:00:53.294');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (19, 2, 'hhhh', '2019-11-26 16:01:19.451');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (20, 1, '111111', '2019-11-26 18:29:29.867');
INSERT INTO public.message (message_id, member_id, messege, datetime_send) VALUES (21, 2, '2222', '2019-11-26 18:29:43.685');


--
-- TOC entry 4134 (class 0 OID 6371202)
-- Dependencies: 231
-- Data for Name: moderator_permission; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (1, 3);
INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (2, 3);
INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (3, 3);
INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (1, 4);
INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (3, 4);
INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (2, 5);
INSERT INTO public.moderator_permission (permission_id, moderator_id) VALUES (3, 6);


--
-- TOC entry 4149 (class 0 OID 6371264)
-- Dependencies: 246
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (4, 2, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-25 00:00:00', false);
INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (5, 121, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-25 00:00:00', false);
INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (6, 53, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-25 00:00:00', false);
INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (7, 27, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-25 00:00:00', false);
INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (8, 50, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-25 00:00:00', false);
INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (9, 6, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-25 00:00:00', false);
INSERT INTO public.notification (notification_id, user_id, notif_name, notif_title, notif_text, notif_date, is_read) VALUES (10, 71, 'addFriend', 'Friend Request', 'check your frinds somebody want to add you', '2019-11-26 00:00:00', false);


--
-- TOC entry 4142 (class 0 OID 6371232)
-- Dependencies: 239
-- Data for Name: overview; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 4131 (class 0 OID 6371192)
-- Dependencies: 228
-- Data for Name: permsn; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.permsn (permission_id, permission_name) VALUES (1, 'announcement');
INSERT INTO public.permsn (permission_id, permission_name) VALUES (2, 'overview');
INSERT INTO public.permsn (permission_id, permission_name) VALUES (3, 'review');
INSERT INTO public.permsn (permission_id, permission_name) VALUES (4, 'book');


--
-- TOC entry 4103 (class 0 OID 6371077)
-- Dependencies: 200
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (8, 'Dima', 'dima@ukr.net', 'dima', '112343', 'M', '2019-11-15', '/usrava4.png', 'Mexico', 'Mexico', 'i am Dima', true, true, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (14, 'a', 'a', 'a', '$2a$10$lytXj6kneM4K5A5VsS3UIenv1a5IaHNca1dFm1FKg8/9Pp6EiM3p2', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (16, 'r', 'r', 'r', '$2a$10$4eVQZTLgIa03CpilXFnBLuT0hdP8ZfOu3wbGVlNTNEuByKmZgg4Iu', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (17, 't', 't', 't', '$2a$10$aeFM2jhWeG7gAPcgnFvjF.JY2nQtqjflqOUdQxp/ebyFqpkc81Vk2', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (18, 'aw', 'aw', 'aw', '$2a$10$JU7O3yx.h4SsMmkqNbTySe4OEp1x0ewzRWoPTcHW6OlVN/RfD4l4G', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (19, 'y', 'y', 'y', '$2a$10$3DM3Sg3y8/VDKSiLHC6ugun.j3dDJniP3h0w3RcK46ecCTq/TNV8m', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (20, 'f', 'f', 'f', '$2a$10$L/Cy8ZLAkdZzhU82fkS68.kgr262KsIQbQxHvY3Ct67hoY/RmLi6y', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (21, 'u', 'u', 'u', '$2a$10$91NGWuF/rRnD5sZkWaqDne8ZAx.2cFifvGs5JLuPCA1Z4qL2cFlli', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (22, 'er', 'er', 'er', '$2a$10$dN7mISjdyWaoCKbL20IBtO.0xC0IhAXN9Uic79l3QxlT6hN0aPwcO', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (25, 'testadmin', 'testadmin', 'testadmin', '$2a$10$AwrXsrPoE79bpbsgu1fqNuYyljUhkHjnLErfUtkaaLr3zAxG.tHhG', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (214, 'prodAdmin', 'prodAdmin', 'prodAdmin', '$2a$10$bU61HJIOrgGd8U0Qcpa/uuc/1qIxqosj.nza0TlHP.zFjF545w8.O', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, '2019-11-26 14:18:41.995');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (15, 'w', 'w', 'w', '$2a$10$ChIGwfo6ujzXLSCu1FPcKuTGz/A6BgH.eUkhW1sH4x1mcjJlm0Wgm', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 4, '2019-11-12 00:00:00');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (2, 'Mark White', 'mark@mail', 'mark', '$2a$10$4fsMkxc2omHQFMlxmRjc8ekm//7gpIoyjksGdo5GdH0idvevcV5qq', 'M', '2012-04-12', 'f0edea27-1757-4490-a342-43be6e28d0fe', 'Україна', 'test2', 'Марк машина, а у машини немає статуса', true, false, 4, '2019-11-19 00:00:00');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (28, 'test241', 'test241@mail', 'test241', '$2a$10$y1legMq4vLe1DwAiBeofKeeGKXdi8CIFDwoW3yg949WufRVBxxxui', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (26, 'test2', 'test2@maila', 'test2', '$2a$10$XSX8vMFj3Dt7jLSyUJ0hCueIr9rG7YiyiPVSU2FEpemY7aVPO1NgW', 'M', NULL, '24e8910a-e611-4ff8-ae93-27edd72ae500', 'USA', 'test2', 'qweq', true, false, 4, '2019-11-12 00:00:00');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (1, 'emidot32', 'emidot32@gmail.com', 'emidot32', '$2a$10$3uDpdYmwAklZWxX4adsk3.MkIri2Fs1FLbIV/wwPyfc2HgVF.D726', 'M', '2019-11-01', NULL, NULL, NULL, NULL, true, true, 1, '2019-11-14 00:26:12.829');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (29, 'Рандомний штріх', 'wfwev@svsve@gmail.com', 'wfwev@svsve', '$2a$10$E0FZGrbf4J.tOeXvHeafSuqb0ttD60Wv1SRjCm8w7bSjCJtOMw//G', 'M', '2047-04-12', 'https://media.glamour.com/photos/58336fd44e6d66172e161a3a/master/w_1600%2Cc_limit/0117-GL-LIFE01-02.jpg', 'Україна', 'Київ', 'Блаблаблаблабла', true, true, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (216, '2bb2a940-5d39-4d7e-ae5a-345c286ff008', '2bb2a940-5d39-4d7e-ae5a-345c286ff008', '2bb2a940-5d39-4d7e-ae5a-345c286ff008', '2bb2a940-5d39-4d7e-ae5a-345c286ff008', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (5, 'Max_moder', 'max@gmail.com', 'max', '$2a$10$x7WuO4b.sfd5eSqv7/55Gu9nPgHDYOOkRN6AzQmmMDcdJunRxDaHC', 'M', '2019-11-03', NULL, NULL, NULL, NULL, true, true, 3, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (6, 'Vitaliy_moder', 'screamking@gmail.com', 'screamking', '$2a$10$7lrJV81egpn2p/PrTMbJkO1OYXIu7Y3jkfMBXDC7TfbAMv1vFxNJ.', 'M', '2019-11-03', NULL, NULL, NULL, NULL, true, true, 3, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (71, 'AccountAdmin', 'testMail', 'AccountAdmin', '$2a$10$xm2VjT9Tub8T4wLxGUEHbO4.XrVEDSPv8jtRTWK/gdLZ3MrKetQya', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (3, 'Frank_moder', 'frank@gmail.com', 'frank', '$2a$10$G6zGVq1zpu9cVV87p7AiN.foU63VTO7JB.9zSIE/Zm8tLH8O9hkXq', 'M', '2019-11-03', NULL, NULL, NULL, NULL, true, true, 3, '2019-11-25 23:39:00.56');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (47, 'sdvae@wwgvsv', 'sdvae@wwgvsv', 'sdvae@wwgvsv', '$2a$10$NCIUd8MpW9REUQV8Ps3hyupHe7sbvcwvDbDE.SSUDyyYWdJKNtF6m', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (48, 'First@Name', 'First@Name', 'First@Name', '$2a$10$639YRZEEX.iVEfariWzsT.QvJcq0f9wANUGZJSyHUGMHVG4wWsemu', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (49, 'TEST@tewrt', 'TEST@tewrt', 'TEST@tewrt', '$2a$10$4NQOHkzPwRDETLyx6SFR8O2Lg0pDQ9Of8v.xaCwl/cMx8BV5l7q/O', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (50, 'Snisarenko', 'sashaffg@gmail.com', 'Alexandr', '$2a$10$QtlQkvpfYO1NTjmeTx/QA.tNa65xiUIlAe7TYm4tllju4PWdenzR.', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (51, 'sdfgdsfd', NULL, 'sdfg', '$2a$10$Rtg8arAgQFZm9BTk2GkXu.37foZJ1pweaSXNq6cW17tNWDd/vksdm', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (53, 'AdminSasha', NULL, 'SashaAdmin', '$2a$10$gj8z9.6TKTjuWePtWZ7sHe2uTjBIQXpboLHPBJLJ43GqRCZW7mLMu', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (55, 'AdminAccount', NULL, 'AdminAccount', '$2a$10$aH.6Sa9WwRqHUf/tnn5M0uy0mLKV6AO3uIhw2Z/aIQeliPsXPasjq', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (4, 'Marta_moder', 'marta@gmail.com', 'marta', '$2a$10$q2ZNbIkiAfFd27Fgfq/pZ.TNHFls0zMtZ0A8IfUuxevFoqvD2srpy', 'W', '2019-11-03', NULL, NULL, NULL, NULL, true, true, 3, '2019-11-19 00:26:26.668');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (43, 'qwerty1', NULL, 'qwerty1', '$2a$10$IaIoQM81oPdh6XfXu9nZ4eJnsjOAp7jidMrt471iFb0rnOPxwChH6', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (111, 'TestAdmin', NULL, 'TestAdmin', '$2a$10$JMSW/dAFAip/BsMfouPkz.MjHPi8HTleZHOUDlPgqhWrroYpVOCRG', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (112, 'LastTest', 'LastTest', 'LastTest', '$2a$10$5wdoSK7TB3ewouCdDbVWXu8pGt1odRDf4LMOYEFxiBAttzE5OI9wO', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (73, 'AccountAdmin1', 'AccountAdmin1', 'AccountAdmin1', '$2a$10$NOA6z77zjRy/tOeBBgXZ6eqpIgCHri0xCPMzUB8gmepKPvMJxd0ki', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, '2019-11-15 22:17:48.577');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (74, '', '', '', '$2a$10$b8YcctxNCzXJZ8r.DnrSrOd2jgbZ40dun1jZO2B/8ptdxZ8a8t.u.', NULL, NULL, NULL, NULL, NULL, NULL, false, false, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (7, 'Alex Snow', 'alex@gmail.com', 'alex', '$2a$10$E0FZGrbf4J.tOeXvHeafSuqb0ttD60Wv1SRjCm8w7bSjCJtOMw//G', 'M', '2016-11-01', 'https://i.ytimg.com/vi/x_HL0wiK4Zc/maxresdefault.jpg', 'Україна', 'Київ', 'курлик курлик))', true, true, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (80, 'frontAdmin', 'frontAdmin', 'frontAdmin', '$2a$10$6bOmgUeYQXzZEpnUNBUPzeTmiIZIslV33lredxWRFkDlkCXSd4HvC', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, '2019-11-17 01:09:56.855');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (27, 'Чак Норріс', 'finka@gmail.com', 'finka', '$2a$10$E0FZGrbf4J.tOeXvHeafSuqb0ttD60Wv1SRjCm8w7bSjCJtOMw//G', 'M', '2011-03-12', 'https://i.ytimg.com/vi/LdGzyW3gP74/maxresdefault.jpg', 'Америка', 'NY', 'Однажды меня укусила гремучая змея. После двух дней адских мук и боли змея сдохла', true, true, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (46, 'Коляска', 'reniko@gmail.com', 'reniko', '$2a$10$x.74tjh.ORzt9NqJ9uccY.LSzCrRK8fJ1R3ojmc8qcnDIKu4P5fGS', 'M', '2054-04-12', 'https://s14.stc.all.kpcdn.net/share/i/12/10725808/inx960x640.jpg', 'Україна', 'Київ', 'Коля, Колян, Колясік, Коливан', true, true, 4, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (121, 'reqTest', 'reqTest', 'reqTest', '$2a$10$9UHQsJKUx9Yju.SWo8QIbOYC.XedvDtTFpjaotrSMfJBEAj.ct7Ge', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (119, 'RoleTest', 'RoleTest', 'RoleTest', '$2a$10$cmiT3UkmGxksFrDPAIVRjuWdww3S2qBLl3jkPY1xAAtH1COe4Ms0G', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (123, '2', '3', '1', '$2a$10$bkd6B0NH3MqIrjeYqTBrYu5jZkJsxi1Ns5to4DQaXdVuTYwJe0PZW', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (128, 'ModeratorTest', 'ModeratorTest', 'ModeratorTest', '$2a$10$PL4u968qnwFNYAHjd5qrbuhSowhoGGDfp9sU/x8FE7WxzP3aCsV.e', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 3, '2019-11-20 20:49:00.227');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (126, 'finalAdmin', 'finalAdmin', 'finalAdmin', '$2a$10$L47rNV6xHPwtMkGysSysGeUJhu5bso6Mxk.zWOpJpBWfItpaSAhN6', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (189, 'Albert', 'jivihad866@4xmail.net', 'James', '$2a$10$7.JGgzNNN3T2wLdwVRweee61qM3HAxKLzRARY9gCYmgx7o9l1fShm', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 4, '2019-11-24 13:43:59.064');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (127, 'finalAdmin1', 'finalAdmin1', 'finalAdmin1', '$2a$10$TnVusL8OfWTVunE/QVMMEOcrIf4zQcKex/oL0um95dsS7jtJ108tm', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, NULL);
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (213, 'prodModer', 'prodModer', 'prodModer', '$2a$10$sJEEAYIedK7f9xMRUsJD7.3H1ZadUUiWPqlPSnT.Eh5FOAc7s10q2', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 3, '2019-11-26 14:16:43.894');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (215, 'Grumpy Cat', 'mohamad.ulices@niickel.us', 'Qwer', '$2a$10$sbWpFQhBBDcBtEuPN6v6TeCi0Lyw4XPILseCp0xGbPF.ctL67oyKq', NULL, NULL, '90c831e5-f4bd-43cc-8304-3d23af1ab142', NULL, NULL, '', true, false, 4, '2019-11-26 00:00:00');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (217, 'admin111', 'admin111', 'admin111', '$2a$10$ZJnUO5RnViqBAFxkvoVwU.0ZdBF5uKoSh5wP8C1Dvh4Sc4ZTR0UWG', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 2, '2019-11-26 18:43:42.809');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (193, 'kravchuk', 'dimitrykrava@gmail.com', 'dmitriy', '$2a$10$DnlAxiMs8IMTviM.ZLDZwOYdgscEWeW5FjU4eXUAb8WWB2SSRZFg2', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 4, '2019-11-24 17:52:27.901');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (198, 'kofena', 'kofena3686@xmail2.net', 'kofena', '$2a$10$6rjuYbV4numMsi3aKQWMoeRxWoWXT4Zx6kG2LxDCWOGV3uz1IzGXq', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 4, '2019-11-25 12:11:57.771');
INSERT INTO public.person (person_id, person_name, mail, login, passw, sex, reg_date, avatar_filepath, country, city, description, activity, turn_on_notif, role_id, min_refresh_date) VALUES (206, 'WorkingModer', 'WorkingModer', 'WorkingModer', '$2a$10$mjBpa70MupDFmU1bAjbeFO9sQ7bUWTkNpGKVpV08/cjO03f6SKDSS', NULL, NULL, NULL, NULL, NULL, NULL, true, false, 3, '2019-11-26 02:13:35.073');


--
-- TOC entry 4146 (class 0 OID 6371249)
-- Dependencies: 243
-- Data for Name: review; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (1, 7, 1, true, 'Perfect book. Recommend to everyone.', 5);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (2, 7, 2, true, 'Excellent!', 4);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (3, 7, 3, true, 'Fantastic!', 3);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (4, 7, 4, true, 'Ammazing book!', 4);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (5, 2, 3, true, 'I expected more.', 3);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (6, 2, 4, true, 'So well.', 4);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (7, 4, 2, true, 'Very nice!', 5);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (8, 4, 2, true, 'Not bad I guess.', 4);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (9, 27, 4, true, 'I am exciting', 5);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (10, 49, 4, true, 'I am exciting!!', 5);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (11, 8, 4, true, 'Amazing!', 5);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (12, 3, 4, true, 'Not bad', 4);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (13, 1, 4, true, 'Cool!', 5);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (44, 1, 4, false, 'egrfv', 0);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (45, 1, 4, false, 'egrfvsf', 0);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (46, 1, 4, false, 'ghfgn', 0);
INSERT INTO public.review (review_id, user_id, book_id, approved, review_text, rating) VALUES (47, 26, 4, false, 'wefnghfgeghger', 0);


--
-- TOC entry 4100 (class 0 OID 6371067)
-- Dependencies: 197
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.roles (role_id, role_name) VALUES (1, 'SuperAdmin');
INSERT INTO public.roles (role_id, role_name) VALUES (2, 'Admin');
INSERT INTO public.roles (role_id, role_name) VALUES (3, 'Moderator');
INSERT INTO public.roles (role_id, role_name) VALUES (4, 'User');


--
-- TOC entry 4129 (class 0 OID 6371185)
-- Dependencies: 226
-- Data for Name: user_achievement; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_achievement (user_id, achv_id) VALUES (8, 1);
INSERT INTO public.user_achievement (user_id, achv_id) VALUES (2, 2);
INSERT INTO public.user_achievement (user_id, achv_id) VALUES (46, 1);
INSERT INTO public.user_achievement (user_id, achv_id) VALUES (29, 1);
INSERT INTO public.user_achievement (user_id, achv_id) VALUES (27, 1);
INSERT INTO public.user_achievement (user_id, achv_id) VALUES (7, 1);


--
-- TOC entry 4114 (class 0 OID 6371130)
-- Dependencies: 211
-- Data for Name: user_book; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (2, 4, '2019-11-29', false, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (4, 5, '2019-11-30', false, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (3, 4, NULL, true, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (1, 6, NULL, true, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (2, 1, NULL, true, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (2, 7, NULL, true, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (1, 7, '2019-08-10', false, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (3, 7, '2019-07-11', false, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (4, 7, '2019-09-12', false, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (4, 27, '2019-09-08', false, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (4, 49, '2019-09-09', false, false);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (4, 8, '2019-09-10', false, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (4, 2, '2019-11-17', true, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (1, 26, '2019-07-07', false, true);
INSERT INTO public.user_book (book_id, user_id, read_date, reading, favourite) VALUES (1, 2, NULL, true, true);


--
-- TOC entry 4109 (class 0 OID 6371106)
-- Dependencies: 206
-- Data for Name: user_token; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (4, 'ae58cab5-a5b6-4a83-ad45-015259779825', 14, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (6, 'd73b3c5f-8ee8-456c-9dcc-5c3630f8de63', 16, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (7, '7c2e5ced-9aba-45d0-891a-147410bb4df5', 17, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (9, '381843dd-2c31-4194-a8d6-62c54cae88a1', 19, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (10, '0bc008e0-63ad-448d-8706-ad2d45a94058', 20, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (11, '67fefe7d-ff1f-4352-b2f9-63dfa2742ac5', 21, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (12, '3aad4e78-0b08-4284-9d0b-bea3e3799bf9', 22, '2019-11-10 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (19, '33c669c2-92ea-4078-9e3a-e3e12de5ded5', 27, '2019-11-12 00:00:00');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (21, '1ab88835-762b-4d89-b037-6937a3732252', 28, '2019-11-13 21:35:14.382');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (22, 'bf3f8c54-3106-4b1d-8d85-88968a935dff', 29, '2019-11-14 01:32:20.017');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (23, 'c230ecbd-ece5-467c-bdae-05777cc0c01c', 14, '2019-11-14 15:52:41.627');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (24, '4ceabf79-ae28-471b-8398-b40d04b11de3', 1, '2019-11-14 15:53:39.294');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (253, '9b4f8ec0-d44b-4872-ab28-ff14fbc0567a', 216, '2019-11-26 20:39:01.87');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (46, '8faf868c-194d-4e69-b8fc-54a3bacab676', 43, '2019-11-14 21:53:37.622');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (50, 'be11345c-7cd4-4db8-9c15-a050b3a9741a', 46, '2019-11-14 22:24:44.47');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (51, 'd5c3d1b3-6c09-4785-9dc4-2d14f322e363', 47, '2019-11-15 11:53:03.108');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (52, '8ac04c38-a570-48ae-833d-09fd16103446', 48, '2019-11-15 13:41:14.889');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (53, 'a94ba875-7434-4bcf-bfa8-0854167379d2', 49, '2019-11-15 16:32:35.521');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (54, '4bed15c1-9bea-41a7-8be6-26dfead572a9', 50, '2019-11-15 16:32:38.849');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (55, 'f8d03a56-bd96-4a54-8d7a-feff54c00704', 51, '2019-11-15 16:49:18.26');
INSERT INTO public.user_token (token_id, token_name, user_id, created_date) VALUES (72, 'fe31aae5-bb6e-499a-b73e-b18534c0e28a', 74, '2019-11-15 21:01:50.899');


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 222
-- Name: achievement_achv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.achievement_achv_id_seq', 3, true);


--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 233
-- Name: announcement_announcement_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcement_announcement_book_id_seq', 45, true);


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 232
-- Name: announcement_announcment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcement_announcment_id_seq', 54, true);


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 234
-- Name: announcement_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.announcement_user_id_seq', 1, true);


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 212
-- Name: author_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.author_author_id_seq', 38, true);


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 215
-- Name: book_author_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_author_author_id_seq', 1, false);


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 214
-- Name: book_author_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_author_book_id_seq', 1, false);


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 207
-- Name: book_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_book_id_seq', 1051, true);


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 219
-- Name: book_genre_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_genre_book_id_seq', 1, false);


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 220
-- Name: book_genre_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_genre_genre_id_seq', 1, false);


--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 248
-- Name: chat_chat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chat_chat_id_seq', 8, true);


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 250
-- Name: chat_member_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.chat_member_member_id_seq', 20, true);


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 202
-- Name: friends_friend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.friends_friend_id_seq', 1, false);


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 201
-- Name: friends_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.friends_user_id_seq', 1, false);


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 217
-- Name: genre_genre_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genre_genre_id_seq', 21, true);


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 252
-- Name: message_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.message_message_id_seq', 21, true);


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 230
-- Name: moderator_permission_moderator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.moderator_permission_moderator_id_seq', 1, false);


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 229
-- Name: moderator_permission_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.moderator_permission_permission_id_seq', 1, false);


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 244
-- Name: notification_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notification_notification_id_seq', 10, true);


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 245
-- Name: notification_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notification_person_id_seq', 1, false);


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 238
-- Name: overview_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.overview_book_id_seq', 1, false);


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 236
-- Name: overview_overview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.overview_overview_id_seq', 1, false);


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 237
-- Name: overview_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.overview_user_id_seq', 1, false);


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 227
-- Name: permsn_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.permsn_permission_id_seq', 4, true);


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 198
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_person_id_seq', 217, true);


--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 199
-- Name: person_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.person_role_id_seq', 1, false);


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 242
-- Name: review_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.review_book_id_seq', 1, false);


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 240
-- Name: review_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.review_review_id_seq', 47, true);


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 241
-- Name: review_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.review_user_id_seq', 1, false);


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 196
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 4, true);


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 225
-- Name: user_achievement_achv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_achievement_achv_id_seq', 1, false);


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 224
-- Name: user_achievement_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_achievement_user_id_seq', 1, false);


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 209
-- Name: user_book_book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_book_book_id_seq', 1, false);


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 210
-- Name: user_book_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_book_user_id_seq', 1, false);


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_token_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_token_token_id_seq', 254, true);


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 205
-- Name: user_token_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_token_user_id_seq', 1, false);


--
-- TOC entry 3932 (class 2606 OID 6371180)
-- Name: achievement achievement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.achievement
    ADD CONSTRAINT achievement_pkey PRIMARY KEY (achv_id);


--
-- TOC entry 3936 (class 2606 OID 6371223)
-- Name: announcement announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_pkey PRIMARY KEY (announcment_id);


--
-- TOC entry 3938 (class 2606 OID 6371225)
-- Name: announcement announcement_title_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT announcement_title_key UNIQUE (title);


--
-- TOC entry 3924 (class 2606 OID 6371143)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 3922 (class 2606 OID 6371125)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (book_id);


--
-- TOC entry 3948 (class 2606 OID 7428796)
-- Name: chat_member chat_member_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_member
    ADD CONSTRAINT chat_member_pkey PRIMARY KEY (member_id);


--
-- TOC entry 3946 (class 2606 OID 7428788)
-- Name: chat chat_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (chat_id);


--
-- TOC entry 3916 (class 2606 OID 7618703)
-- Name: friends friends_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT friends_pkey PRIMARY KEY (user_id, friend_id);


--
-- TOC entry 3928 (class 2606 OID 6371160)
-- Name: genre genre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT genre_pkey PRIMARY KEY (genre_id);


--
-- TOC entry 3950 (class 2606 OID 7428807)
-- Name: message message_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT message_pkey PRIMARY KEY (message_id);


--
-- TOC entry 3944 (class 2606 OID 6371273)
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (notification_id);


--
-- TOC entry 3940 (class 2606 OID 6371242)
-- Name: overview overview_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overview
    ADD CONSTRAINT overview_pkey PRIMARY KEY (overview_id);


--
-- TOC entry 3934 (class 2606 OID 6371197)
-- Name: permsn permsn_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permsn
    ADD CONSTRAINT permsn_pkey PRIMARY KEY (permission_id);


--
-- TOC entry 3910 (class 2606 OID 6371092)
-- Name: person person_mail_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_mail_key UNIQUE (mail);


--
-- TOC entry 3912 (class 2606 OID 6371090)
-- Name: person person_person_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_person_name_key UNIQUE (person_name);


--
-- TOC entry 3914 (class 2606 OID 6371088)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- TOC entry 3942 (class 2606 OID 6371259)
-- Name: review review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT review_pkey PRIMARY KEY (review_id);


--
-- TOC entry 3908 (class 2606 OID 6371072)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- TOC entry 3926 (class 2606 OID 6835214)
-- Name: author unique_author_fullname; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT unique_author_fullname UNIQUE (fullname);


--
-- TOC entry 3930 (class 2606 OID 6835216)
-- Name: genre unique_genre_name; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genre
    ADD CONSTRAINT unique_genre_name UNIQUE (genre_name);


--
-- TOC entry 3918 (class 2606 OID 6371115)
-- Name: user_token user_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_token
    ADD CONSTRAINT user_token_pkey PRIMARY KEY (token_id);


--
-- TOC entry 3920 (class 2606 OID 6371117)
-- Name: user_token user_token_token_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_token
    ADD CONSTRAINT user_token_token_name_key UNIQUE (token_name);


--
-- TOC entry 4097 (class 2618 OID 7426332)
-- Name: view_announcement_list _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.view_announcement_list WITH (security_barrier='false') AS
 SELECT announcement.announcment_id,
    announcement.title,
    ARRAY( SELECT DISTINCT unnest(array_agg(aut.fullname)) AS unnest) AS authors,
    announcement.image_path,
    announcement.description,
    ARRAY( SELECT DISTINCT unnest(array_agg(gr.genre_name)) AS unnest) AS genres,
    announcement.approved,
    book.release_date
   FROM (((((public.announcement
     JOIN public.book ON ((announcement.announcement_book_id = book.book_id)))
     JOIN public.book_genre bg ON ((book.book_id = bg.book_id)))
     JOIN public.genre gr ON ((bg.genre_id = gr.genre_id)))
     JOIN public.book_author ba ON ((book.book_id = ba.book_id)))
     JOIN public.author aut ON ((ba.author_id = aut.author_id)))
  WHERE (announcement.approved = false)
  GROUP BY announcement.announcment_id, book.release_date;


--
-- TOC entry 4098 (class 2618 OID 7618714)
-- Name: view_book_list _RETURN; Type: RULE; Schema: public; Owner: -
--

CREATE OR REPLACE VIEW public.view_book_list AS
 SELECT book.book_id,
    book.title,
    ARRAY( SELECT DISTINCT unnest(array_agg(aut.fullname)) AS unnest) AS authors,
    book.likes,
    book.image_path,
    book.release_date,
    book.lang,
    book.pages,
    ARRAY( SELECT DISTINCT unnest(array_agg(gen.genre_name)) AS unnest) AS genres,
    book.description,
    book.approved
   FROM ((((public.book
     JOIN public.book_author USING (book_id))
     JOIN public.author aut USING (author_id))
     JOIN public.book_genre USING (book_id))
     JOIN public.genre gen USING (genre_id))
  WHERE (book.approved = true)
  GROUP BY book.book_id;


--
-- TOC entry 3963 (class 2606 OID 6371329)
-- Name: user_achievement link_on_achievement; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement
    ADD CONSTRAINT link_on_achievement FOREIGN KEY (achv_id) REFERENCES public.achievement(achv_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3967 (class 2606 OID 6371369)
-- Name: announcement link_on_announcement_book; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT link_on_announcement_book FOREIGN KEY (announcement_book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3959 (class 2606 OID 6371304)
-- Name: book_author link_on_author; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT link_on_author FOREIGN KEY (author_id) REFERENCES public.author(author_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3956 (class 2606 OID 6371289)
-- Name: user_book link_on_book; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_book
    ADD CONSTRAINT link_on_book FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3958 (class 2606 OID 6371299)
-- Name: book_author link_on_book; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT link_on_book FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3960 (class 2606 OID 6371309)
-- Name: book_genre link_on_book; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_genre
    ADD CONSTRAINT link_on_book FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3969 (class 2606 OID 6371349)
-- Name: overview link_on_book; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overview
    ADD CONSTRAINT link_on_book FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3971 (class 2606 OID 6371359)
-- Name: review link_on_book; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT link_on_book FOREIGN KEY (book_id) REFERENCES public.book(book_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3973 (class 2606 OID 7428864)
-- Name: chat_member link_on_chat; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_member
    ADD CONSTRAINT link_on_chat FOREIGN KEY (chat_id) REFERENCES public.chat(chat_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3953 (class 2606 OID 6371284)
-- Name: friends link_on_friend; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT link_on_friend FOREIGN KEY (friend_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3961 (class 2606 OID 6371314)
-- Name: book_genre link_on_genre; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_genre
    ADD CONSTRAINT link_on_genre FOREIGN KEY (genre_id) REFERENCES public.genre(genre_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3975 (class 2606 OID 7428874)
-- Name: message link_on_member; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT link_on_member FOREIGN KEY (member_id) REFERENCES public.chat_member(member_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3965 (class 2606 OID 6371339)
-- Name: moderator_permission link_on_moderator; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderator_permission
    ADD CONSTRAINT link_on_moderator FOREIGN KEY (moderator_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3964 (class 2606 OID 6371334)
-- Name: moderator_permission link_on_permission; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderator_permission
    ADD CONSTRAINT link_on_permission FOREIGN KEY (permission_id) REFERENCES public.permsn(permission_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3972 (class 2606 OID 6371374)
-- Name: notification link_on_person; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT link_on_person FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3951 (class 2606 OID 6371274)
-- Name: person link_on_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT link_on_role FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON UPDATE CASCADE;


--
-- TOC entry 3952 (class 2606 OID 6371279)
-- Name: friends link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friends
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3957 (class 2606 OID 6371294)
-- Name: user_book link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_book
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3954 (class 2606 OID 6371319)
-- Name: user_token link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_token
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3962 (class 2606 OID 6371324)
-- Name: user_achievement link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_achievement
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3968 (class 2606 OID 6371344)
-- Name: overview link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overview
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3970 (class 2606 OID 6371354)
-- Name: review link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.review
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3966 (class 2606 OID 6371364)
-- Name: announcement link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.announcement
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE;


--
-- TOC entry 3974 (class 2606 OID 7428869)
-- Name: chat_member link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_member
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3955 (class 2606 OID 7618677)
-- Name: book link_on_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT link_on_user FOREIGN KEY (user_id) REFERENCES public.person(person_id) ON UPDATE CASCADE;


-- Completed on 2019-11-27 01:47:30 EET

--
-- PostgreSQL database dump complete
--

