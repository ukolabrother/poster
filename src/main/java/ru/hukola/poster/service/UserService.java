package ru.hukola.poster.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import ru.hukola.poster.domain.Role;
import ru.hukola.poster.domain.User;
import ru.hukola.poster.repositories.UserRepository;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailSender mailSender;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByUsername(username);
    }

    public boolean addUser(User user) {
        User userFromDB = userRepository.findByUsername(user.getUsername());

        if (userFromDB != null) {
            return false;
        }
        user.setActive(true);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        userRepository.save(user);

        sendActivationEmail(user);

        return true;
    }

    private void sendActivationEmail(User user) {
        if (!StringUtils.hasText(user.getEmail())) {
            String message = String.format(
                    "Hello, %s.%s" +
                    "Welcome to Poster. Please, visit next link: http://localhost:8080/activate/%s",
                    user.getUsername(),
                    System.lineSeparator(),
                    user.getActivationCode()
            );
            mailSender.send(user.getEmail(), "Activation code", message);
        }
    }

    public boolean activateUser(String code) {
        User user = userRepository.findByActivationCode(code);

        if (user == null) {
            return false;
        }

        user.setActivationCode(null);

        userRepository.save(user);

        return false;
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void saveUser(User user, String userName, Map<String, String> form) {
        user.setUsername(userName);
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    public void updateUserProfile(User user, String password, String email) {
        String curEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(curEmail)) ||
                (curEmail != null && curEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);

            if (!StringUtils.hasText(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }

            if (StringUtils.hasText(password)) {
                user.setPassword(password);
            }
        }

        userRepository.save(user);

        if (isEmailChanged) {
            sendActivationEmail(user);
        }


    }
}
