create or replace function like_review(reviewId int, userId int) returns int
    language plpgsql as $$
declare present integer;
    declare result int;
    declare likedOrDisliked boolean;
begin
    select count(*) into present from liked_review where review_id = reviewId and user_id = userId;
    select liked into likedOrDisliked from liked_review where review_id = reviewId and user_id = userId;
    if present = 0 then
        update review set rating = rating+1 where review_id = reviewId;
        insert into liked_review (review_id, user_id, liked) values (reviewId, userId, true);
    ELSIF likedOrDisliked = false then
        update review set rating = rating+2 where review_id = reviewId;
        update liked_review set liked = true where review_id = reviewId and user_id = userId;
    ELSIF likedOrDisliked = true then
        update review set rating = rating-1 where review_id = reviewId;
        delete from liked_review where review_id = reviewId and user_id = userId;
    end if;
    select rating into result from review where review_id = reviewId;
    return result;
end;
$$;

create or replace function dislike_review(reviewId int, userId int) returns int
    language plpgsql as $$
declare present integer;
    declare likedOrDisliked boolean;
    declare result int;
begin
    select count(*) into present from liked_review where review_id = reviewId and user_id = userId;
    select liked into likedOrDisliked from liked_review where review_id = reviewId and user_id = userId;
    if present = 0 then
        update review set rating = rating-1 where review_id = reviewId;
        insert into liked_review (review_id, user_id, liked) values (reviewId, userId, false);
    ELSIF likedOrDisliked = true then
        update review set rating = rating-2 where review_id = reviewId;
        update liked_review set liked = false where review_id = reviewId and user_id = userId;
    ELSIF likedOrDisliked = false then
        update review set rating = rating+1 where review_id = reviewId;
        delete from liked_review where review_id = reviewId and user_id = userId;
    end if;
    select rating into result from review where review_id = reviewId;
    return result;
end;
$$;

create or replace function like_book(bookId int, userId int) returns boolean
    language plpgsql as $$
declare present integer;
    declare likedOrDisliked boolean;
begin
    select count(*) into present from liked_book where book_id = bookId and user_id = userId;
    select liked into likedOrDisliked from liked_book where book_id = bookId and user_id = userId;
    if present = 0 then
        update book set likes = likes+1 where book_id = bookId;
        insert into liked_book (book_id, user_id, liked) values (bookId, userId, true);
    ELSIF likedOrDisliked = false then
        update book set likes = likes+2 where book_id = bookId;
        update liked_book set liked = true where book_id = bookId and user_id = userId;
    ELSIF likedOrDisliked = true then
        update book set likes = likes-1 where book_id = bookId;
        delete from liked_book where book_id = bookId and user_id = userId;
    end if;
    return true;
end;
$$;

create or replace function dislike_book(bookId int, userId int) returns boolean
    language plpgsql as $$
declare present integer;
    declare likedOrDisliked boolean;
begin
    select count(*) into present from liked_book where book_id = bookId and user_id = userId;
    select liked into likedOrDisliked from liked_book where book_id = bookId and user_id = userId;
    if present = 0 then
        update book set likes = likes-1 where book_id = bookId;
        insert into liked_book (book_id, user_id, liked) values (bookId, userId, false);
    ELSIF likedOrDisliked = true then
        update book set likes = likes-2 where book_id = bookId;
        update liked_book set liked = false where book_id = bookId and user_id = userId;
    ELSIF likedOrDisliked = false then
        update book set likes = likes+1 where book_id = bookId;
        delete from liked_book where book_id = bookId and user_id = userId;
    end if;
    return false;
end;
$$;

create function check_review_liked(reviewId int, userId int) returns int
    language plpgsql as $$
    declare likedOrDisliked boolean;
begin
    select liked into likedOrDisliked from liked_review where review_id = reviewId and user_id = userId;
    if likedOrDisliked is null then
        return 0;
    ELSIF likedOrDisliked = false then
        return -1;
    ELSIF likedOrDisliked = true then
        return 1;
    end if;
end;
$$;

create function check_book_liked(bookId int, userId int) returns int
    language plpgsql as $$
    declare likedOrDisliked boolean;
