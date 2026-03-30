<%@ page import="com.project.instagramclone.model.dto.Location" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
만약 백엔드로 데이터를 front-end로 전달하는 데이터가 있다면
 isELIgnored="false" 로 설정해야한다.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>카카오맵 마커</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="/static/css/kakao-map.css">
</head>
<body>
<%--    html css 트렌드
<header> = 태그 안에는 header 만들 때 기본으로 만들어진 css 가 장착
<div>    = 주로 사용하는 트렌드  -> 프레임워크 : react, vue 의 경우 div 를 기준으로 코딩을 진행한다.

--%>
<%-- --헤더 -- --%>
<div class="header">
    <div class="header-dot"></div>
    <h1>카카오맵 마커</h1>
    <span>총 5개 저장소</span>
</div>

<div class="map-wrap">
    <div id="map"></div>
    <div class="side-panel">
        <h2>장소 목록</h2>
        <div id="place-list">
            <%--
            c:forEach   반복 순회 하겠다 표기법
            items       반복할 데이터 목록 model.addAttribute("locations", 장소목록데이터); 로 가져온 데이터들
            var         반복할 때 마다 하나씩 꺼낸 값을 담는 변수명
            varStatus   반복 상태 정보를 담는 변수
                         varStatus="status"
                                   status.index -> 현재 순서 0번 째부터 순번 부여받음
                                   status.count -> 현재 순서 1번 째부터 순번 부여  총 개수 length 형태
                                   status.first -> 첫 번째 항목이면 true
                                   status.last  -> 마지막  항목이면 true
            --%>
            <c:forEach items="${locations}" var="loc" varStatus="status">
                <div class="place-item" id="place-${loc.id}" onclick="마커이동(${status.index})">
                    <div class="place-icon" style="background: ${loc.color}22; color: ${loc.color}">
                            ${loc.icon}
                    </div>
                    <div class="place-info">
                        <div class="place-name">${loc.name}</div>
                        <div class="place-desc">${loc.description}</div>
                    </div>
                </div>
            </c:forEach>


        </div>
    </div>
