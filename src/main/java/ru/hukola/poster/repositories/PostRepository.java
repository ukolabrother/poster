package ru.hukola.poster.repositories;

import org.springframework.data.repository.CrudRepository;
import ru.hukola.poster.domain.Post;

import java.util.List;

public interface PostRepository extends CrudRepository<Post, Long> {

    List<Post> findByTag(String tag);
}
