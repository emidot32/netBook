package com.example.netbooks.dao.implementations;

import com.example.netbooks.controllers.ProfileController;
import com.example.netbooks.dao.interfaces.BookRepository;
import com.example.netbooks.dao.mappers.*;

import com.example.netbooks.models.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.example.netbooks.models.Announcement;
import com.example.netbooks.models.Book;
import com.example.netbooks.models.ViewBook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.data.relational.core.sql.In;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Array;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.*;

@PropertySource("classpath:queries/book.properties")
@Repository
@Slf4j
public class JdbcBookRepository implements BookRepository {

    private DataSource dataSource;
    private final Environment env;
    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedJdbcTemplate;

    private final RowMapper<ViewAnnouncement> viewAnnouncementMapper;
    private final RowMapper<ViewBook> viewBooksMapper;
    private final RowMapper<Event> eventMapper;
    private final RowMapper<Genre> genreNameMapper;
    private final RowMapper<Author> authorNameMapper;
    private final BookIdRowMapper bookIdMapper;

    @Value("${getBookList}")
    private String getBookList;

    @Value("${getBookListByLikes}")
    private String getBookListByLikes;

    @Value("${getBookListDesc}")
    private String getBookListDesc;

    @Value("${getBookListByLikesDesc}")
    private String getBookListByLikesDesc;

    @Value("${addBookBatchToReading}")
    private String addBookBatchToReading;

    @Value("${addBookBatchToRead}")
    private String addBookBatchToRead;

    @Value("${addBookBatchToFavourite}")
    private String addBookBatchToFavourite;

    @Value("${removeBookBatchFromReading}")
    private String removeBookBatchFromReading;

    @Value("${removeBookBatchFromRead}")
    private String removeBookBatchFromRead;

    @Value("${removeBookBatchFromFavourite}")
    private String removeBookBatchFromFavourite;

    @Value("${addBookBatchToReading}")
    private String removeBookBatch;

    @Autowired
    public JdbcBookRepository(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedJdbcTemplate, DataSource dataSource,
                              Environment env,
                              RowMapper<ViewAnnouncement> viewAnnouncementMapper,
                              ViewBookMapper viewBooksMapper,
                              RowMapper<Event> eventMapper,
                              RowMapper<Genre> genreNameMapper,
                              RowMapper<Author> authorNameMapper,
                              BookIdRowMapper bookIdMapper) {
        log.info("Class initialized");
        this.namedJdbcTemplate = namedJdbcTemplate;
        this.jdbcTemplate = jdbcTemplate;
        this.env = env;
        this.viewAnnouncementMapper = viewAnnouncementMapper;
        this.viewBooksMapper = viewBooksMapper;
        this.eventMapper = eventMapper;
        this.genreNameMapper = genreNameMapper;
        this.dataSource = dataSource;
        this.authorNameMapper = authorNameMapper;
        this.bookIdMapper = bookIdMapper;
    }

    @Override
    public List<ViewBook> findAllViewBooks() {
        return jdbcTemplate.query(env.getProperty("getAllBooks"), viewBooksMapper);
    }
    public int countBooks(){
        return jdbcTemplate.queryForObject(env.getProperty("countBooks"), Integer.class);
    }

