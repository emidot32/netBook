package com.example.netbooks.dao.interfaces;

import com.example.netbooks.models.*;

import java.sql.Date;
import java.util.List;

public interface BookRepository {
    List<Book> findAllBooks();
    List<Announcement> findAllAnnouncement();
    int addBook(Book book, int userId);
    int getAmountOfAnnouncement();
    List<ViewBook> getPeaceAnnouncement(int page, int booksPerPage);

    int getAmountOfBook();
    List<ViewBook> getPeaceBook(int page, int booksPerPage);

    List<ViewBook> getPeaceOfSearchBook(String titleOrAuthor, int page, int offset);
    List<ViewBook> getPeaceOfBook(int page, int offset);
    boolean addBookToProfile(long userId, long bookId);
    boolean checkBookInProfile(long userId, long bookId);
    boolean removeBookFromProfile(long userId, long bookId);


    List<ViewBook> findAllViewBooks();

    ViewBook getBookById(int id);

    List<ViewAnnouncement> findViewUnApproveBooks(int page, int offset);

    List<ViewBook> findBooksByTitle(String title, int pageSize, int startIndex);
    List<ViewBook> findBooksByTitleGenreDate(String title, Integer genre, Date from, Date to, int pageSize, int startIndex);
    List<ViewBook> findBooksByTitleAuthorDate(String title, Integer author, Date from, Date to,  int pageSize, int startIndex);
    List<ViewBook> findBooksByTitleAndDate(String title, Date from, Date to, int pageSize, int startIndex);
    List<ViewBook> findBooksByTitleAuthorGenreDate(String title, Integer author, Integer genre, Date from, Date to, int pageSize, int startIndex);
    List<ViewBook> findBooksByAuthor(String author);


    boolean confirmAnnouncement(long announcementId);
    boolean cancelAnnouncement(long announcementId);



    List<Event> getCalendarAllAnnouncement();
    List<Event> getCalendarPersonalizeAnnouncement(int userId);


    //void likeBook(long bookId);
    int countBooksForUser(long userId);
    void addBookBatchTo(Long userId, Shelf shelf, List<Long> booksId);
    List<ViewBook> getBooksByUserId(Long id, String sought, int cntBooks, int offset, boolean read,
                                    boolean favourite, boolean reading, boolean notSet, BookParam sortBy, Order order);
    void removeBookBatch(long userId, List<Long> booksId);
    void removeBookBatchFrom(Long userId, Shelf shelf, List<Long> booksId);


    int countAnnouncement(boolean approved);

    boolean checkIsDuplicate(String title, String description);

    List<ViewBook> getSuggestions(long userId, int pageSize, int startIndex);
  
    void likeBook(long bookId, long userId);
    void dislikeBook(long bookId, long userId);
    boolean checkLickedBook(long bookId, long userId);

    int countAddedBooksForUser(long userId);

    int countBooks(boolean approved);
    List<ViewBook> getBooksForApprove(int page, int offset);

    boolean confirmBook (long BookId);
    boolean cancelBook (long BookId);
}
