package com.project.instagramclone.controller;

import com.project.instagramclone.model.dto.User;
import com.project.instagramclone.model.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
public class UserApiController {
    private  final UserService userService;

    @PostMapping("/api/send-code")
    public ResponseEntity<?> 인증번호발송(@RequestBody Map<String, String> body) {
        String email = body.get("email");
        userService.인증번호발송(email);
        return ResponseEntity.ok(Map.of("message", "인증번호가 발송되었습니다."));
    }

    @PostMapping("/api/verify-code")
    public ResponseEntity<?> 인증번호확인(@RequestBody Map<String, String> body) {
        boolean 성공 = userService.인증번호검증(
                body.get("email"),
                body.get("code")
        );
        if (!성공) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "인증번호가 올바르지 않습니다."));
        }
        return ResponseEntity.ok(Map.of("message", "인증 성공"));
    }

    @PostMapping ("/api/register")
    public ResponseEntity<?> 회원가입(@RequestBody User user) {
        boolean 성공 = userService.회원가입(user);
        if (!성공) {
            return ResponseEntity.badRequest()
                    .body(Map.of("message", "이미 사용중인 이메일입니다."));
        }
        return ResponseEntity.ok(Map.of("message", "회원가입 완료"));
    }

    @GetMapping("/api/users")
    public ResponseEntity<?> 모든회원조회(){
        List<User>  user = userService.모든회원조회();
        return ResponseEntity.ok(user);
    }

    @GetMapping("/api/users/search")
    public ResponseEntity<?> 유저명검색(@RequestParam String keyword){
        List<User> 결과 = userService.유저명검색(keyword);
        return ResponseEntity.ok(결과);
    }
}