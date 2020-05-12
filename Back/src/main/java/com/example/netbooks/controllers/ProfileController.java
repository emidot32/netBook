package com.example.netbooks.controllers;

import com.example.netbooks.exceptions.UserNotFoundException;
import com.example.netbooks.exceptions.ValidationException;
import com.example.netbooks.models.*;
import com.example.netbooks.services.*;
import com.google.common.base.Strings;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSON;

import java.util.List;

@RestController
@CrossOrigin(origins = {"http://localhost:4200", "https://netbooksfront.herokuapp.com"})
@RequestMapping(value = "/profile")
@Slf4j
public class ProfileController {
    private UserManager userManager;
    private BookService bookService;
    private NotificationService notificationService;
    private PasswordEncoder passwordEncoder;
    private ValidationService validationService;
    @Autowired
    public ProfileController(UserManager userManager, BookService bookService,
                             NotificationService notificationService,
                             PasswordEncoder passwordEncoder,
                             ValidationService validationService) {
        log.info("Class initialized");
        this.userManager = userManager;
        this.bookService = bookService;
        this.notificationService = notificationService;
        this.passwordEncoder = passwordEncoder;
        this.validationService = validationService;
    }

    /**
     * Get user information
     * @param login user login
     * @exception UserNotFoundException when user not found or access denied
     * @return User
     */
    @GetMapping("/{login}")
    public User getUser(@PathVariable("login")String login){
        log.info("GET /{}", login);
        User user = userManager.getUserByLogin(login);
        //block if its admin but not you`
        if(!user.getRole().equals(Role.ROLE_CLIENT) &&
                userManager.getCurrentUserRole().equals(Role.ROLE_CLIENT)){
            log.info("Cannot get access to view {} profile from {}", userManager.getCurrentUserLogin(), login);
            throw new UserNotFoundException("User not found");
        }
        return user;
    }

    /**
     * Get list of user achievements
     * @param login user login
     * @return List of Achievements
     * @exception UserNotFoundException when user not found
     */
    @GetMapping("/{login}/get-achievement")
    public List<Achievement> getAchievements(@PathVariable("login")String login){
        return userManager.getAchievementByLogin(login);
    }

    /**
     * Edit user profile information
     * @param login Edited user login
     * @param file new user avatar
     * @param userInJson user information
     * @exception UserNotFoundException when user not found
     * @exception ValidationException when edited user data is not valid
     */
    @PutMapping("/{login}/edit")
    public void editUser(@PathVariable("login")String login,
                         @RequestParam(value = "file", required = false) MultipartFile file,
                         @RequestParam("user") String userInJson) {
        log.info("PUT /{}/edit", login);
        User user = JSON.parseObject(userInJson, User.class);
        if(!login.equals(userManager.getCurrentUserLogin()) && Integer.parseInt(userManager.getUserRole(login)) - 1
                <= userManager.getCurrentUserRole().ordinal()) {
            log.info("Cannot get access to edit {} profile from {}", userManager.getCurrentUserLogin(), login);
            return;
        }
        userManager.updateUser(compareAndReplace(validationService.userValidation(user)), file);
    }

    @GetMapping("/{login}/friends")
    public List<User> getFriends(@PathVariable("login")String login,
                                 @RequestParam("cnt")int cntFriends, @RequestParam("offset")int offset){
        return userManager.getFriendsByLogin(login, cntFriends, offset);
    }
    @GetMapping("/{login}/favourite-books")
    public List<ViewBook> getFavouriteBooks(@PathVariable("login")String login,
                                            @RequestParam("sought")String sought,
                                            @RequestParam("cnt")int cntBooks,
                                            @RequestParam("offset")int offset){
        return bookService.getFavouriteBooksByUserId(
                userManager.getUserByLogin(login).getUserId(), sought, cntBooks, offset);
    }
    @GetMapping("/{login}/reading-books")
    public List<ViewBook> getReadingBooks(@PathVariable("login")String login,
                                          @RequestParam("sought")String sought,
                                          @RequestParam("cnt")int cntBooks,
                                          @RequestParam("offset")int offset){
        return bookService.getReadingBooksByUserId(
                userManager.getUserByLogin(login).getUserId(), sought, cntBooks, offset);
    }
    @GetMapping("/{login}/read-books")
    public List<ViewBook> getReadBooks(@PathVariable("login")String login,
                                       @RequestParam("sought")String sought,
                                       @RequestParam("cnt")int cntBooks,
                                       @RequestParam("offset")int offset){
        return bookService.getReadBooksByUserId(
                userManager.getUserByLogin(login).getUserId(), sought, cntBooks, offset);
    }

