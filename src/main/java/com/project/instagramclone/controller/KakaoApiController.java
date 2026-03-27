package com.project.instagramclone.controller;

import com.project.instagramclone.model.service.KakaoService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@Slf4j
@RestController
@RequiredArgsConstructor
public class KakaoApiController {

    private final KakaoService kakaoService;

    /**
     * 카카오 로그인 URL 생성은 서비스가 담당
     * 컨트롤러는 받아서 리다이렉트만
     */
    @GetMapping("/api/kakao/login")
    public void kakaoLogin(HttpServletResponse response) throws IOException {
        String 주소 = kakaoService.카카오로그인주소();
        response.sendRedirect(주소);
    }

    /**
     * 카카오 콜백
     * 토큰 발급 / 유저 조회 / 회원가입 / JWT / 쿠키 → 전부 서비스
     * 컨트롤러는 성공/실패 리다이렉트만
     */
    @GetMapping("/api/kakao/callback")
    public void 카카오콜백(@RequestParam String code,
                              HttpServletResponse response) throws IOException {
        try {
            kakaoService.카카오로그인(code, response);
            response.sendRedirect("/");
        } catch (Exception e) {
            log.error("카카오 로그인 실패: {}", e.getMessage());
            response.sendRedirect("/user/login?error=kakao_fail");
        }
    }
}