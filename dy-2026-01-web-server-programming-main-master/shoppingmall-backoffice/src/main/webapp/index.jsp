<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="kr.ac.dy.cs.util.SessionUtils" %>
<%
    boolean isLoggedIn = SessionUtils.isLoginYn(session);

    // ===== 🔥 [기능 구현용 인기상품 TOP 10 데이터] =====
    String[][] hotProducts = {
            {"P0001", "블랙 오버핏 후드티", "3,420", "₩ 167,580,000", "92"},
            {"P0012", "클래식 화이트 스니커즈", "2,890", "₩ 257,210,000", "98"},
            {"P0045", "린넨 밴딩 슬랙스 (네이비)", "2,110", "₩ 82,290,000", "45"},
            {"P0023", "오토매틱 메쉬 스트랩 시계", "1,750", "₩ 523,250,000", "12"},
            {"P0008", "비건 레더 미니 백팩", "1,620", "₩ 144,180,000", "28"},
            {"P0092", "데일리 순면 양말 5팩", "1,490", "₩ 14,750,000", "150"},
            {"P0031", "유니섹스 카고 조거팬츠", "1,220", "₩ 72,580,000", "34"},
            {"P0019", "실버 체인 레이어드 목걸이", "1,150", "₩ 26,450,000", "67"},
            {"P0054", "그래픽 피그먼트 반팔티", "980", "₩ 33,320,000", "88"},
            {"P0102", "워터프루프 아웃도어 바람막이", "850", "₩ 109,650,000", "5"}
    };

    // ===== ❤️ [기능 구현용 찜 목록 TOP 10 데이터] =====
    String[][] wishProducts = {
            {"P0023", "오토매틱 메쉬 스트랩 시계", "5,420", "₩ 299,000", "판매중"},
            {"P0012", "클래식 화이트 스니커즈", "4,890", "₩ 89,000", "판매중"},
            {"P0001", "블랙 오버핏 후드티", "4,110", "₩ 49,000", "판매중"},
            {"P0088", "프리미엄 구스다운 패딩", "3,750", "₩ 389,000", "재고부족"},
            {"P0120", "무선 스마트 노이즈캔슬링 헤드폰", "3,220", "₩ 249,000", "판매중"},
            {"P0008", "비건 레더 미니 백팩", "2,980", "₩ 89,000", "판매중"},
            {"P0045", "린넨 밴딩 슬랙스 (네이비)", "2,450", "₩ 39,000", "품절"},
            {"P0153", "천연 소가죽 정장 벨트", "1,920", "₩ 45,000", "판매중"},
            {"P0071", "크루넥 캐시미어 니트", "1,680", "₩ 119,000", "판매중"},
            {"P0204", "스트라이프 이지 오버핏 셔츠", "1,410", "₩ 54,000", "판매중"}
    };

    // 그래프 퍼센트 계산용 가중치 기준값 (각각 1위 수치)
    int maxSales = 3420;
    int maxWish = 5420;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>SHOPMALL ADMIN - 쇼핑몰 관리자 시스템</title>
    <link rel="stylesheet" href="/css/main.css">
    <style>
        /* 추가 컴포넌트 전용 자체 스코프 스타일링 */
        .trend-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 28px;
            margin-top: 40px;
        }
        .trend-panel {
            background: #fff;
            border-radius: 16px;
            padding: 28px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            transition: background-color 0.3s, border-color 0.3s;
        }
        .trend-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            margin-top: 12px;
        }
        .trend-table th {
            padding: 12px 16px;
            font-size: 13px;
            color: #6b7280;
            background: #f9fafb;
            font-weight: 600;
            border-bottom: 2px solid #e5e7eb;
        }
        .trend-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #f3f4f6;
            font-size: 14px;
            vertical-align: middle;
        }
        .rank-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 24px;
            height: 24px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 800;
        }
        .bar-container {
            width: 100%;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            overflow: hidden;
            margin-top: 4px;
        }
        .status-chip {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
        }

        /* ⭐️ 완벽한 다크모드 동적 스타일 매핑 */
        body.dark-mode .trend-panel {
            background: #1e293b;
            border-color: #334155;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
        }
        body.dark-mode .trend-table th {
            background: #111827;
            color: #94a3b8;
            border-bottom-color: #334155;
        }
        body.dark-mode .trend-table td {
            border-bottom-color: #334155;
            color: #cbd5e1;
        }
        body.dark-mode .bar-container {
            background: #334155;
        }
        body.dark-mode .rank-badge[style*="background: #e2e8f0"] {
            background: #475569 !important;
            color: #cbd5e1 !important;
        }
    </style>
