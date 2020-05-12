package com.example.netbooks.services;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import com.example.netbooks.dao.implementations.AchievementRepository;
import com.example.netbooks.exceptions.EmailExistException;
import com.example.netbooks.exceptions.LoginExistException;
import com.example.netbooks.models.*;
import com.google.common.base.Strings;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.netbooks.dao.implementations.UserRepository;
import com.example.netbooks.exceptions.CustomException;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Data
@Service
@Slf4j
public class UserManager {
    private UserRepository userRepository;
	private AchievementRepository achievementRepository;
    private FileStorageService fileStorageService;
    private VerificationTokenManager verificationTokenManager;
    private EmailSender emailSender;
    private NotificationService notificationService;
	@Autowired
    public UserManager(UserRepository userRepository,
                       EmailSender emailSender,
                       AchievementRepository achievementRepository,
                       FileStorageService fileStorageService,
                       VerificationTokenManager verificationTokenManager) {
        this.userRepository = userRepository;
        this.emailSender = emailSender;
        this.achievementRepository = achievementRepository;
        this.fileStorageService = fileStorageService;
        this.verificationTokenManager = verificationTokenManager;
    }


	public User getUserByEmail(String email) {
		return userRepository.findByEmail(email);
	}
    public int getUserIdByName(String name) { return userRepository.getUserIdByLogin(name); }
    public void removeUserById(long id) {
        userRepository.removeUserById(id);
    }

    public void updateUser(User user, MultipartFile file) {
        if (!userRepository.findByLogin(user.getLogin()).getEmail().equals(user.getEmail())
                && userRepository.isExistByMail(user.getEmail())){
            log.info("Email - {} already in use", user.getEmail());
            throw new EmailExistException("Email is already in use");
        }
        if (file != null) {
            fileStorageService.deleteFile(user.getAvatarFilePath());
            user.setAvatarFilePath(UUID.randomUUID().toString());
            fileStorageService.saveFile(file, user.getAvatarFilePath());
        }
        userRepository.updateUser(user);
    }

    public void updateUserById(User user, Long id) {
        userRepository.updateUserById(user, id);
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public User createAndSaveTempAdmin() throws IOException {
        User user = new User();
        String tempLogPass = UUID.randomUUID().toString();
        user.setLogin(tempLogPass);
        user.setPassword(tempLogPass);
        user.setEmail(tempLogPass);
        user.setName(tempLogPass);
        user.setRegDate(LocalDate.now());
        user.setRole(Role.ROLE_ADMIN);
        saveUser(user);
        return user;
    }

    public User createAndSaveTempModer() throws IOException {
        User user = new User();
        String tempLogPass = UUID.randomUUID().toString();
        user.setLogin(tempLogPass);
        user.setPassword(tempLogPass);
        user.setEmail(tempLogPass);
        user.setName(tempLogPass);
        user.setRegDate(LocalDate.now());
        user.setRole(Role.ROLE_MODER);
        saveUser(user);
        return user;
    }

    public void activateUser(long id) {
        userRepository.activateUser(id);
    }

    public void deActivateUser(long id) {
        userRepository.deActivateUser(id);
    }

    public User getUserByMail(String mail) {
        return userRepository.findByEmail(mail);
    }

    public User getUserById(long id) {
        return userRepository.findByUserId(id);
    }

    public Boolean isExistByLogin(String login) {
        return userRepository.isExistByLogin(login);
    }

    public Boolean isExistByMail(String mail) {
        return userRepository.isExistByMail(mail);
    }

    public User getUserByLogin(String login) {
        return userRepository.findByLogin(login);
    }


    public void setMinRefreshDate(String login, Date date) {
        userRepository.setMinRefreshDate(login, date);
    }

    public List<Achievement> getAchievementByLogin(String login) {
		return achievementRepository.findByAchievementId(
				userRepository.findByLogin(login).getUserId());
    }

	public List<User> getFriendsByLogin(String login, int cntFriends, int offset) {
		return userRepository.getFriendsByLogin(login, cntFriends, offset);
	}
	public List<User> getFriendsByUsername(String login) {
		return userRepository.getFriendsByUsername(login);
	}

    public List<User> getSubscribersByLogin(String login) {
        return userRepository.getSubscribersByLogin(login);
    }

    public List<User> getPersonsBySought(String login, String sought, int cntPersons, int offset, SearchIn where,
                                         Role userRole) {
        return userRepository.getPersonsBySought(login, sought, cntPersons, offset, where, userRole);
    }

    public String getUserRole(String login) {
        return userRepository.getUserRole(login);
    }


	public void addFriend(String ownLogin, String friendLogin) {
		long userId = userRepository.getUserIdByLogin(ownLogin);
        try{
            UserAchievement userAchievement =
                    achievementRepository.checkUserAchievement(userId, "friends");
            notificationService.createAndSaveAchievNotif(userId, userAchievement.getAchvId());
        } catch (NullPointerException e){
            e.getMessage();
        }
		userRepository.addFriend(ownLogin, friendLogin);
	}

	public int isFriend(String ownLogin, String friendLogin) {
		return userRepository.isFriend(ownLogin, friendLogin);
	}

	public void deleteFriend(String ownLogin, String friendLogin) {
		userRepository.deleteFriend(ownLogin, friendLogin);
	}

    public void register(User user) {
        if (userRepository.isExistByLogin(user.getLogin())){
            throw new LoginExistException("Login is already in use");
        }
        if (userRepository.isExistByMail(user.getEmail())){
            throw new EmailExistException("Email is already in use");
        }
        user.setRegDate(LocalDate.now());
        userRepository.save(user);
        VerificationToken verificationToken = new VerificationToken(
                userRepository.findByLogin(user.getLogin()).getUserId());
        verificationTokenManager.saveToken(verificationToken);

        String message = "To verification your account, please click here : "
                + "https://netbooksfront.herokuapp.com/verification-account?token="
                + verificationToken.getVerificationToken();
        //log.info("fff {}", message);
        emailSender.sendMessage(user.getEmail(), "Complete Registration!", message);
    }

    public void confirmUserAccount(String verificationToken) {
        VerificationToken token = verificationTokenManager.findVerificationToken(verificationToken);
        userRepository.activateUser(token.getUserId());
        log.info("confirmUserAccount for {}", token.getUserId());
        verificationTokenManager.removeVerificationToken(verificationToken);
    }

    public void requestForRecoveryPass(String email) {
        User user = userRepository.findByEmail(email);
        VerificationToken verificationToken = new VerificationToken(user.getUserId());
        verificationTokenManager.saveToken(verificationToken);
        String message = "To recovery your password, please click here : "
                + "https://netbooksfront.herokuapp.com/recovery-password?token="
                + verificationToken.getVerificationToken();
        log.info("dd {}", message);
        emailSender.sendMessage(user.getEmail(), "Recovery your password", message);
	}

    public void recoveryPass(String verificationToken, String newPassword) {
        VerificationToken token = verificationTokenManager.findVerificationToken(verificationToken);
        User user = userRepository.findByUserId(token.getUserId());
        log.info("Change pass for {}", user.getLogin());
        user.setPassword(newPassword);
        user.setMinRefreshDate(null);
        userRepository.updateUser(user);
        verificationTokenManager.removeVerificationToken(verificationToken);
	}

    public String getCurrentUserLogin(){
        return ((UserDetails) SecurityContextHolder.getContext().
                getAuthentication().getPrincipal()).getUsername();
    }

    public Role getCurrentUserRole(){
        UserDetails currentUserDetails
                = ((UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal());
        return (Role) (currentUserDetails.getAuthorities().iterator().next());
    }
}
