package ru.hukola.poster.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.hukola.poster.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
