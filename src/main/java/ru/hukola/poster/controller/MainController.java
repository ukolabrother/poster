package ru.hukola.poster.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import ru.hukola.poster.domain.Post;
import ru.hukola.poster.domain.User;
import ru.hukola.poster.repositories.PostRepository;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

@Controller
public class MainController {
    @Autowired
    private PostRepository postRepository;

    @Value("${upload.path}")
    private String uploadPath;

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
            @Valid Post post,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        post.setAuthor(user);

        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errorsMap);
            model.addAttribute("post", post);
        } else {

            if (file != null && !file.getOriginalFilename().isEmpty()) {
                File uploadFolder = new File(uploadPath);

                if (!uploadFolder.exists()) {
                    uploadFolder.mkdir();
                }
                String fileUID = UUID.randomUUID().toString();
                String fileName = fileUID + "." + file.getOriginalFilename();
                file.transferTo(new File(uploadPath + File.separator + fileName));
                post.setFilename(fileName);
            }
            model.addAttribute("post", null);
            postRepository.save(post);
        }

        Iterable<Post> posts = postRepository.findAll();

        model.addAttribute("posts", posts);
        return "main";
    }



}