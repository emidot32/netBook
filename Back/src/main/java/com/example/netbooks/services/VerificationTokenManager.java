package com.example.netbooks.services;

import com.example.netbooks.dao.implementations.VerificationTokenRepository;
import org.springframework.beans.factory.annotation.Autowired;
import com.example.netbooks.models.VerificationToken;
import org.springframework.stereotype.Component;

@Component
public class VerificationTokenManager {
    private VerificationTokenRepository verificationTokenRepository;
    @Autowired
    public VerificationTokenManager(VerificationTokenRepository verificationTokenRepository) {
        this.verificationTokenRepository = verificationTokenRepository;
    }
    
    public VerificationToken findVerificationToken(String verificationToken) {
        return verificationTokenRepository.findByVerificationToken(verificationToken);
    }
    public VerificationToken findVerificationTokenByUserId(Long id) {
        return verificationTokenRepository.findByVerificationTokenByUserId(id);
    }
    
    public void removeVerificationToken(String verificationToken) {
        verificationTokenRepository.removeVerificationToken(verificationToken);
    }
    
    public void saveToken(VerificationToken VerTok)
    {
       verificationTokenRepository.save(VerTok);
    }
}
