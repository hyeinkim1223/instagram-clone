const logout = async () => {
    // TODO 1 : /api/logout 으로 POST 요청 보내기 ( async / await)
    const res = await fetch('/api/logout', {method: 'POST'});

    // TODO 2: 요청 성공 시 res.ok
    if (res.ok) window.location.href = "/";
    // TODO 3: 메인 페이지에서 로그인 요청 전으로 변경하고 nav.jsp 로그인 상태 전으로 변경처리
}