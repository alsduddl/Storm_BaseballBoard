<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>구역 추천 페이지 | Storm BaseballBoard</title>

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
</head>

<body class="sb-nav-fixed">

<!-- =================== NAVBAR =================== -->
<nav class="sb-topnav navbar navbar-expand navbar-dark">
    <a class="navbar-brand ps-3" href="${pageContext.request.contextPath}/">
        ⚾ Storm BaseballBoard
    </a>

    <ul class="navbar-nav ms-auto me-3">
        <sec:authorize access="isAnonymous()">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                    <i class="fas fa-sign-in-alt"></i> 로그인
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user fa-fw"></i>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <sec:authorize access="hasRole('USER')">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/mypage">
                            <i class="fas fa-user me-2"></i> 마이페이지
                        </a></li>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN')">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home">
                            <i class="fas fa-user-shield me-2"></i> 관리자 페이지
                        </a></li>
                    </sec:authorize>
                    <li><hr class="dropdown-divider"/></li>
                    <li>
                        <form action="${pageContext.request.contextPath}/logout" method="post" class="px-3">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button type="submit" class="btn btn-link dropdown-item">
                                <i class="fas fa-sign-out-alt me-2"></i> 로그아웃
                            </button>
                        </form>
                    </li>
                </ul>
            </li>
        </sec:authorize>
    </ul>
</nav>

<!-- =================== CONTENT =================== -->
<div id="layoutSidenav_content">
<main>
<div class="container-fluid px-4 pt-5">

    <!-- 페이지 제목 -->
    <div class="row justify-content-center mb-4">
        <div class="col-lg-8 col-md-10 mt-5">
            <h1 class="fs-3 mb-4">
                <i class="fas fa-thumbs-up me-2"></i> 구역 추천 페이지
            </h1>
        </div>
    </div>

    <!-- 응원 분위기 최고 구역 -->
    <div class="row justify-content-center mb-4">
        <div class="col-lg-8 col-md-10">
            <div class="card text-center">
                <div class="card-header">응원 분위기 최고 구역</div>
                <div class="card-body">
                    <h5 class="card-title">${bestCheer.seatInfo}</h5>
                    <p class="card-text">평균 점수: ${bestCheer.avgScore}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 좌석 만족도 최고 구역 -->
    <div class="row justify-content-center mb-4">
        <div class="col-lg-8 col-md-10">
            <div class="card text-center">
                <div class="card-header">좌석 만족도 최고 구역</div>
                <div class="card-body">
                    <h5 class="card-title">${bestSatisfaction.seatInfo}</h5>
                    <p class="card-text">평균 점수: ${bestSatisfaction.avgScore}</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 종합 점수 TOP3 -->
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card text-center">
                <div class="card-header">종합 점수 TOP3 구역</div>
                <div class="card-body">
                    <table id="datatablesSimple" class="table text-center align-middle">
                        <thead>
                        <tr>
                            <th>순위</th>
                            <th>제목</th>
                            <th>구역</th>
                            <th>평균 점수</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="post" items="${topPost}" varStatus="s">
                            <tr>
                                <td>${s.index + 1}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}">
                                        ${post.title}
                                    </a>
                                </td>
                                <td>${post.seatInfo}</td>
                                <td>${post.avgScore}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>
</main>
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
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatables-simple-demo.js"></script>

</body>
</html>
