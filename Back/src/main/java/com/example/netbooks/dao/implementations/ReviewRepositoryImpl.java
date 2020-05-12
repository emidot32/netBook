package com.example.netbooks.dao.implementations;

import com.example.netbooks.dao.interfaces.ReviewRepository;
import com.example.netbooks.dao.mappers.ReviewMapper;
import com.example.netbooks.models.Review;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.sql.DataSource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@PropertySource("classpath:queries/review.properties")
@Repository
public class ReviewRepositoryImpl implements ReviewRepository {
    private DataSource dataSource;
    private final Environment env;
    private final NamedParameterJdbcTemplate namedJdbcTemplate;
    private final JdbcTemplate jdbcTemplate;
    private final RowMapper reviewMapper = new ReviewMapper();
    @Value("${getReviewPeaceForApprove}")
    String getReviewPeaceForApprove;

    public ReviewRepositoryImpl(Environment env, NamedParameterJdbcTemplate namedJdbcTemplate, JdbcTemplate jdbcTemplate, DataSource dataSource) {
        this.env = env;
        this.namedJdbcTemplate = namedJdbcTemplate;
        this.jdbcTemplate = jdbcTemplate;
        this.dataSource = dataSource;
    }

    @Override
    public int countReviews(boolean approved){
        SqlParameterSource namedParameters = new MapSqlParameterSource("approved", approved);
        return namedJdbcTemplate.queryForObject(env.getProperty("countReviews"), namedParameters, Integer.class);
    }

    @Override
    public int countReviewsForBook(long bookId) {
        SqlParameterSource namedParameters = new MapSqlParameterSource("bookId", bookId);
        return namedJdbcTemplate.queryForObject(env.getProperty("countReviewsForBook"), namedParameters, Integer.class);
    }

    @Override
    public boolean addReviewForUserBook(Review review) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("bookId", review.getBookId());
        namedParameters.addValue("userId", review.getUserId());
        namedParameters.addValue("reviewText", review.getReviewText());
        namedParameters.addValue("approved", review.isApproved());
        return namedJdbcTemplate.update(env.getProperty("addReviewForUserBook"), namedParameters) > 0;
    }

    @Override
    public boolean approveReview(long reviewId) {
        System.out.println(reviewId);
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("reviewId", reviewId);
        return namedJdbcTemplate.update(env.getProperty("approveReview"), namedParameters) > 0;
    }

    @Override
    public boolean cancelReview(long reviewId) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("reviewId", reviewId);
        return namedJdbcTemplate.update(env.getProperty("cancelReview"), namedParameters) > 0;
    }

    @Override
    public List<Review> getReviewsForApprove(int page, int itemPerPage) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("count", itemPerPage);
        namedParameters.addValue("offset", page);
        return namedJdbcTemplate.query(getReviewPeaceForApprove, namedParameters, reviewMapper);
    }


    @Override
    public int likeReview(long reviewId, long userId) {
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("like_review");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("reviewId", reviewId)
                .addValue("userId", userId);
        return jdbcCall.executeFunction(Integer.class, in);
    }

    @Override
    public int dislikeReview(long reviewId, long userId) {
        SimpleJdbcCall jdbcCall = new
                SimpleJdbcCall(dataSource).withFunctionName("dislike_review");

        SqlParameterSource in = new MapSqlParameterSource()
                .addValue("reviewId", reviewId)
                .addValue("userId", userId);
        return jdbcCall.executeFunction(Integer.class, in);
    }

    @Override
    public int checkLikedReview(long reviewId, long userId) {
        Map<String, Object> namedParams = new HashMap<>();
        namedParams.put("reviewId", reviewId);
        namedParams.put("userId", userId);
        Boolean liked = namedJdbcTemplate.queryForObject(env.getProperty("checkLikedReview"), namedParams, Boolean.class);
        if (liked == null) return 0;
        else if (liked) return 1;
        else return -1;
    }

    @Override
    public List<Review> getReviewsByBookId(long bookId) {
        SqlParameterSource namedParameters = new MapSqlParameterSource("bookId", bookId);
        return namedJdbcTemplate.query(env.getProperty("getReviewsByBookId"), namedParameters, reviewMapper);
    }
    
    @Override
    public Review getReviewById(long reviewId){
        SqlParameterSource namedParameters = new MapSqlParameterSource("review_id", reviewId);
        return (Review) namedJdbcTemplate.queryForObject(env.getProperty("getReviewById"), namedParameters, reviewMapper);
    }
    
    @Override
    public List<Review> getPeaceOfReviewByBook(int bookId, int page, int offset) {
        MapSqlParameterSource namedParameters = new MapSqlParameterSource();
        namedParameters.addValue("bookId", bookId);
        namedParameters.addValue("count", page);
        namedParameters.addValue("offset", offset);
        return namedJdbcTemplate.query(env.getProperty("getReviewPeaceByBookId"), namedParameters, reviewMapper);
    }
}