begin
    select liked into likedOrDisliked from liked_book where book_id = bookId and user_id = userId;
    if likedOrDisliked is null then
        return 0;
    ELSIF likedOrDisliked = false then
        return -1;
    ELSIF likedOrDisliked = true then
        return 1;
    end if;
end;
$$;

create or replace function add_achievement(achvTitle varchar, amount int,
achvDescription text, imagePath varchar, authorName varchar,
genreName varchar, favouriteBook boolean, readBook boolean) returns boolean
    language plpgsql as $$
    declare achvRuleId integer;
    declare present boolean;
begin
    select exists(select * from achievement where title = achvTitle or description = achvDescription) into present;
    if not present then
        select insert_rule(authorName, genreName, favouriteBook, readBook) into achvRuleId;
        insert into achievement (title, n, description, image_path, achv_type, achv_rule_id)
        values (achvTitle, amount, achvDescription, imagePath, 'other', achvRuleId);
        return true;
    ELSE return false;
    end if;
end;
$$;


create function insert_rule(authorName varchar,
                            genreName varchar, favouriteBook boolean, readBook boolean) returns int
    language plpgsql as $$
    declare result int;
    begin
        insert into achievement_rule (author_name, genre_name, favourite, read_book) values
            (authorName, genreName, favouriteBook, readBook);
        select achv_rule_id into result from achievement_rule order by achv_rule_id desc limit 1;
        return result;
    end;
    $$;


create or replace function check_achievement_author(bookId int, userId int, favOrRead varchar) returns boolean
    language plpgsql as
$$
    declare achiv record;
    declare bookAuthors varchar[];
    declare countFav    int;
    declare countRead   int;
    declare present     boolean;
begin
    select authors into bookAuthors from view_book_list where book_id = bookId;
    for achiv in select * from view_achievement_rules where author_name is not null
        loop
            if achiv.author_name = any (bookAuthors) then
                if favOrRead = 'fav' then
                    select count(*) into countFav from user_book
                        inner join view_book_list using (book_id)
                        where achiv.author_name = any (bookAuthors) and favourite = true and user_id = userId;
                    if achiv.favourite is not null and achiv.favourite is true then
                        if countFav >= achiv.n then
                            select exists(select * from user_achievement
                              where achv_id = achiv.achv_id and user_id = userId) into present;
                            if not present then
                                insert into user_achievement values (userId, achiv.achv_id);
                                return true;
                            end if;
                        end if;
                    end if;
                end if;
                elseif favOrRead = 'read' then
                    select count(*) into countRead from user_book
                        inner join view_book_list using (book_id)
                        where achiv.author_name = any (bookAuthors) and read_date is not null and user_id = userId;
                    if achiv.read_book is not null and achiv.read_book is true then
                        if countRead >= achiv.n then
                            select exists(select * from user_achievement
                              where achv_id = achiv.achv_id and user_id = userId) into present;
                            if not present then
                                insert into user_achievement values (userId, achiv.achv_id);
                                return true;
                            end if;
                        end if;
                    end if;
            end if;
        end loop;
    return false;
end;
$$;

create or replace function check_achievement_genre(bookId int, userId int, favOrRead varchar) returns boolean
    language plpgsql as
$$
    declare achiv  record;
    declare bookGenres varchar[];
    declare countFav   int;
    declare countRead  int;
    declare present    boolean;
begin
    select genres into bookGenres from view_book_list where book_id = bookId;
    for achiv in select * from view_achievement_rules where genre_name is not null
        loop
            if achiv.genre_name = any (bookGenres) then
                if favOrRead = 'fav' then
                    select count(*) into countFav from user_book
                        inner join view_book_list using (book_id)
                    where achiv.genre_name = any (bookGenres) and favourite = true and user_id = userId;
                    if achiv.favourite is not null and achiv.favourite is true then
                        if countFav >= achiv.n then
                            select exists(select *
                                          from user_achievement
                                          where achv_id = achiv.achv_id
                                            and user_id = userId)
                            into present;
                            if not present then
                                insert into user_achievement values (userId, achiv.achv_id);
                                return true;
                            end if;
                        end if;
                    end if;
                end if;
                elseif favOrRead = 'read' then
                    select count(*) into countRead from user_book inner join view_book_list using (book_id)
                    where achiv.genre_name = any (bookGenres) and read_date is not null and user_id = userId;
                    if achiv.read_book is not null and achiv.read_book is true then
                        if countRead >= achiv.n then
                            select exists(select * from user_achievement
                                where achv_id = achiv.achv_id and user_id = userId) into present;
                            if not present then
                                insert into user_achievement values (userId, achiv.achv_id);
                                return true;
                            end if;
                        end if;
                    end if;
            end if;
        end loop;
    return false;
