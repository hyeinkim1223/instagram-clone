package com.project.instagramclone.model.mapper;

import com.project.instagramclone.model.dto.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserMapper {

    // TODO D-1 : 회원가입 메서드 선언
    // 반환타입   메서드이름  (매개변수자료형  매개변수이름)
    void 회원가입(User user);

    // TODO D-2 : 이메일 중복 체크 메서드 선언
    // SQL 에서 COUNT(*) 결과를 받아야 한다. 어떤 자료형?
    int 이메일중복체크(String email); // 인증번호 보내기 전에 DB에 존재하는 이메일인가? 체크
    User 이메일로회원찾기(String email);
    List<User> 모든회원조회();
}