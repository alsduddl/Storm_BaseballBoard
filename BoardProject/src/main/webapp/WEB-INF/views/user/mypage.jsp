<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>마이페이지 | Storm BaseballBoard</title>

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
</head>

<body class="sb-nav-fixed">

<!-- =================== NAVBAR =================== -->
<nav class="sb-topnav navbar navbar-expand navbar-dark">

    <a class="navbar-brand ps-3"
       href="${pageContext.request.contextPath}/">
        ⚾ Storm BaseballBoard
    </a>

    <!-- 오른쪽 영역 -->
    <ul class="navbar-nav ms-auto me-3">

        <!-- 비로그인 -->
        <sec:authorize access="isAnonymous()">
            <li class="nav-item">
                <a class="nav-link"
                   href="${pageContext.request.contextPath}/login">
                    <i class="fas fa-sign-in-alt"></i>
                     로그인
                </a>
            </li>
        </sec:authorize>

        <!-- 로그인 상태 -->
        <sec:authorize access="isAuthenticated()">
            <li class="nav-item dropdown">

                <a class="nav-link dropdown-toggle"
                   id="navbarDropdown"
                   href="#"
                   role="button"
                   data-bs-toggle="dropdown">
                    <i class="fas fa-user fa-fw"></i>
                </a>

                <ul class="dropdown-menu dropdown-menu-end">

                    <!-- 회원 -->
                    <sec:authorize access="hasRole('USER')">
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/user/mypage">
                                <i class="fas fa-user me-2"></i> 마이페이지
                            </a>
                        </li>
                    </sec:authorize>

                    <!-- 관리자 -->
                    <sec:authorize access="hasRole('ADMIN')">
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/admin/home">
                                <i class="fas fa-user-shield me-2"></i> 관리자 페이지
                            </a>
                        </li>
                    </sec:authorize>

                    <li><hr class="dropdown-divider"/></li>

                    <!-- 로그아웃 -->
                    <li>
                        <form action="${pageContext.request.contextPath}/logout"
                              method="post" class="px-3">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}" />
                            <button type="submit"
                                    class="btn btn-link dropdown-item">
                                <i class="fas fa-sign-out-alt me-2"></i> 로그아웃
                            </button>
                        </form>
                    </li>

                </ul>
            </li>
        </sec:authorize>

    </ul>
</nav>

<div class="container mt-5 flex-grow-1">
    <div class="row justify-content-center mt-5">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-dark text-white text-center">
                    <h3 class="card-header">마이페이지</h3>
                </div>
                <div class="card-body">
                    <table class="table table-bordered mb-3">
                        <tr><th>아이디</th><td>${user.userId}</td></tr>
                        <tr><th>이름</th><td>${user.userName}</td></tr>
                        <tr><th>이메일</th><td>${user.email}</td></tr>
                        <tr><th>전화번호</th><td>${user.phoneNumber}</td></tr>
                        <tr><th>닉네임</th><td>${user.nickname}</td></tr>
                    </table>
                    
                    <div class="d-flex flex-column align-items-start gap-2 mt-2">
                        <a href="${pageContext.request.contextPath}/user/mylist" class="btn btn-primary btn-compact">내가 쓴 게시글</a>
                        <a href="${pageContext.request.contextPath}/user/mycomment" class="btn btn-primary btn-compact">내가 쓴 댓글</a>
                    </div>
                </div>
                <div class="card-footer text-center py-2">
                    <a href="${pageContext.request.contextPath}/main" class="btn btn-outline-secondary btn-sm">Main Page</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer class="mt-auto py-4 bg-light">
    <div class="container-fluid px-4">
        <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">© Storm BaseballBoard</div>
        </div>
    </div>
</footer>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