    @Override
    public List<ViewAnnouncement> findViewUnApproveBooks(int page, int offset) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("count", offset);
        namedParameters.addValue("offset", page);
        return namedJdbcTemplate.query(env.getProperty("getUnApprove"), namedParameters, viewAnnouncementMapper);
    }

    @Override
    public int getAmountOfAnnouncement() {
        return jdbcTemplate.queryForObject("SELECT COUNT (*) FROM book WHERE approved = true AND release_date >= now();", Integer.class);
    }
    @Override
    public List<ViewBook> getPeaceAnnouncement(int page, int booksPerPage) {
        int startIndex = booksPerPage * (page - 1);
        return jdbcTemplate.query("SELECT book_id, title, description, image_path, release_date, pages, genres, authors, likes, lang FROM view_book_list WHERE approved = true AND release_date >= now() ORDER BY book_id LIMIT " + booksPerPage + " OFFSET " + startIndex, viewBooksMapper);
    }

    @Override
    public int getAmountOfBook() {
        return jdbcTemplate.queryForObject("SELECT COUNT (*) FROM view_book_list WHERE release_date <= now() AND approved = true;", Integer.class);
    }

    @Override
    public List<ViewBook> getPeaceBook(int page, int booksPerPage) {
        int startIndex = booksPerPage * (page - 1);
        return jdbcTemplate.query("SELECT * FROM view_book_list WHERE release_date <= now() AND approved = true ORDER BY title LIMIT " + booksPerPage + " OFFSET " + startIndex, viewBooksMapper);
    }


    @Override
    public List<ViewBook> getPeaceOfSearchBook(String titleOrAuthor, int count, int offset) {
        titleOrAuthor = "%" + titleOrAuthor + "%";
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("titleOrAuthor", titleOrAuthor);
        namedParameters.addValue("count", count);
        namedParameters.addValue("offset", offset);
        return namedJdbcTemplate.query(env.getProperty("getPeaceOfSearchBooks"), namedParameters, viewBooksMapper);
    }

    @Override
    public List<ViewBook> getPeaceOfBook(int count, int offset) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("count", count);
        namedParameters.addValue("offset", offset);
        return namedJdbcTemplate.query(env.getProperty("getPeaceOfBooks"), namedParameters, viewBooksMapper);
    }

    @Override
    public boolean addBookToProfile(long userId, long bookId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        namedParameters.addValue("bookId", bookId);
        return namedJdbcTemplate.update(env.getProperty("addBookToProfile"), namedParameters) > 0;
    }

    @Override
    public boolean checkBookInProfile(long userId, long bookId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        namedParameters.addValue("bookId", bookId);
        return namedJdbcTemplate.queryForObject(env.getProperty("checkBookInProfile"), namedParameters, Integer.class) > 0;
    }

    @Override
    public boolean removeBookFromProfile(long userId, long bookId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        namedParameters.addValue("bookId", bookId);
        return namedJdbcTemplate.update(env.getProperty("removeBookFromProfile"), namedParameters) > 0;
    }

    @Override
    public ViewBook getBookById(int id) {
        SqlParameterSource namedParameters = new MapSqlParameterSource("id", id);
        return (ViewBook) namedJdbcTemplate.query(env.getProperty("getBookById"), namedParameters, viewBooksMapper).get(0);
    }

    @Override
    public List<Book> findAllBooks() {
        return jdbcTemplate.query("select * from book", new BookRowMapper());
    }

    @Override
    public List<Event> getCalendarAllAnnouncement() {
        return namedJdbcTemplate.query(env.getProperty("getCalendarAllAnnouncement"),eventMapper);
    }

    @Override
    public List<Event> getCalendarPersonalizeAnnouncement(int userId) {

        Map<String, Object> namedParameters = new HashMap<>();
        namedParameters.put("value", userId);

        List<Book> favouriteGenreAndAuthorBooksId = namedJdbcTemplate.query(env.getProperty("getUsersFavouriteGenreAndAuthor"),namedParameters, bookIdMapper);
        List<Long> booksId = new ArrayList<>();
        for (Book item : favouriteGenreAndAuthorBooksId) {
            booksId.add(item.getBookId());
        }
        namedParameters.put("id", booksId);
        return namedJdbcTemplate.query(env.getProperty("getPersonalizeAnnouncementNew"), namedParameters, eventMapper);
    }