</head>
<body class="admin-landing">

<header class="admin-header">
    <div class="theme-toggle" style="position: absolute; right: 20px; top: 22px; z-index: 101;">
        <button id="darkModeBtn" style="padding: 6px 12px; border-radius: 20px; border: 1px solid #ccc; background: transparent; cursor: pointer; font-size: 13px; font-weight: 600; color: inherit;">🌙 다크모드</button>
    </div>
    <div class="container header-inner">
        <a href="/index.jsp" class="logo">SHOP<span>MALL</span> ADMIN</a>
        <nav class="admin-nav" style="margin-right: 100px;"> <a href="#about">소개</a>
            <% if (isLoggedIn) { %><a href="#realtime-trends">실시간 트렌드</a><% } %>
            <a href="#features">주요 기능</a>
            <a href="#login-guide">로그인 안내</a>
            <% if (isLoggedIn) { %>
            <a href="/dashboard/index.jsp" class="btn-header-login">대시보드</a>
            <% } else { %>
            <a href="/auth/adminLogin.jsp" class="btn-header-login">로그인</a>
            <% } %>
        </nav>
    </div>
</header>

<section class="admin-hero">
    <div class="container admin-hero-inner">
        <div class="admin-hero-text">
            <span class="hero-eyebrow">BACKOFFICE SYSTEM</span>
            <h1>쇼핑몰을 더 똑똑하게,<br>관리자 시스템 한곳에서.</h1>
            <p class="hero-desc">
                상품, 주문, 회원, 통계까지 — 쇼핑몰 운영에 필요한 모든 기능을<br>
                직관적인 화면에서 한눈에 관리하실 수 있습니다.
            </p>
            <div class="hero-actions">
                <% if (isLoggedIn) { %>
                <a href="/dashboard/index.jsp" class="btn-primary">대시보드로 이동 →</a>
                <% } else { %>
                <a href="/auth/adminLogin.jsp" class="btn-primary">관리자 로그인</a>
                <% } %>
                <a href="#login-guide" class="btn-secondary">로그인 절차 안내</a>
            </div>
            <div class="hero-meta">
                <div><strong>99.9%</strong><span>시스템 안정성</span></div>
                <div><strong>24/7</strong><span>운영 모니터링</span></div>
                <div><strong>SSL</strong><span>보안 접속</span></div>
            </div>
        </div>
        <div class="admin-hero-card">
            <div class="card-bar">
                <span class="dot red"></span>
                <span class="dot yellow"></span>
                <span class="dot green"></span>
                <span class="card-title">SHOPMALL Admin Dashboard</span>
            </div>
            <div class="card-body">
                <div class="stat-row">
                    <div class="stat">
                        <span class="stat-label">오늘의 주문</span>
                        <span class="stat-value">128 건</span>
                    </div>
                    <div class="stat">
                        <span class="stat-label">금일 매출</span>
                        <span class="stat-value">₩ 4,820,000</span>
                    </div>
                </div>
                <div class="stat-row">
                    <div class="stat">
                        <span class="stat-label">신규 회원</span>
                        <span class="stat-value">37 명</span>
                    </div>
                    <div class="stat">
                        <span class="stat-label">재고 부족</span>
                        <span class="stat-value alert">12 종</span>
                    </div>
                </div>
                <div class="chart-mock">
                    <span style="height: 40%"></span>
                    <span style="height: 70%"></span>
                    <span style="height: 55%"></span>
                    <span style="height: 85%"></span>
                    <span style="height: 60%"></span>
                    <span style="height: 95%"></span>
                    <span style="height: 75%"></span>
                </div>
            </div>
        </div>
    </div>
</section>

