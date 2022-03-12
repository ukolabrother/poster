package ru.hukola.poster.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.hukola.poster.domain.Post;
import ru.hukola.poster.domain.User;
import ru.hukola.poster.repositories.PostRepository;

import java.util.Map;

@Controller
public class MainController {
    @Autowired
    private PostRepository postRepository;

    @GetMapping("/")
    public String greeting(Map<String, Object> model) {

        return "greeting";
    }

    @GetMapping("main")
    public String main(
            @RequestParam(required = false, defaultValue = "") String filter,
            Model model
    ) {
        Iterable<Post> posts = postRepository.findAll();
        if (filter != null && !filter.isEmpty()) {
            posts = postRepository.findByTag(filter);
        } else {
            posts = postRepository.findAll();
        }
        model.addAttribute("posts", posts);
        model.addAttribute("filter", filter);

        return "main";
    }

    @PostMapping("main")
    public String add(
            @AuthenticationPrincipal User user,
            @RequestParam String text,
            @RequestParam String tag,
            Map<String, Object> model
    ) {
        Post post = new Post(text, tag, user);
        postRepository.save(post);
        Iterable<Post> posts = postRepository.findAll();

        model.put("posts", posts);
        return "main";
    }

}