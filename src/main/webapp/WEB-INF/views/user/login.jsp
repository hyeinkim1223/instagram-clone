<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- TODO: 타이틀을 "로그인 · instagram" 으로 작성하세요 --%>
    <title>Instagram</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Noto+Sans+KR:wght@300;400;500;600&display=swap" rel="stylesheet">
    <%-- TODO: instagram.css 를 링크하세요 → /static/css/instagram.css --%>
    <link href="/static/css/instagram.css" rel="stylesheet">
</head>
<body>

<div class="auth-page">
    <div class="auth-wrap">

        <%-- ===== 폰 목업 ===== --%>
        <div class="phone">
            <div class="phone-notch">
                <div class="phone-pill"></div>
            </div>
            <div class="phone-screen">

                <%-- 첫 번째 phone-post --%>
                <div class="phone-post">
                    <div class="phone-post-header">
                        <div class="phone-post-avatar">🌸</div>
                        <div class="phone-post-username">spring_lover</div>
                        <%-- TODO: phone-post-avatar 에 🌸 이모지를 넣으세요 --%>
                        <%-- TODO: phone-post-username 에 "spring_lover" 를 넣으세요 --%>
                    </div>
                    <%-- TODO: phone-post-img 에 style="background: linear-gradient(45deg,#f09433,#dc2743)" 을 적용하세요 --%>
                    <div class="phone-post-img" style="background: linear-gradient(45deg,#f09433,#dc2743)"></div>
                    <div class="phone-post-actions">❤️ 💬 📤</div>
                    <div class="phone-post-caption">Spring Boot로 만든 하루 ☕</div>
                    <%-- TODO: phone-post-caption 에 "Spring Boot로 만든 하루 ☕" 를 넣으세요 --%>
                </div>

                <%-- 두 번째 phone-post --%>
                <div class="phone-post">
                    <div class="phone-post-header">
                        <div class="phone-post-avatar">🚀</div>
                        <div class="phone-post-username">dev_kim</div>
                        <%-- TODO: phone-post-avatar 에 🚀 이모지를 넣으세요 --%>
                        <%-- TODO: phone-post-username 에 "dev_kim" 을 넣으세요 --%>
                    </div>
                    <%-- TODO: phone-post-img 에 style="background: linear-gradient(45deg,#4facfe,#00f2fe)" 을 적용하세요 --%>
                    <div class="phone-post-img" style="background: linear-gradient(45deg,#4facfe,#00f2fe)"></div>
                    <div class="phone-post-actions">🤍 💬 📤</div>
                    <div class="phone-post-caption">JWT 인증 구현 완료! 🎉</div>
                    <%-- TODO: phone-post-caption 에 "JWT 인증 구현 완료! 🎉" 를 넣으세요 --%>
                </div>

            </div>
        </div>

        <%-- ===== 로그인 폼 ===== --%>
        <div class="auth-area">
            <div class="auth-box">

                <%-- TODO: class="auth-logo" div 안에 "instagram" 로고 텍스트를 넣으세요 --%>
                <div class="auth-logo">Instatrgram</div>
                <%-- TODO: id="alert-box" class="alert" div 을 작성하세요 (내용 없음, JS 가 채움) --%>
                <div id="alert-box" class="alert"></div>
                <%-- 이메일 입력 --%>
                <div class="field">
                    <input type="email" id="email" placeholder="이메일" class="field-input">
                    <%-- TODO: type="email" id="email" placeholder="이메일" class="field-input" input 을 작성하세요 --%>
                    <label for="email" class="field-label"></label>
                    <%-- TODO: for="email" class="field-label" label 을 작성하세요 (텍스트: 이메일) --%>
                </div>

                <%-- 비밀번호 입력 --%>
                <div class="field">
                    <%-- TODO: type="password" id="password" placeholder="비밀번호" class="field-input" input 을 작성하세요 --%>
                        <input type="password" id="password" placeholder="비밀번호" class="field-input">
                    <%-- TODO: for="password" class="field-label" label 을 작성하세요 (텍스트: 비밀번호) --%>
                        <label for="password" class="field-label"></label>
                    <%-- TODO: id="pw-toggle-btn" class="field-pw-toggle" type="button" onclick="togglePassword()" 버튼을 작성하세요 (텍스트: 표시) --%>
                    <button id="pw-toggle-btn" class="field-pw-toggle" type="button" onclick="togglePassword()">표시</button>
                </div>

                <%-- TODO: id="login-btn" class="btn btn-blue" onclick="로그인()" 버튼을 작성하세요
                     style="margin-top:8px;"  텍스트: 로그인 --%>
                <button id="login-btn" class="btn btn-blue" onclick="로그인()"></button>
                <%-- TODO: id="spinner" class="spinner" span 을 작성하세요 (내용 없음) --%>

                <%-- 구분선 --%>
                <div class="divider">
                    <div class="divider-line"></div>
                    <span class="divider-text">또는</span>
                    <div class="divider-line"></div>
                </div>

                <a href="#" style="font-size:14px; font-weight:600; color:#385185; margin-bottom:16px;">
                    Facebook으로 로그인
                </a>
                <a href="/user/find-email" style="font-size:12px; color:#00376b; margin-top:8px;">
                    비밀번호를 잊으셨나요?
                </a>

            </div>

            <%-- 하단 링크 --%>
            <div class="auth-link-box">
                <%-- TODO: "계정이 없으신가요?" 텍스트와 /user/register 로 이동하는 "가입하기" 링크를 작성하세요 --%>
            </div>
        </div>

    </div>
</div>

<%-- TODO: footer.jsp 를 include 하세요 → /WEB-INF/views/common/footer.jsp --%>

<%-- TODO: /static/js/login.js 스크립트를 연결하세요 --%>

</body>
</html>