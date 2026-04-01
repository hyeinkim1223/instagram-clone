package com.project.instagramclone.model.service;

import com.project.instagramclone.model.dto.HashTag;
import com.project.instagramclone.model.mapper.HashTagMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

// @Autowired 절 대 금 지!!!
@Service
@RequiredArgsConstructor
public class HashTagService {
    private final HashTagMapper hashTagMapper;

    public List<HashTag> 인기해시태그가져오기(){
        return hashTagMapper.인기해시태그조회();
    }

    public List<HashTag> 해시태그검색(String keyword){
        return hashTagMapper.해시태그검색(keyword);
    }
}
