insert into roles values (1, 'SuperAdmin');
insert into roles values (2, 'Admin');
insert into roles values (3, 'Moderator');
insert into roles values (4, 'User');

INSERT INTO person VALUES (1, 'emidot32', 'emidot32@gmail.com', 'emidot32', 'parolAdminaIlluhi', 'M', '2019-11-01', NULL, NULL, NULL, NULL, TRUE, TRUE, 1);
INSERT INTO person VALUES (2, 'Mark_admin', 'mark@gmail.com', 'mark', '12345', 'M', '2019-11-01', NULL, NULL, NULL, NULL, TRUE, TRUE, 2);
INSERT INTO person VALUES (3, 'Frank_moder', 'frank@gmail.com', 'frank', '21345', 'M', '2019-11-03', NULL, NULL, NULL, NULL, TRUE, TRUE, 3);
INSERT INTO person VALUES (4, 'Marta_moder', 'marta@gmail.com', 'marta', '21346', 'W', '2019-11-03', NULL, NULL, NULL, NULL, TRUE, TRUE, 3);
INSERT INTO person VALUES (5, 'Max_moder', 'max@gmail.com', 'max', '21347', 'M', '2019-11-03', NULL, NULL, NULL, NULL, TRUE, TRUE, 3);
INSERT INTO person VALUES (6, 'Vitaliy_moder', 'screamking@gmail.com', 'screamking', '21349', 'M', '2019-11-03', NULL, NULL, NULL, NULL, TRUE, TRUE, 3);
INSERT INTO person VALUES (7, 'Alex', 'alex@gmail.com', 'alex', '32453', 'M', '2019-11-11', '/usrava3.png', 'China', 'Beijing', 'i am Alex', TRUE, TRUE, 4);
INSERT INTO person VALUES (8, 'Dima', 'dima@ukr.net', 'dima', '112343', 'M', '2019-11-15', '/usrava4.png', 'Mexico', 'Mexico', 'i am Dima', TRUE, TRUE, 4);

INSERT INTO permsn VALUES (1, 'announcement');
INSERT INTO permsn VALUES (2, 'overview');
INSERT INTO permsn VALUES (3, 'review');
INSERT INTO permsn VALUES (4, 'book');

INSERT INTO moderator_permission VALUES (1, 3);
INSERT INTO moderator_permission VALUES (2, 3);
INSERT INTO moderator_permission VALUES (3, 3);
INSERT INTO moderator_permission VALUES (1, 4);
INSERT INTO moderator_permission VALUES (3, 4);
INSERT INTO moderator_permission VALUES (2, 5);
INSERT INTO moderator_permission VALUES (3, 6);

INSERT INTO achievement VALUES (1, 'Nice start!', 10, 'Read 10 books!',  '/achiv1.jpeg');
INSERT INTO achievement VALUES (2, 'True book lover!', 100, 'Read 100 books!', '/achiv2.jpeg');
INSERT INTO achievement VALUES (3, 'Guru!', 1000, 'Read 1000 books!', '/achiv3.jpeg');

INSERT INTO user_achievement VALUES (7, 1);
INSERT INTO user_achievement VALUES (7, 2);
INSERT INTO user_achievement VALUES (8, 1);

INSERT INTO author VALUES (1, 'Joanne', 'Rowling');
INSERT INTO author VALUES (2, 'Arthur', 'Conan Doyle');
INSERT INTO author VALUES (3, 'Oscar', 'Wild');
INSERT INTO author VALUES (4, 'John', 'Tolkien');

INSERT INTO genre VALUES (1, 'Detective');
INSERT INTO genre VALUES (2, 'Fantasy');
INSERT INTO genre VALUES (3, 'Drama');
INSERT INTO genre VALUES (4, 'Adventure');
INSERT INTO genre VALUES (5, 'Science Fiction');

INSERT INTO book VALUES (1, 'Harry Potter', 0, '/potter.jpeg', '1997-10-21', 'en', 213, true);
INSERT INTO book VALUES (2, 'The Hound of the Baskervilles', 0, '/holms.jpeg', '1902-07-02', 'en', 150, true);
INSERT INTO book VALUES (5, 'The Adventures of Sherlock Holmes', 0, '/advholms.jpeg', '1930-07-02', 'en', 350, true);
INSERT INTO book VALUES (3, 'The Picture of Dorian Gray', 0, '/doriangray.jpeg', '1891-05-21', 'en', 350, true);
INSERT INTO book VALUES (4, 'The Lord of the Rings', 0, '/lordofrings.jpeg', '1955-02-15', 'en', 310, true);

INSERT INTO book_author VALUES (1, 1);
INSERT INTO book_author VALUES (2, 2);
INSERT INTO book_author VALUES (3, 3);
INSERT INTO book_author VALUES (4, 4);
INSERT INTO book_author VALUES (5, 2);

INSERT INTO book_genre VALUES (1, 2);
INSERT INTO book_genre VALUES (1, 3);
INSERT INTO book_genre VALUES (1, 4);
INSERT INTO book_genre VALUES (2, 1);
INSERT INTO book_genre VALUES (3, 3);
INSERT INTO book_genre VALUES (4, 2);
INSERT INTO book_genre VALUES (4, 5);

INSERT INTO user_book VALUES (1, 2, '2019-11-21', true, false);
INSERT INTO user_book VALUES (3, 2, '2019-11-26', false, false);
INSERT INTO user_book VALUES (3, 4, '2019-11-27', true, false);
INSERT INTO user_book VALUES (2, 4, '2019-11-29', false, true);
INSERT INTO user_book VALUES (4, 5, '2019-11-30', false, false);
INSERT INTO user_book VALUES (1, 6, '2019-11-28', true, false);
INSERT INTO user_book VALUES (2, 1, '2019-12-01', true, true);
INSERT INTO user_book VALUES (2, 7, '2019-12-03', true, false);
