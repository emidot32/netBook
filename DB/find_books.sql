select * from view_book_list 
  WHERE lower(title) like '%lord%' 
  or EXISTS (SELECT FROM  unnest(authors) 
  author WHERE  lower(author) LIKE '%lord%');
-- select * from book_author;
-- select title, 
-- 	ARRAY(SELECT DISTINCT UNNEST(array_agg(aut.fullname)::varchar[])) authors ,
-- 	likes, image_path,  release_date, lang, pages, 
-- 	ARRAY(SELECT DISTINCT UNNEST(array_agg(gen.genre_name)::varchar[])) genres,
-- 	description 
-- 	from book 
-- 	inner join book_author using(book_id) 
-- 	inner join author aut using(author_id)
-- 	inner join book_genre using (book_id)
-- 	inner join genre gen using(genre_id)
-- 	where approved = true 
-- 	and 'Fantasy' in genres
-- 	and lower(any(authors)) like '%r%'
-- 	group by  book_id
-- ;
--select * from book where lower(title) like '%the picture of dorian gray%' ;
--select author_id from author where lower(firstname) like '%con%' or lower(lastname) like '%con%' or lower(firstname) like 'con%' or lower(lastname) like 'con%' ;
-- select * from book 
-- 	inner join book_author using (book_id) 
-- 	inner join book_genre using (book_id)
-- 	where lower(title) like '%the%' and
-- 	author_id in
-- 	(select author_id from author where lower(firstname) like '%a%' or lower(lastname) like '%a%') and
-- 	  genre_id in (select genre_id from genre where genre_name in ('Detective')) and 
-- 	  release_date between '1800-05-01' and '2000-09-09' and 
-- 	  pages between 50 and 200;
	