</div>
<script>
    //=======================================================
    // 위도/경도 JSON 데이터
    // 실제 프로젝트에서는 Controller 에서 위도 경도를 db 로 전달받아
    // 동적으로 출력
    // API 연결 스크립트의 경우 최하단 배치
    // 웹 브라우저에서 map 생성하고 initMap 호출 과 같은 여러 작업을 한 다음에 마커를 찍는 작업
    //=======================================================
    const locations = [
        <c:forEach items="${locations}" var="loc" varStatus="status">
        {
            id:    ${loc.id},
            name: "${loc.name}",
            desc: "${loc.description}",
            lat:   ${loc.lat},
            lng:   ${loc.lng},
            icon: "${loc.icon}",
            color: "${loc.color}"
        }
        <%-- 현재 loc 에서 받은 locations 데이터가 맨 마지막 데이턱 아닌게 맞다면 맨 뒤에 ,를 추가해라 --%>
        <c:if test="${!status.last}">, </c:if>
        </c:forEach>
    ];
    //=======================================================
    // 사이드 패널 장소 목록 렌더링
    //=======================================================
    // placeList
    // ctrl + / 전체 주석 해제 설정
    // 위에서 백엔드로 전달받은 데이터의 형태를 html에 직접적으로 작성했기 때문에 innerHTML에서 추가해줄 필요 없다.
    <%--const 장소들 = document.getElementById("place-list");--%>

    <%--locations.forEach((loc, idx) => {--%>
    <%--    const item = document.createElement("div");--%>
    <%--    item.className = "place-item";--%>
    <%--    item.id = "place-" + loc.id;--%>
    <%--    item.innerHTML = `--%>
    <%--    <div class="place-icon" style="background:${loc.color}22; color:${loc.color}">--%>
    <%--        ${loc.icon}--%>
    <%--    </div>--%>
    <%--    <div class="place-info">--%>
    <%--        <div class="place-name">${loc.name}</div>--%>
    <%--        <div class="place-desc">${loc.desc}</div>--%>
    <%--    </div>--%>
    <%--    `;--%>
    <%--    item.addEventListener("click", () => 마커이동(idx));--%>
    <%--    장소들.appendChild(item);--%>
    <%--});--%>

    // =====================================================
    // 카카오로 지도 띄우기
    // =====================================================
    //let 지도 ;
    //let 마커목록 = [];
    //let 인포윈도우목록 =[];
    let 지도, 마커목록 = [], 인포윈도우목록 = [];

    function 지도초기화() {
        const container = document.getElementById("map");
        const options = {
            center: new kakao.maps.LatLng(37.5400, 126.9700),
            level: 8
        };
        지도 = new kakao.maps.Map(container, options);

        지도.addControl(new kakao.maps.ZoomControl(), kakao.maps.ControlPosition.RIGHT);
        지도.addControl(new kakao.maps.MapTypeControl(), kakao.maps.ControlPosition.TOPRIGHT);

        locations.forEach((loc, idx) => {
            const 마커 = new kakao.maps.Marker({
                map: 지도,
                position: new kakao.maps.LatLng(loc.lat, loc.lng),
                title: loc.name
            });

            // 인포윈도우 내용 (말풍선 팝업)
            // 카카오맵에서 내부적으로 HTML을 이용해서 받는 형태로 코드자체가 되어 있기 때문에
            // html 작성 불가
            //  isELIgnored="false" 로 하였고, 백엔드 데이터를 자바스크립트에서 어떻게 가져오겠다 세팅이 되어있지 않은 상태이므로
            // css 적용이 되지 않는 것!
            const 인포윈도우내용 = `
            <div style="    background: #1a1a1a;    border: 1px solid #333;    border-radius: 12px;    padding: 12px 14px;     font-family: 'Inter', sans-serif; min-width: 160px; box-shadow: 0 8px 32px rgba(0,0,0,0.5);">
                <div style="font-size: 14px; font-weight: 700; color: #fff; margin-bottom: 4px;">${loc.icon} ${loc.name}</div>
                <div  style="font-size: 12px; color: #888;">${loc.desc}</div>
                <span  style="  display: inline-block; margin-top: 6px;  padding: 2px 8px; border-radius: 20px; font-size: 11px; font-weight: 600;">
                   ${loc.lat.toFixed(4)} ${loc.lng.toFixed(4)}
                </span>
            </div>
            `;
            const 인포윈도우 = new kakao.maps.InfoWindow({
                content: 인포윈도우내용,
                removable: true,
            });

            kakao.maps.event.addListener(마커, "click", () => {
                인포윈도우목록.forEach(iw => iw.close());
                인포윈도우.open(지도, 마커);
                사이드아이템강조(idx);
            });

            마커목록.push(마커);
            인포윈도우목록.push(인포윈도우);

        });
    }


    // 사이드 패널 클릭 -> 지도 이동 + 내부에서 인포윈도우 열기
    function 마커이동(idx) {
        const loc = locations[idx];
        지도.setCenter(new kakao.maps.LatLng(loc.lat, loc.lng));
        지도.setLevel(5);
        인포윈도우목록.forEach(iw => iw.close());
        인포윈도우목록[idx].open(지도, 마커목록[idx]);
        사이드아이템강조(idx);
    }

    // 사이드 아이템 강조 기능
    function 사이드아이템강조(idx) {
        document.querySelectorAll(".place-item").forEach(item => {
            item.classList.remove("active");
        });
        document.getElementById("place-" + locations[idx].id).classList.add("active");

    }

    /*
    혹시 우리 화살표 함수 배웠었나요? =>
    안 배웠다면 이 부분과  왜
    ` 쓰는지 그리고 왜 여러 종류 중 innerHTML인 건지도 설명 부탁드려요.
     */

</script>
<%--
카카오에서 플랫폼 키를 가져올 때, 테스트 앱 -> 비즈 앱에 되어 있는 키를 가져온다.
비즈 앱에 있는 키의 경우 사업자등록을 한 사람들이 정식적으로 운영하는 서비스이고,
이 서비스를 운영하기 위해서 개발자가 테스트하는 용도로 총 5개까지 만들어서 테스트 할 수 있도록 테스트 앱 제공
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c44a240eea76342b264917d72eb4eea3&onload=지도초기화"></script>
--%>
<%-- 비즈 앱 이 아닌 테스트 앱 -> 비즈 앱에 기재되어 있는 플랫폼 키에서 JavaScript 키 를 가져와 사용한다.--%>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7b3c1268686dba44c21ed3c821eabf30&autoload=false"></script>
<script>
    kakao.maps.load(function () {
        지도초기화();
    });
</script>
</body>
</html>