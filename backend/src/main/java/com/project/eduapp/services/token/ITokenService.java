package com.project.eduapp.services.token;

import com.project.eduapp.models.Token;
import com.project.eduapp.models.User;
import org.springframework.stereotype.Service;

@Service

public interface ITokenService {
    Token addToken(User user, String token, boolean isMobileDevice);
    Token refreshToken(String refreshToken, User user) throws Exception;
}
