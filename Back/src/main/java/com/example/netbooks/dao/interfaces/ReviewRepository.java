package com.example.netbooks.dao.interfaces;

import com.example.netbooks.models.Review;
import com.example.netbooks.models.ViewBook;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository {
    List<Review> getReviewsByBookId(long id);
    List<Review> getPeaceOfReviewByBook(int bookId, int page, int offset);
    int countReviews(boolean approved);
    int countReviewsForBook(long bookId);
    boolean addReviewForUserBook(Review review);
    boolean approveReview(long reviewId);
    boolean cancelReview(long reviewId);
    List<Review> getReviewsForApprove(int page, int offset);
    Review getReviewById(long reviewId);
    int likeReview(long reviewId, long userId);
    int dislikeReview(long reviewId, long userId);
    int checkLikedReview(long reviewId, long userId);
}
