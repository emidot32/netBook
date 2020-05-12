package com.example.netbooks.security;

import com.example.netbooks.exceptions.CustomException;
import com.example.netbooks.services.ChatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.lang.Nullable;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import java.util.Objects;

@Slf4j
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    private JwtProvider jwtProvider;
    private ChatService chatService;
    @Autowired
    public WebSocketConfig(JwtProvider jwtProvider, ChatService chatService) {
        this.jwtProvider = jwtProvider;
        this.chatService = chatService;
    }
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/end-point")
                .setAllowedOrigins("https://netbooksfront.herokuapp.com");
    }
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.setApplicationDestinationPrefixes("/socket-subscriber")
                .enableSimpleBroker("/socket-publisher");
    }
    @Override
    public void configureClientInboundChannel(ChannelRegistration registration) {
        registration.interceptors(new ChannelInterceptor() {
            @Override
            public Message<?> preSend(@Nullable Message<?> message, MessageChannel channel) {
                if (Objects.isNull(message))
                    return null;
                StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);
                if (Objects.isNull(accessor))
                    return null;

                String authToken = accessor.getFirstNativeHeader("Authorization");
                if(!StompCommand.DISCONNECT.equals(accessor.getCommand())){
                    jwtProvider.validateToken(authToken);
                    accessor.setLogin(jwtProvider.getUsername(authToken));
                    checkAccess(accessor);
                }
                return message;
            }
        });

    }

    private void checkAccess(StompHeaderAccessor accessor){
        String dest = accessor.getDestination();
        if(dest != null) {
            String chatId = dest.substring(1 + dest.lastIndexOf('/'));
            if (!chatService.isMemberOfChat(Long.parseLong(chatId), accessor.getLogin())) {
                throw new CustomException("Access for chat [" + chatId + "] subscribe denied for " + accessor.getLogin(),
                        HttpStatus.FORBIDDEN);
            }
        }
    }
}