<% if (isLoggedIn) { %>
<section id="realtime-trends" class="admin-about" style="background: transparent; padding-top: 0;">
    <div class="container">
        <div class="section-title" style="margin-bottom: 32px;">
            <span class="eyebrow" style="background: #fee2e2; color: #ef4444;">REALTIME STATS</span>
            <h2>시스템 실시간 소비 트렌드</h2>
            <p>현재 쇼핑몰 서비스 전반에서 가장 유동량이 높은 핵심 기획 상품 인덱스 데이터입니다.</p>
        </div>

        <div class="trend-grid">
            <div class="trend-panel">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                    <h3 style="font-size: 18px; font-weight: 800; display: flex; align-items: center; gap: 6px;">
                        <span>🔥</span> 인기 상품 TOP 10
                    </h3>
                    <span style="font-size: 11px; padding: 4px 8px; background: rgba(99,102,241,0.1); color: #6366f1; border-radius: 12px; font-weight: 700;">결제수량 기준</span>
                </div>
                <table class="trend-table">
                    <thead>
                    <tr>
                        <th style="width: 50px; text-align: center;">순위</th>
                        <th>상품 정보</th>
                        <th style="width: 130px;">판매량 분석</th>
                        <th style="text-align: right;">총 매출액</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(int i=0; i<hotProducts.length; i++) {
                        String[] prod = hotProducts[i];
                        int percent = (int)((double)Integer.parseInt(prod[2].replace(",", "")) / maxSales * 100);
                        String rankBg = (i < 3) ? "background: #ef4444; color: #fff;" : "background: #e2e8f0; color: #475569;";
                    %>
                    <tr>
                        <td style="text-align: center;">
                            <span class="rank-badge" style="<%= rankBg %>"><%= i + 1 %></span>
                        </td>
                        <td>
                            <div style="font-weight: 600;"><%= prod[1] %></div>
                            <div style="font-size: 11px; color: #94a3b8;"><%= prod[0] %></div>
                        </td>
                        <td>
                            <div style="font-size: 12px; font-weight: 700;"><%= prod[2] %> 건</div>
                            <div class="bar-container">
                                <div style="width: <%= percent %>%; height: 100%; background: linear-gradient(90deg, #f59e0b, #ef4444); border-radius: 3px;"></div>
                            </div>
                        </td>
                        <td style="text-align: right; font-weight: 700; color: #10b981;"><%= prod[3] %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="trend-panel">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
                    <h3 style="font-size: 18px; font-weight: 800; display: flex; align-items: center; gap: 6px;">
                        <span>❤️</span> 찜 목록 TOP 10
                    </h3>
                    <span style="font-size: 11px; padding: 4px 8px; background: rgba(239,68,68,0.1); color: #ef4444; border-radius: 12px; font-weight: 700;">위시리스트 기준</span>
                </div>
                <table class="trend-table">
                    <thead>
                    <tr>
                        <th style="width: 50px; text-align: center;">순위</th>
                        <th>상품 정보</th>
                        <th style="width: 130px;">관심도 수치</th>
                        <th style="width: 80px; text-align: center;">상태</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(int i=0; i<wishProducts.length; i++) {
                        String[] prod = wishProducts[i];
                        int percent = (int)((double)Integer.parseInt(prod[2].replace(",", "")) / maxWish * 100);
                        String rankBg = (i < 3) ? "background: #ff6b6b; color: #fff;" : "background: #e2e8f0; color: #475569;";

                        String chipStyle = "background: #ecfdf5; color: #047857;";
                        if(prod[4].equals("재고부족")) chipStyle = "background: #fef3c7; color: #92400e;";
                        if(prod[4].equals("품절")) chipStyle = "background: #fee2e2; color: #b91c1c;";
                    %>
                    <tr>
                        <td style="text-align: center;">
                            <span class="rank-badge" style="<%= rankBg %>"><%= i + 1 %></span>
                        </td>
                        <td>
                            <div style="font-weight: 600;"><%= prod[1] %></div>
                            <div style="font-size: 11px; color: #94a3b8;"><%= prod[3] %></div>
                        </td>
                        <td>
                            <div style="font-size: 12px; font-weight: 700; color: #ef4444;"><%= prod[2] %> 개</div>
                            <div class="bar-container">
                                <div style="width: <%= percent %>%; height: 100%; background: linear-gradient(90deg, #f472b6, #ff6b6b); border-radius: 3px;"></div>
                            </div>
                        </td>
                        <td style="text-align: center;">
                            <span class="status-chip" style="<%= chipStyle %>"><%= prod[4] %></span>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
<% } %>

<section id="about" class="admin-about">
    <div class="container">
        <div class="section-title">
            <span class="eyebrow">ABOUT</span>
            <h2>SHOPMALL 관리자 시스템이란?</h2>
            <p>쇼핑몰 운영자가 사용하는 전용 백오피스(Back-office)로,<br>
                일반 고객용 쇼핑몰과 분리된 안전한 환경에서 운영됩니다.</p>
        </div>
        <div class="about-grid">
            <div class="about-item">
                <div class="about-icon">🔒</div>
                <h3>안전한 접근 통제</h3>
                <p>관리자 계정으로만 로그인할 수 있으며, 세션·쿠키 기반의 안전한 인증을 통해 정보를 보호합니다.</p>
            </div>
            <div class="about-item">
                <div class="about-icon">⚡</div>
                <h3>빠른 운영 처리</h3>
                <p>상품 등록, 주문 처리, 회원 관리 등 반복 업무를 빠르고 간편하게 처리할 수 있도록 설계되었습니다.</p>
            </div>
            <div class="about-item">
                <div class="about-icon">📊</div>
                <h3>한눈에 보는 데이터</h3>
                <p>매출, 방문자, 재고 등 핵심 지표를 대시보드에서 한번에 확인하고 의사결정에 활용할 수 있습니다.</p>
            </div>
        </div>
    </div>
</section>

<section id="features" class="admin-features">
    <div class="container">
        <div class="section-title">
            <span class="eyebrow">FEATURES</span>
            <h2>주요 기능</h2>
            <p>관리자 페이지에서 사용하실 수 있는 주요 기능들입니다.</p>
        </div>
        <div class="feature-grid">
            <div class="feature-card">
                <span class="feature-num">01</span>
                <h3>상품 관리</h3>
                <p>상품 등록 · 수정 · 삭제, 카테고리 관리, 재고 현황을 관리합니다.</p>
            </div>
            <div class="feature-card">
                <span class="feature-num">02</span>
                <h3>주문 관리</h3>
                <p>접수된 주문 확인, 배송 상태 변경, 취소 · 반품 처리를 수행합니다.</p>
            </div>
            <div class="feature-card">
                <span class="feature-num">03</span>
                <h3>회원 관리</h3>
                <p>가입 회원 조회, 등급 변경, 적립금 지급 등 회원 관련 업무를 처리합니다.</p>
            </div>
            <div class="feature-card">
                <span class="feature-num">04</span>
                <h3>매출 통계</h3>
                <p>일별 · 월별 매출, 인기 상품, 회원 활동 등의 통계를 확인합니다.</p>
            </div>
            <div class="feature-card">
                <span class="feature-num">05</span>
                <h3>프로모션</h3>
                <p>쿠폰 발행, 할인 이벤트, 기획전 등 마케팅 활동을 운영합니다.</p>
            </div>
            <div class="feature-card">
                <span class="feature-num">06</span>
                <h3>관리자 계정</h3>
                <p>관리자 추가, 권한 설정, 접속 로그 등 시스템 운영을 관리합니다.</p>
            </div>
        </div>
    </div>
</section>

<section id="login-guide" class="login-guide">
    <div class="container">
        <div class="section-title">
            <span class="eyebrow">HOW TO LOGIN</span>
            <h2>로그인 진행 방법</h2>
            <p>다음 절차에 따라 관리자 페이지에 로그인하실 수 있습니다.</p>
        </div>
        <div class="step-list">
            <div class="step">
                <div class="step-no">STEP 1</div>
                <h3>로그인 페이지 이동</h3>
                <p>상단 우측의 <em>로그인</em> 버튼 또는 아래 <em>관리자 로그인</em> 버튼을 클릭하여 로그인 페이지로 이동합니다.</p>
            </div>
            <div class="step">
                <div class="step-no">STEP 2</div>
                <h3>아이디 / 비밀번호 입력</h3>
                <p>발급받은 관리자 아이디와 비밀번호를 정확히 입력합니다. <em>아이디 저장</em>을 체크하면 다음 접속 시 아이디가 자동 입력됩니다.</p>
            </div>
            <div class="step">
                <div class="step-no">STEP 3</div>
                <h3>인증 및 세션 생성</h3>
                <p>입력한 정보가 일치하면 서버가 관리자 세션을 생성하고, 이후의 요청을 인증된 사용자로 처리합니다.</p>
            </div>
            <div class="step">
                <div class="step-no">STEP 4</div>
                <h3>관리자 메인 진입</h3>
                <p>로그인에 성공하면 자동으로 관리자 대시보드로 이동하며, 좌측 메뉴를 통해 각 기능을 이용하실 수 있습니다.</p>
            </div>
        </div>

        <div class="login-notice">
            <h4>⚠ 로그인 안내 사항</h4>
            <ul>
                <li>관리자 아이디는 일반 회원과 별도로 발급되며, 시스템 관리자에게 문의하셔야 합니다.</li>
                <li>비밀번호는 영문 · 숫자 · 특수문자를 조합하여 8자 이상으로 설정하는 것을 권장합니다.</li>
                <li>비밀번호 5회 이상 오류 입력 시, 일정 시간 동안 접속이 제한될 수 있습니다.</li>
                <li>공용 PC에서는 보안을 위해 <em>아이디 저장</em>을 사용하지 마시고, 사용 후 반드시 로그아웃하시기 바랍니다.</li>
            </ul>
        </div>

        <div class="login-cta">
            <h3>지금 바로 시작하세요</h3>
            <p>관리자 계정으로 로그인하시면 모든 기능을 이용하실 수 있습니다.</p>
            <% if (isLoggedIn) { %>
            <a href="/dashboard/index.jsp" class="btn-primary large">대시보드로 이동 →</a>
            <% } else { %>
            <a href="/auth/adminLogin.jsp" class="btn-primary large">관리자 로그인 →</a>
            <% } %>
        </div>
    </div>
</section>

<footer class="admin-footer">
    <div class="container footer-grid">
        <div>
            <h4>SHOPMALL ADMIN</h4>
            <p>쇼핑몰 운영자를 위한 통합 백오피스 시스템</p>
            <p class="footer-contact">관리자 문의: admin@shopmall.example.com</p>
        </div>
        <div>
            <h4>바로가기</h4>
            <ul>
                <li><a href="#about">시스템 소개</a></li>
                <li><a href="#features">주요 기능</a></li>
                <li><a href="#login-guide">로그인 안내</a></li>
            </ul>
        </div>
        <div>
            <h4>계정</h4>
            <ul>
                <li><a href="/auth/adminLogin.jsp">관리자 로그인</a></li>
                <li><a href="/adminUser/register.jsp">관리자 등록</a></li>
            </ul>
        </div>
        <div>
            <h4>보안</h4>
            <ul>
                <li>SSL 암호화 통신</li>
                <li>세션 기반 인증</li>
                <li>접속 로그 기록</li>
            </ul>
        </div>
    </div>
    <div class="footer-bottom">© 2026 SHOPMALL ADMIN. All rights reserved.</div>
</footer>

<script>
    const darkModeBtn = document.getElementById('darkModeBtn');
    const body = document.body;

    // 로컬 스토리지에 테마 저장되어 있으면 적용
    if (localStorage.getItem('theme') === 'dark') {
        body.classList.add('dark-mode');
        darkModeBtn.innerText = '☀️ 라이트모드';
    }

    darkModeBtn.addEventListener('click', () => {
        body.classList.toggle('dark-mode');

        if (body.classList.contains('dark-mode')) {
            localStorage.setItem('theme', 'dark');
            darkModeBtn.innerText = '☀️ 라이트모드';
        } else {
            localStorage.setItem('theme', 'light');
            darkModeBtn.innerText = '🌙 다크모드';
        }
    });
</script>
</body>
</html>