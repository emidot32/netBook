package com.example.netbooks.dao.interfaces;

import com.example.netbooks.models.VerificationToken;

public interface VerificationTokenRepository {

    void save(VerificationToken token);
    void removeVerificationToken(String token);

    VerificationToken findByVerificationToken(String token);
    VerificationToken findByVerificationTokenByUserId(Long id);
}