//    @Override
//    public void likeBook(long bookId) {
//        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
//        namedParameters.addValue("bookId", bookId);
//        namedJdbcTemplate.update(env.getProperty("likeBook"), namedParameters);
//    }

    @Override
    public int countBooksForUser(long userId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        return namedJdbcTemplate.queryForObject(env.getProperty("countBooksForUser"), namedParameters, Integer.class);
    }


    @Override
    public List<ViewBook> findBooksByTitle(String title, int pageSize, int startIndex) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%" + title + "%");
        namedParameters.addValue("limit", pageSize);
        namedParameters.addValue("offset", startIndex);
        return namedJdbcTemplate.query(env.getRequiredProperty("findBooksByTitle"), namedParameters, viewBooksMapper);
    }

    public Integer findAmountBooksByTitle(String title) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%" + title + "%");
        return namedJdbcTemplate.queryForObject(env.getRequiredProperty("findAmountBooksByTitle"), namedParameters, Integer.class);
    }

    @Override
    public List<ViewBook> findBooksByTitleAndDate(String title, Date from, Date to, int pageSize, int startIndex) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        namedParameters.addValue("limit", pageSize);
        namedParameters.addValue("offset", startIndex);
        return namedJdbcTemplate.query(env.getRequiredProperty("findBooksByTitleAndDate"), namedParameters, viewBooksMapper);
    }

    public Integer findAmountBooksByTitleAndDate(String title, Date from, Date to) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        return namedJdbcTemplate.queryForObject(env.getRequiredProperty("findAmountBooksByTitleAndDate"), namedParameters, Integer.class);
    }

    @Override
    public List<ViewBook> findBooksByTitleGenreDate(String title, Integer genre, Date from, Date to, int pageSize, int startIndex) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("genre", genre);
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        namedParameters.addValue("limit", pageSize);
        namedParameters.addValue("offset", startIndex);
        return namedJdbcTemplate.query(env.getRequiredProperty("findBooksByTitleGenreDate") , namedParameters, viewBooksMapper);
    }

    public Integer findAmountBooksByTitleGenreDate(String title, Integer genre, Date from, Date to) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("genre", genre);
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        return namedJdbcTemplate.queryForObject(env.getRequiredProperty("findAmountBooksByTitleGenreDate"), namedParameters, Integer.class);
    }

    public List<ViewBook> findBooksByTitleAuthorDate(String title, Integer author, Date from, Date to, int pageSize, int startIndex) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("author", author);
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        namedParameters.addValue("limit", pageSize);
        namedParameters.addValue("offset", startIndex);
        return namedJdbcTemplate.query(env.getRequiredProperty("findBooksByTitleAuthorDate") , namedParameters, viewBooksMapper);
    }

    public Integer findAmountBooksByTitleAuthorDate(String title, Integer author, Date from, Date to) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("author", author);
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        return namedJdbcTemplate.queryForObject(env.getRequiredProperty("findAmountBooksByTitleAuthorDate"), namedParameters, Integer.class);
    }

    public List<ViewBook> findBooksByTitleAuthorGenreDate(String title, Integer author, Integer genre, Date from, Date to, int pageSize, int startIndex) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("author", author);
        namedParameters.addValue("genre", genre);
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        namedParameters.addValue("limit", pageSize);
        namedParameters.addValue("offset", startIndex);
        return namedJdbcTemplate.query(env.getRequiredProperty("findBooksByTitleAuthorGenre"), namedParameters, viewBooksMapper);
    }

    public Integer findAmountBooksByTitleAuthorGenreDate(String title, Integer author, Integer genre, Date from, Date to) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", "%"+title+"%");
        namedParameters.addValue("author", author);
        namedParameters.addValue("genre", genre);
        namedParameters.addValue("from", from);
        namedParameters.addValue("to", to);
        return namedJdbcTemplate.queryForObject(env.getRequiredProperty("findAmountBooksByTitleAuthorGenre"), namedParameters, Integer.class);
    }

    public Date getMinDateRelease() {
        return jdbcTemplate.queryForObject(env.getRequiredProperty("getMinDateRelease"), Date.class);
    }

    public Date getMaxDateRelease() {
        return jdbcTemplate.queryForObject(env.getRequiredProperty("getMaxDateRelease"), Date.class);
    }


    @Override
    public List<Announcement> findAllAnnouncement() {
        return jdbcTemplate.query("SELECT * FROM announcement WHERE approved = true", this::mapRowToAnnouncement);
    }


    @Override
    public boolean confirmAnnouncement(long announcementId) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("announcementId", announcementId);
        return jdbcTemplate.update("UPDATE book SET approved = true WHERE book_id = " + announcementId) > 0;

    }

    @Override
    public boolean cancelAnnouncement(long announcementId) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("announcment_id", announcementId);
        return jdbcTemplate.update("DELETE FROM book WHERE book_id = " + announcementId) > 0;

    }

    public boolean checkIsExist(Book book) {
        return jdbcTemplate.queryForObject("select exists(select 1 from book where title='" + book.getTitle() + "')", Boolean.class);
    }



    @Override
    public boolean checkIsDuplicate(String title, String description) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", title);
        namedParameters.addValue("description", description);
        int result = namedJdbcTemplate.queryForObject(env.getProperty("checkDuplicates"),namedParameters,Integer.class);
        return result <= 0;
    }


    @Override
    public int addBook(Book book, int userId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("title", book.getTitle());
        namedParameters.addValue("likes", 0);
        namedParameters.addValue("image_path", book.getImagePath());
        namedParameters.addValue("release_date", book.getRelease_date());
        namedParameters.addValue("lang", book.getLanguage());
        namedParameters.addValue("pages", book.getPages());
        namedParameters.addValue("description", book.getDescription());
        namedParameters.addValue("approved", false);
        namedParameters.addValue("user_id", userId);
        namedJdbcTemplate.update(env.getProperty("addBook"),namedParameters);
        return namedJdbcTemplate.queryForObject(env.getProperty("getIdFromBook"), namedParameters, Integer.class);
    }
    private Announcement mapRowToAnnouncement(ResultSet resultSet, int i) throws SQLException {
        return new Announcement(
                resultSet.getInt("announcment_id"),
                resultSet.getInt("announcement_book_id"),
                resultSet.getInt("user_id"),
                resultSet.getBoolean("approved"),
                resultSet.getString("title"),
                resultSet.getString("description"),
                resultSet.getString("image_path"));
    }
    @Override
    public List<ViewBook> getBooksByUserId(Long id, String sought, int cntBooks, int offset, boolean read,
                                           boolean favourite, boolean reading, boolean notSet, BookParam sortBy, Order order) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("offset", offset);
        namedParams.put("cnt", cntBooks);
        namedParams.put("user_id", id);
        namedParams.put("read", read);
        namedParams.put("favourite", favourite);
        namedParams.put("reading", reading);
        namedParams.put("not_set", notSet);
        namedParams.put("sought", "%" + sought + "%");
        if(Order.ASC == order){
            if(BookParam.TITLE == sortBy){
                return namedJdbcTemplate.query(getBookList,
                        namedParams, new ShortViewBookMapper());
            }else{
                return namedJdbcTemplate.query(getBookListByLikes,
                        namedParams, new ShortViewBookMapper());
            }
        }else{
            if(BookParam.TITLE == sortBy){
                return namedJdbcTemplate.query(getBookListDesc,
                        namedParams, new ShortViewBookMapper());
            }else{
                return namedJdbcTemplate.query(getBookListByLikesDesc,
                        namedParams, new ShortViewBookMapper());
            }
        }
    }

    @Override
    public int countAddedBooksForUser(long userId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        return namedJdbcTemplate.queryForObject(env.getProperty("countAddedBooksForUser"), namedParameters, Integer.class);
    }

    @Override
    public void addBookBatchTo(Long userId, Shelf shelf, List<Long> booksId) {
        log.info("Adding book batch to {} by id[{}]", shelf, userId);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("booksId", booksId);
        namedParams.put("user_id", userId);
        if(Shelf.Reading == shelf){
            namedJdbcTemplate.update(addBookBatchToReading, namedParams);
        }else if(Shelf.Read == shelf){
            namedJdbcTemplate.update(addBookBatchToRead, namedParams);
        }else namedJdbcTemplate.update(addBookBatchToFavourite, namedParams);
        log.info("Successful adding books");
    }

    @Override
    public List<ViewBook> getSuggestions(long userId, int pageSize, int startIndex) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        namedParameters.addValue("limit", pageSize);
        namedParameters.addValue("offset", startIndex);
        return namedJdbcTemplate.query(env.getRequiredProperty("getSuggestions"), namedParameters, viewBooksMapper);
    }

    public Integer getAmountSuggestions(long userId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("userId", userId);
        return namedJdbcTemplate.queryForObject(env.getRequiredProperty("getAmountSuggestions"), namedParameters, Integer.class);
    }

    @Override
    public void removeBookBatchFrom(Long userId, Shelf shelf, List<Long> booksId) {
        log.info("Remove book batch from {} by id[{}]", shelf, userId);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("booksId", booksId);
        namedParams.put("user_id", userId);
        if(Shelf.Reading == shelf){
            namedJdbcTemplate.update(removeBookBatchFromReading, namedParams);
        }else if(Shelf.Read == shelf){
            namedJdbcTemplate.update(removeBookBatchFromRead, namedParams);
        }else {
            namedJdbcTemplate.update(removeBookBatchFromFavourite, namedParams);
        }
        log.info("Successful remove books");
    }
    @Override
    public void removeBookBatch(long userId, List<Long> booksId) {
        log.info("Сompletely remove book batch by id[{}]", userId);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("booksId", booksId);
        namedParams.put("user_id", userId);
        namedJdbcTemplate.update(removeBookBatch, namedParams);
        log.info("Successful remove books");
    }
    @Override
    public void likeBook(long bookId, long userId) {
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("like_book");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("bookId", bookId)
                .addValue("userId", userId);
        jdbcCall.executeFunction(Boolean.class, in);

    }

    @Override
    public void dislikeBook(long bookId, long userId) {
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("dislike_book");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("bookId", bookId)
                .addValue("userId", userId);
        jdbcCall.executeFunction(Boolean.class, in);
    }

    @Override
    public boolean checkLickedBook(long bookId, long userId) throws EmptyResultDataAccessException{
//        SimpleJdbcCall jdbcCall = new
//                SimpleJdbcCall(dataSource).withFunctionName("check_book_liked");
//
//        SqlParameterSource in = new MapSqlParameterSource()
//                .addValue("bookId", bookId)
//                .addValue("userId", userId);
//        return jdbcCall.executeFunction(Integer.class, in);
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("bookId", bookId);
        namedParams.put("userId", userId);
        return namedJdbcTemplate.queryForObject(env.getProperty("checkLikedBook"), namedParams, Boolean.class);
    }

    @Override
    public int countAnnouncement(boolean approved){
        SqlParameterSource namedParameters = new MapSqlParameterSource("approved", approved);
        return namedJdbcTemplate.queryForObject(env.getProperty("countUnApproveAnnouncement"), namedParameters, Integer.class);
    }

    public long getUserIdByAnnouncementId(long bookId) {
        SqlParameterSource namedParameters = new MapSqlParameterSource("bookId", bookId);
        return namedJdbcTemplate.queryForObject(env.getProperty("getUserIdByAnnouncementId"), namedParameters, Long.class);
    }


    @Override
    public int countBooks(boolean approved) {
        SqlParameterSource namedParameters = new MapSqlParameterSource("approved", approved);
        return namedJdbcTemplate.queryForObject(env.getProperty("countBooksForApprove"), namedParameters, Integer.class);
    }

    @Override
    public List<ViewBook> getBooksForApprove(int page, int itemPerPage) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("count", itemPerPage);
        namedParameters.addValue("offset", page);
        return namedJdbcTemplate.query(env.getProperty("getBooksForApprove"), namedParameters, viewBooksMapper);
    }

    @Override
    public boolean confirmBook(long BookId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("BookId", BookId);
        return namedJdbcTemplate.update(env.getProperty("approveBook"), namedParameters) > 0;
    }

    @Override
    public boolean cancelBook(long BookId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("BookId", BookId);
        return namedJdbcTemplate.update(env.getProperty("cancelBook"), namedParameters) > 0;
    }
    @Override
    public List<ViewBook> findBooksByAuthor(String author) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("author", author);
        return namedJdbcTemplate.query(env.getRequiredProperty("findBooksByAuthor"), namedParameters, viewBooksMapper);

    }
}