    /**
     * Check if requested user is editable
     * @param login user login
     * @return true if you can edit this user, otherwise - false
     */
    @GetMapping("/{login}/is-editable")
    public boolean isEditable(@PathVariable("login")String login){
        if(userManager.getCurrentUserLogin().equals(login)) return true;
        return Integer.parseInt(userManager.getUserRole(login)) - 1 >
                userManager.getCurrentUserRole().ordinal();
    }
    @PostMapping("/add-friend/{friendLogin}")
    public void addFriend(@PathVariable("friendLogin") String friendLogin) {
        log.info("POST /add-friend/{} by {}", friendLogin, userManager.getCurrentUserLogin());
        String ownLogin = userManager.getCurrentUserLogin();
        if(!userManager.getUserRole(friendLogin).equals("4")) return;
        userManager.addFriend(ownLogin, friendLogin);

            Notification notification = new Notification();
            notification.setNotifTypeId(1);
            notification.setUserId((int) (userManager.getUserByLogin(friendLogin).getUserId()));
            notification.setFromUserId((int) (userManager.getUserByLogin(ownLogin).getUserId()));
            notificationService.addNotification(notification);
    }
    /**
     * Check if requested user is your friend
     * @param ownLogin own user login
     * @param friendLogin requested user login
     * @return 1 - user is your friend, 0 - you are subscribe on this user, -1 - otherwise(not friend)
     */
    @GetMapping("/is-friend/{ownLogin}/{friendLogin}")
    public int isFriend(@PathVariable("ownLogin")String ownLogin,
                        @PathVariable("friendLogin") String friendLogin){

        return userManager.isFriend(ownLogin, friendLogin);
    }
    @DeleteMapping("/delete-friend/{friendLogin}")
    public void deleteFriend(@PathVariable("friendLogin") String friendLogin){
        log.info("DELETE /delete-friend/{} by {}", friendLogin, userManager.getCurrentUserLogin());
        userManager.deleteFriend(userManager.getCurrentUserLogin(), friendLogin);
    }

    /**
     * Get user book list
     * @param login user login
     * @param sought sought for search in user book list
     * @param size count returning books
     * @param read if true - returning book on this shelf
     * @param favourite if true - returning book on this shelf
     * @param reading if true - returning book on this shelf
     * @param notSet if true - returning book on this shelf
     * @param sortBy sort result by (BookParam.TITLE or BookParam.LIKES)
     * @param order oreder of the result set (Order.ASC or Order.DESC)
     * @param page current page
     * @return list of books
     */
    @GetMapping("/{login}/book-list")
    public List<ViewBook> getBookList(@PathVariable("login")String login,
                                      @RequestParam("sought")String sought,
                                      @RequestParam("size")int size,
                                      @RequestParam("read")boolean read,
                                      @RequestParam("favourite")boolean favourite,
                                      @RequestParam("reading")boolean reading,
                                      @RequestParam("notset")boolean notSet,
                                      @RequestParam("sortby")int sortBy,
                                      @RequestParam("order")int order,
                                      @RequestParam("page")int page){
        return bookService.getBooksByUserId(
                userManager.getUserByLogin(login).getUserId(),
                sought, size, read, favourite, reading, notSet, BookParam.values()[sortBy], Order.values()[order], page);
    }

    /**
     * Add selected books into {shelf}
     * @param shelf a shelf in which will be added books
     * @param booksId list of selected books id
     */
    @PutMapping("/{shelf}/add-books")
    public void addBookBatchTo(@PathVariable("shelf")int shelf,
                               @RequestBody List<Long> booksId){
        log.info("PUT /{}/add-books/ by {}", Shelf.values()[shelf], userManager.getCurrentUserLogin());
        bookService.addBookBatchTo(
                userManager.getUserByLogin(userManager.getCurrentUserLogin()).getUserId(), Shelf.values()[shelf], booksId);
    }

    /**
     * Remove selected books from {shelf}
     * @param shelf a shelf from which will be removed books
     * @param booksId list of selected books id
     */
    @PutMapping("/{shelf}/remove-books")
    public void removeBookBatchFrom(@PathVariable("shelf")int shelf,
                                    @RequestBody List<Long> booksId){
        log.info("PUT /{}/remove-books/ by {}", Shelf.values()[shelf], userManager.getCurrentUserLogin());
        bookService.removeBookBatchFrom(userManager.getUserByLogin(userManager.getCurrentUserLogin()).
                getUserId(), Shelf.values()[shelf], booksId);
    }

    /**
     * Completely remove selected book from user book list
     * @param booksId list of selected books id
     */
    @DeleteMapping("/remove-books")
    public void removeBookBatch(@RequestParam("booksid") List<Long> booksId){
        log.info("DELETE /remove-books by {}", userManager.getCurrentUserLogin());
        bookService.removeBookBatch(userManager.getUserByLogin(userManager.getCurrentUserLogin()).getUserId(), booksId);
    }

    /**
     * Compare and replace fields which was changed compared with current user profile setting
     * @param user edited user
     * @return user with replaced fields
     */
    private User compareAndReplace(User user){
        User originalUser = userManager.getUserByLogin(user.getLogin());
        if(!Strings.isNullOrEmpty(user.getPassword())) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        originalUser.compareAndReplace(user);
        return originalUser;
    }
}
