package com.project.instagramclone.model.mapper;

import com.project.instagramclone.model.dto.HashTag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface HashTagMapper {
    // 인기 해시태그 목록
    List<HashTag> 인기해시태그조회();

    // 키워드로 해시태그 검색
    List<HashTag> 해시태그검색(@Param("keyword") String keyword);
}
