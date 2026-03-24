<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- TODO: 타이틀을 "회원가입 · instagram" 으로 작성하세요 --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&family=Noto+Sans+KR:wght@300;400;500;600&display=swap" rel="stylesheet">
    <%-- TODO: instagram.css 를 링크하세요 → /static/css/instagram.css --%>
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
                        <%-- TODO: phone-post-avatar 에 🌿 이모지를 넣으세요 --%>
                        <%-- TODO: phone-post-username 에 "new_user" 를 넣으세요 --%>
                    </div>
                    <%-- TODO: phone-post-img 에 style="background: linear-gradient(45deg,#a18cd1,#fbc2eb)" 을 적용하세요 --%>
                    <div class="phone-post-img"></div>
                    <div class="phone-post-actions">❤️ 💬 📤</div>
                    <%-- TODO: phone-post-caption 에 "첫 번째 게시물 🌱" 를 넣으세요 --%>
                </div>

                <%-- 두 번째 phone-post --%>
                <div class="phone-post">
                    <div class="phone-post-header">
                        <%-- TODO: phone-post-avatar 에 🎨 이모지를 넣으세요 --%>
                        <%-- TODO: phone-post-username 에 "art_lover" 를 넣으세요 --%>
                    </div>
                    <%-- TODO: phone-post-img 에 style="background: linear-gradient(45deg,#fd7043,#ffca28)" 을 적용하세요 --%>
                    <div class="phone-post-img"></div>
                    <div class="phone-post-actions">🤍 💬 📤</div>
                    <%-- TODO: phone-post-caption 에 "오늘의 작업물 🖌️" 를 넣으세요 --%>
                </div>

            </div>
        </div>

        <%-- ===== 회원가입 폼 ===== --%>
        <div class="auth-area">
            <div class="auth-box">

                <%-- TODO: class="auth-logo" div 안에 "instagram" 로고 텍스트를 넣으세요 --%>

                <%-- TODO: class="auth-subtitle" p 태그에 아래 문구를 넣으세요
                     "친구들의 사진과 동영상을<br>보려면 가입하세요." --%>

                <%-- TODO: id="alert-box" class="alert" div 을 작성하세요 (내용 없음) --%>

                <%-- 이름 입력 --%>
                <div class="field">
                    <%-- TODO: type="text" id="name" placeholder="이름" class="field-input" input 을 작성하세요 --%>
                    <%-- TODO: for="name" class="field-label" label 을 작성하세요 (텍스트: 이름) --%>
                </div>

                <%-- 이메일 + 인증번호 발송 버튼 --%>
                <div class="field-row">
                    <div class="field">
                        <%-- TODO: type="email" id="email" placeholder="이메일" class="field-input" input 을 작성하세요 --%>
                        <%-- TODO: for="email" class="field-label" label 을 작성하세요 (텍스트: 이메일) --%>
                    </div>
                    <%-- TODO: id="send-code-btn" class="field-side-btn" type="button" onclick="인증번호발송()" 버튼을 작성하세요
                         텍스트: 인증번호 발송 --%>
                </div>

                <%-- 인증번호 확인 영역 (처음엔 숨김) --%>
                <div id="code-area" style="display:none; width:100%; margin-top:8px;">
                    <div class="field-row">
                        <div class="field">
                            <%-- TODO: type="text" id="code" placeholder="인증번호 6자리" maxlength="6" class="field-input" input 을 작성하세요 --%>
                            <%-- TODO: for="code" class="field-label" label 을 작성하세요 (텍스트: 인증번호) --%>
                        </div>
                        <%-- TODO: id="verify-btn" class="field-side-btn" type="button" onclick="인증번호확인()" 버튼을 작성하세요
                             텍스트: 확인 --%>
                    </div>
                    <%-- TODO: id="verify-result" class="verify-result" div 을 작성하세요 (내용 없음, JS 가 채움) --%>
                </div>

                <%-- 비밀번호 입력 --%>
                <div class="field" style="margin-top:8px;">
                    <%-- TODO: type="password" id="password" placeholder="비밀번호" class="field-input" input 을 작성하세요 --%>
                    <%-- TODO: for="password" class="field-label" label 을 작성하세요 (텍스트: 비밀번호) --%>
                </div>

                <%-- TODO: id="register-btn" class="btn btn-blue" onclick="가입하기()" 버튼을 작성하세요
                     style="margin-top:12px;"  텍스트: 가입하기 --%>

                <p style="font-size:12px; color:#8e8e8e; text-align:center; margin-top:16px; line-height:1.6;">
                    가입하면 instagram의
                    <a href="#" style="color:#00376b;">약관</a>,
                    <a href="#" style="color:#00376b;">개인정보처리방침</a>에 동의하는 것입니다.
                </p>

            </div>

            <%-- 하단 링크 --%>
            <div class="auth-link-box">
                <%-- TODO: "계정이 있으신가요?" 텍스트와 /user/login 으로 이동하는 "로그인" 링크를 작성하세요 --%>
            </div>
        </div>

    </div>
</div>

<%-- TODO: footer.jsp 를 include 하세요 → /WEB-INF/views/common/footer.jsp --%>

<%-- TODO: /static/js/register.js 스크립트를 연결하세요 --%>

</body>
</html>