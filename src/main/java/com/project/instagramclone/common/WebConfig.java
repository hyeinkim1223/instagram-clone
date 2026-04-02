package com.project.instagramclone.common;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * yaml 에 다 작성하지 못한 세부 환경설정
 * 실제 회사 컴퓨터에 위치한 파일의 경로와
 * 유저들에게 제공되어 지는 파일의 위치 경로를
 * 이 경로가 사실은 이 경로에 있는 파일이다 와 같은 매핑 처리
 * <p>
 * ==> 무조건 필요한 것은 아니며, 파일에 관련된 데이터를 서버에 저장하고,
 * 저장된 파일을 브라우저에서 사용해야할 때 필요
 * <p>
 * 이미지, 동영상, 문서 관련 회사가 아니라면 필요없는 환경설정
 */
@Configuration
@RequiredArgsConstructor
public class WebConfig implements WebMvcConfigurer {
    // 만약 RequiredArgsConstructor 를 사용하지 않는다면
    // 1. @Autowired 사용해서 loginInterceptor 호출 -> 생성자를 따로 만들어야한다.
    //    LoginInterceptor loginInterceptor 를 작성할 때 final을 넣을 수 없다.
    //    this.loginInterceptor 와 같은 생성자 생성을 해야하기 때문에 @RequiredArgsConstructor 사용한다.

    // 2. @RequiredArgsConstructor @Autowired  둘 다 사용하지 않는다면
    //     LoginInterceptor loginInterceptor = new LoginInterceptor();
    //     를 만들어서 사용하나.. 레거시한 방법으로 스프링부트에서는 @RequiredArgsConstructor 사용하여
    //     코드 작성을 단축한다.
    private final LoginInterceptor loginInterceptor;


    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/static/**", "/api/**");
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");
    }
}