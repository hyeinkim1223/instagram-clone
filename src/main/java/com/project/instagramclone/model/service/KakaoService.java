package com.project.instagramclone.model.service;

import com.project.instagramclone.common.CookieUtil;
import com.project.instagramclone.common.JwtUtil;
import com.project.instagramclone.model.dto.User;
import com.project.instagramclone.model.mapper.UserMapper;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

/**
 * 카카오 로그인 전체 비즈니스 로직 담당
 *
 * [컨트롤러가 할 일]  요청 받기 / 리다이렉트
 * [서비스가 할 일]    카카오 URL 생성 / 토큰 발급 / 유저 정보 조회 / 회원가입 / JWT 발급 / 쿠키 저장
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoService {

    private final UserService userService;
    @Value("${kakao.client-id}")
    private String clientId;

    @Value("${kakao.redirect-uri}")
    private String redirectUri;

    @Value("${kakao.client-secret}")
    private String clientSecret;

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    private final CookieUtil cookieUtil;

    // 다른 회사에 요청을 보낼 때 사용
    // http(=get, post 와 같은) 요청은 인터넷 웹 브라우저 통해서 요청을 Controller 로 보내고 전달받는데
    // 웹 브라우저를 통하는게 아니라 자바에서 다른 회사 자바로 소통하며 데이터를 주고 받을 때 사용
    private final RestTemplate restTemplate = new RestTemplate();

    // ─────────────────────────────────────────────
    // 1. 카카오 로그인 URL 생성
    // ─────────────────────────────────────────────
    //public String getKakaoLoginUrl() {
    public String 카카오로그인주소() {
        return "https://kauth.kakao.com/oauth/authorize"
                + "?client_id=" + clientId
                + "&redirect_uri=" + redirectUri
                + "&response_type=code";
    }

    // ─────────────────────────────────────────────
    // 2. 카카오 로그인 메인 흐름 (컨트롤러에서 호출)
    //    인가코드 → 액세스토큰 → 유저정보 → 회원가입 or 스킵 → JWT → 쿠키발급
    // ─────────────────────────────────────────────
    //public void kakaoLogin(String code, HttpServletResponse response) {
    public void 카카오로그인(String 인가코드, HttpServletResponse response) {
        // 2-1. 인가코드 → 카카오 액세스토큰
        String 카카오토큰 = 엑세스토큰발급(인가코드);

        // 2-2. 카카오 액세스토큰 → 이메일, 닉네임
        Map<String, String> 유저정보 = 유저정보조회(카카오토큰);
        String 이메일 = 유저정보.get("email");
        String 닉네임  = 유저정보.get("nickname");

        if (이메일 == null) {
            throw new RuntimeException("카카오 계정에 이메일 정보가 없습니다.");
        }

        // 2-3. DB에 없으면 자동 회원가입
        User 신규유저 = new User();
        신규유저.setName(닉네임 != null ? 닉네임 : "카카오유저"); //유저가 작성한 닉네임이 업승면 카카오유저라는 이름으로 저장
        신규유저.setEmail(이메일);
        userService.카카오회원가입(신규유저);

        // 2-4. JWT 발급 후 쿠키 저장
        String 엑세스토큰  = jwtUtil.createAccessToken(이메일);
        String 리프레시토큰 = jwtUtil.createRefreshToken(이메일);

        // 2-5. JWT 발급 후 쿠키 저장
        cookieUtil.add(response, "access_token",  엑세스토큰,  60 * 30);           // 30분
        cookieUtil.add(response, "refresh_token", 리프레시토큰, 60 * 60 * 24 * 7);  // 7일

        log.info("카카오 로그인 성공: {}", 이메일);
    }

    // ─────────────────────────────────────────────
    // 3. 인가코드 → 카카오 액세스토큰 발급
    // 인가코드 :
    //     사용자가 카카오 로그인 버튼 클릭 -> 카카오 로그인 페이지로 이동해서 아이디 / 비밀번호 입력 -> 카카오에서 입증된 유저야 하고 임시 인증팔찌제공 (= 인가코드)
    // ─────────────────────────────────────────────
    //private String getAccessToken(String code) {
    private String 엑세스토큰발급(String 인가코드) {

        // 문서 다운로드는 build.gradle 에서 매번 maven.com 에 기재되어있는 주소에서 관련 코드를 가져오는 것이 아니라
        // 나의 프로젝트에 내장시켜놓고 사용
        HttpHeaders 헤더 = new HttpHeaders();
        헤더.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        MultiValueMap<String, String> 파라미터 = new LinkedMultiValueMap<>();
        파라미터.add("grant_type", "authorization_code");
        파라미터.add("client_id", clientId);
        파라미터.add("redirect_uri", redirectUri);
        파라미터.add("code", 인가코드);
        파라미터.add("client_secret", clientSecret);

        HttpEntity<MultiValueMap<String, String>> 요청 = new HttpEntity<>(파라미터, 헤더);
        ResponseEntity<Map> 응답 = restTemplate.postForEntity("https://kauth.kakao.com/oauth/token", 요청, Map.class);

        if (응답.getStatusCode() != HttpStatus.OK || 응답.getBody() == null) {
            throw new RuntimeException("카카오 토큰 발급 실패");
        }

        return (String) 응답.getBody().get("access_token");
    }

    // ─────────────────────────────────────────────
    // 4. 카카오 액세스토큰 → 사용자 이메일/닉네임 조회
    // claims 에서 팔찌 내부를 뜯어서 유저 정보를 확인했던 것처럼 카카오에서 전달받은 팔찌안에 조회되는 유저정보를 뜯어서 가져오기
    // ─────────────────────────────────────────────
    @SuppressWarnings("unchecked")
    private Map<String, String> 유저정보조회(String 카카오토큰) {

        HttpHeaders 헤더 = new HttpHeaders();
        헤더.setBearerAuth(카카오토큰);
        헤더.setContentType(MediaType.APPLICATION_FORM_URLENCODED); // APPLICATION_FORM_URLENCODED = 어떤 형식으로 포장해서 보낸다.

        HttpEntity<Void> 요청 = new HttpEntity<>(헤더);
        ResponseEntity<Map> 응답 = restTemplate.exchange(
                "https://kapi.kakao.com/v2/user/me", HttpMethod.GET, 요청, Map.class
        );

        if (응답.getStatusCode() != HttpStatus.OK || 응답.getBody() == null) {
            // 잘못된 팔찌여서 팔찌 내에 존재하는 유저정보를 확인할 수 없습니다.
            throw new RuntimeException("카카오 사용자 정보 조회 실패로 인하여 유저 정보를 세부적으로 확인할 수 없습니다.");
        }

        Map<String, Object> 카카오계정 = (Map<String, Object>) 응답.getBody().get("kakao_account");

        Map<String, String> 결과 = new HashMap<>();
        if (카카오계정 != null) {
            결과.put("email", (String) 카카오계정.get("email"));
            Map<String, Object> 프로필 = (Map<String, Object>) 카카오계정.get("profile");
            if (프로필 != null) {
                결과.put("name", (String) 프로필.get("nickname"));
            }
        }

        return 결과;
    }
}