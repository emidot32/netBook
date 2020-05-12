package com.example.netbooks.services;

import com.example.netbooks.dao.implementations.AchievementRepository;
import com.example.netbooks.models.Achievement;
import com.example.netbooks.models.UserAchievement;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AchievementService {
    private final AchievementRepository achievementRepository;
    private final NotificationService notificationService;

    public AchievementService(AchievementRepository achievementRepository, NotificationService notificationService) {
        this.achievementRepository = achievementRepository;
        this.notificationService = notificationService;

    }

    public void checkBookPatternAchievementsAndSendNotification(long userId, long bookId, String favOrRead) {
        boolean addedAuthorAchv = achievementRepository.checkAchievementAuthor(bookId, userId, favOrRead);
        if (addedAuthorAchv) {
            UserAchievement userAchievement = achievementRepository.getLastUserAchievement(userId);
            notificationService.createAndSaveAchievNotif(userId, userAchievement.getAchvId());

        }
        boolean addedGenreAchv = achievementRepository.checkAchievementGenre(bookId, userId,  favOrRead);
        if (addedGenreAchv) {
            UserAchievement userAchievement = achievementRepository.getLastUserAchievement(userId);
            notificationService.createAndSaveAchievNotif(userId, userAchievement.getAchvId());

        }
    }

    public boolean addAchievement(Achievement achievement) {
        String validatedTitle = achievement.getTitle().trim().replaceAll(" +", " ");
        achievement.setTitle(validatedTitle.substring(0,1).toUpperCase() + validatedTitle.substring(1));
        String validatedDescription = achievement.getDescription().trim().replaceAll(" +", " ");
        achievement.setDescription(validatedDescription.substring(0,1).toUpperCase() + validatedDescription.substring(1));
        return achievementRepository.addAchievement(achievement);
    }
    public List<Achievement> getAchievements(int page, int size) {
        return achievementRepository.getAchievements(page, size);
    }
    public void removeAchievement(long achvId) {
        achievementRepository.removeAchievement(achvId);
    }
}
