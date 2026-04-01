<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="nav">
    <div class="nav-inner">
        <a href="/" class="nav-logo">instagram</a>

        <%-- 검색창 해시태그 드롭 다운
         autocomplete="on"   검색창 클릭하면 브라우저가 이전에 입력했던 값들을 아래로 쭉 보여주기
         autocomplete="off"  검색창 클릭하면 브라우저에서 이전에 입력했던 값들을 보여주지 않는다.

         브라우저가 이전에 입력했던 값을 자동으로 추천해주는 기능 끄는 속성
         브라우저 캐시 지우기를 하면 모두 초기화 처리된다.
         --%>
        <div id="검색창"
             class="nav-search-wrapper">
            <div class="nav-search-box">
                <span class="nav-search-icon">🔎</span>
                <input id="검색입력"
                       class="nav-search-input"
                       type="text"
                       placeholder="검색어를 입력하세요."
                       autocomplete="off">
            </div>
            <div class="hashtag-dropdown"
                 id="태그드롭">
                <p class="hashtag-dropdown-title">인기 해시태그</p>
                <ul class="hashtag-list"
                    id="태그목록">
                    <li class="hashtag-loading">불러오는 중 ...</li>
                </ul>
            </div>
        </div>


        <div class="nav-icons">
            <a class="nav-icon" href="/">홈</a>
            <a class="nav-icon" href="/map">지도</a>
            <a class="nav-icon">글쓰기</a>

            <c:choose>
                <c:when test="${not empty loginUser}">
                    <a href="/user/profile">
                        <c:choose>
                            <c:when test="${not empty loginUser.profile_img}">
                                <img class="nav-avatar" src="${loginUser.profile_img}" alt="프로필">
                            </c:when>
                            <c:otherwise>
                                <span class="nav-icon">👤</span>
                            </c:otherwise>
                        </c:choose>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="/user/login" class="nav-login">로그인</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>