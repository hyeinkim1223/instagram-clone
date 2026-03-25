package com.project.instagramclone.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {
    /**
     * 보통 "/"경로는 따로 만들지 않아도
     * @return index.jsp 나 index.html 파일을 바라보도록 설정되어 있다.
     * 자동감지설정이 읽혀지지 않을 수 있기 때문에 index 세팅
     */

    @GetMapping("/")
    public String indexView() {
        return "index";
    }

    @GetMapping("/user/login")
    public String loginView() {
        return "user/login";
    }

    @GetMapping("/user/register")
    public String registerView() {
        return "user/register";
    }

    @GetMapping("/board/list")
    public String listView(Model model) {
        return "board/list";
    }

    @GetMapping("/board/detail")
    public String detailView(int board_no, Model model) {
        return "board/detail";
    }

    @GetMapping("/board/write")
    public String writeView() {
        return "board/write";
    }

    @GetMapping("/board/edit")
    public String editView(int board_no, Model model) {
        return "board/edit";
    }
}
