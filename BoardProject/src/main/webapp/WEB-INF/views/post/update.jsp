<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정 | Storm BaseballBoard</title>
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
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                   data-bs-toggle="dropdown">
                    <i class="fas fa-user fa-fw"></i>
                </a>

                <ul class="dropdown-menu dropdown-menu-end">
                    <sec:authorize access="hasRole('USER')">
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/user/mypage">
                                <i class="fas fa-user me-2"></i> 마이페이지
                            </a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasRole('ADMIN')">
                        <li>
                            <a class="dropdown-item"
                               href="${pageContext.request.contextPath}/admin/home">
                                <i class="fas fa-user-shield me-2"></i> 관리자 페이지
                            </a>
                        </li>
                    </sec:authorize>

                    <li><hr class="dropdown-divider"/></li>

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


<!-- =================== CONTENT =================== -->
<div id="layoutSidenav_content">
<main>
<div class="container-fluid px-4 pt-5">

    <div class="row justify-content-center mb-4">
        <div class="col-lg-8 col-md-10 mt-5">
            <h1 class="fs-3 fw-bold">게시글 수정</h1>
        </div>
    </div>

    <!-- 게시글 수정 -->
    <div class="row justify-content-center mb-5">
        <div class="col-lg-8 col-md-10">
            <div class="card">
                <div class="card-header">
                    게시글 수정
                </div>

                <div class="card-body">

                    <form action="${pageContext.request.contextPath}/post/update" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" name="postId" value="${post.postId}" />

                        <!-- 제목 -->
                        <div class="mb-3">
                            <label class="form-label fw-bold">제목</label>
                            <input type="text"
                                   name="title"
                                   class="form-control"
                                   value="${post.title}">
                        </div>

                        <!-- 좌석 정보 -->
                        <div id="seatArea" class="mb-3">
                            <label class="form-label fw-bold">좌석 정보</label>
                            <input type="text"
                                   name="seatInfo"
                                   class="form-control"
                                   value="${post.seatInfo}">
                        </div>

                        <!-- 응원 분위기 -->
                        <div id="seatArea" class="mb-4">
                            <label class="form-label fw-bold d-block">좌석 응원 분위기</label>

                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="i" begin="1" end="5">
                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="cheerScore"
                                               value="${i}"
                                               <c:if test="${post.cheerScore == i}">checked</c:if>>
                                        <label class="form-check-label">
                                            ${i}점
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- 좌석 만족도 -->
                        <div id="seatArea" class="mb-4">
                            <label class="form-label fw-bold d-block">좌석 만족도 점수</label>

                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="i" begin="1" end="5">
                                    <div class="form-check">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="satisfactionScore"
                                               value="${i}"
                                               <c:if test="${post.satisfactionScore == i}">checked</c:if>>
                                        <label class="form-check-label">
                                            ${i}점
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- 내용 -->
                        <div class="mb-4">
                            <label class="form-label fw-bold">내용</label>
                            <textarea name="content"
                                      class="form-control"
                                      rows="8">${post.content}</textarea>
                        </div>
                        <!-- 버튼 -->
                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-primary">
                                수정 완료
                            </button>

                            <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}"
                               class="btn btn-outline-navy">
                                취소
                            </a>
                        </div>

                    </form>

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
        <div class="text-muted small text-center">
            © Storm BaseballBoard
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const noticeCheckbox = document.getElementById("isNotice");
    const seatArea = document.getElementById("seatArea");

    if (!seatArea) return;

    //수정 페이지 최초 로딩 시
    if ("${post.isNotice}" === "Y") {
        seatArea.style.display = "none";
    }

    //공지 체크 변경 시
    if (noticeCheckbox) {
        noticeCheckbox.addEventListener("change", function () {
            if (this.checked) {
                seatArea.style.display = "none";
            } else {
                seatArea.style.display = "block";
            }
        });
    }
});
</script>

</body>
</html>