end;
$$;

create or replace function check_review_achievement(userId int) returns view_user_achievements
    language plpgsql as
$$
    declare result view_user_achievements;
    declare countReviews int;
    declare  present boolean;
    declare achvId int;
begin
    select count(*) into countReviews from review where user_id = userId and approved = true;
    select achv_id into achvId from achievement where achv_type = 'review' and n = countReviews;
    select exists(select * from user_achievement where user_id = userId and achv_id = achvId) into present;
    if not present then
        insert into user_achievement(user_id, achv_id ) values (userId, achvId);
        select user_id, achv_id, title, description, image_path into result
        from user_achievement inner join achievement using(achv_id) where user_id = userId and achv_id = achvId;
        return result;
    else
        return result;
    end if;

end;
$$;

create or replace function check_friend_achievement(userId int) returns view_user_achievements
    language plpgsql as
$$
    declare result view_user_achievements;
    declare countFriends int;
    declare  present boolean;
    declare achvId int;
begin
    select count(*) into countFriends from friends where user_id = userId;
    select achv_id into achvId from achievement where achv_type = 'friends' and n = countFriends;
    select exists(select * from user_achievement where user_id = userId and achv_id = achvId) into present;
    if not present then
        insert into user_achievement(user_id, achv_id ) values (userId, achvId);
        select user_id, achv_id, title, description, image_path into result
        from user_achievement inner join achievement using(achv_id) where user_id = userId and achv_id = achvId;
        return result;
    else
        return result;
    end if;

end;
$$;

create or replace function check_book_in_profile_achievement(userId int) returns view_user_achievements
    language plpgsql as
$$
    declare result view_user_achievements;
    declare countBooksInProfile int;
    declare  present boolean;
    declare achvId int;
begin
    select count(*) into countBooksInProfile from user_book where user_id = userId;
    select achv_id into achvId from achievement where achv_type = 'book' and n = countBooksInProfile;
    select exists(select * from user_achievement where user_id = userId and achv_id = achvId) into present;
    if not present then
        insert into user_achievement(user_id, achv_id ) values (userId, achvId);
        select user_id, achv_id, title, description, image_path into result
        from user_achievement inner join achievement using(achv_id) where user_id = userId and achv_id = achvId;
        return result;
    else
        return result;
    end if;

end;
$$;

create or replace function check_add_book_or_announcement_achievement(userId int) returns view_user_achievements
    language plpgsql as
$$
    declare result view_user_achievements;
    declare countAddedBooks int;
    declare  present boolean;
    declare achvId int;
begin
    select count(*) into countAddedBooks from review where user_id = userId and approved = true;
    select achv_id into achvId from achievement where achv_type = 'book-announcement' and n = countAddedBooks;
    select exists(select * from user_achievement where user_id = userId and achv_id = achvId) into present;
    if not present then
        insert into user_achievement(user_id, achv_id ) values (userId, achvId);
        select user_id, achv_id, title, description, image_path into result
        from user_achievement inner join achievement using(achv_id) where user_id = userId and achv_id = achvId;
        return result;
    else
        return result;
    end if;

end;
$$;


create or replace function add_read_book(book_name text, author text, read_date date, rating int) returns boolean
language plpgsql as $$
  declare maxId int;
  declare in_unread boolean;
 begin
  select max(rd_book_id) into maxId from read_books;
  select exists(select * from unread_books where book_name = book_name and author = author) into in_unread;
  if in_unread then
  	delete from unread_books where book_name = book_name and author = author;
  end if;
  insert into read_books(rd_book_id, book_name, author, read_date, rating) values (maxId+1, book_name, author, read_date, rating);
  return in_unread;
end;
$$
