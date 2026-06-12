<%@ page import="kr.ac.dy.cs.util.CookieUtils" %>
<%@ page import="kr.ac.dy.cs.member.MemberRegisterForm" %>
<%@ page import="kr.ac.dy.cs.member.MemberService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인 처리</title>
</head>
<body>
<%
    String loginId = request.getParameter("loginId");
    String password = request.getParameter("password");
    String saveIdYn = request.getParameter("saveIdYn");

    MemberService memberService = new MemberService();
    boolean loginYn = memberService.isLogin(loginId, password);

    if (loginYn) {
        session.setAttribute("loginId", loginId);
    }

    //아이디저장확인
    //쿠키를 초기화
    CookieUtils.removeSaveId(response);
    if (loginYn && "1".equals(saveIdYn)) {
        CookieUtils.addSaveId(response, loginId);
    }
%>

<% if (loginYn) {%>
    <%
        response.sendRedirect("/");
    %>
<% } else {%>
    <p>로그인에 실패하였습니다.</p>
    <div>
        <a href="login.jsp">다시 시도</a>
    </div>
<%} %>

</body>
</html>
