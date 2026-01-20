<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>관리자 페이지 | Storm BaseballBoard</title>

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

<!-- =================== CONTENT =================== -->
<div id="layoutSidenav_content">
<main>
<div class="container-fluid px-4 pt-5">

    <!-- 제목 -->
    <div class="row justify-content-center mb-4">
        <div class="col-lg-10 col-md-11 mt-5">
            <h1 class="fs-3 fw-bold">회원 관리</h1>
        </div>
    </div>

    <!-- 회원 목록 카드 -->
    <div class="row justify-content-center mb-5">
        <div class="col-lg-10 col-md-11">
            <div class="card">
                <div class="card-header">
                    회원 목록
                </div>

                <div class="card-body">
                    <table class="table table-hover align-middle">
                        <thead>
                        <tr>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>닉네임</th>
                            <th class="text-center">관리</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr id="user-${user.userId}">
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/user/detail?userId=${user.userId}">
                                        ${user.userId}
                                    </a>
                                </td>
                                <td>${user.userName}</td>
                                <td>${user.email}</td>
                                <td>${user.phoneNumber}</td>
                                <td>${user.nickname}</td>
                                <td class="text-center">
						        <c:if test="${user.role ne 'ADMIN'}">
						        <form action="${pageContext.request.contextPath}/admin/userlist/delete"
						              method="post"
						              class="d-inline">
						            <input type="hidden"
						                   name="${_csrf.parameterName}"
						                   value="${_csrf.token}">
						            <input type="hidden"
						                   name="userId"
						                   value="${user.userId}">
						            <button type="submit"
						                    class="btn btn-sm btn-delete"
						                    onclick="return confirm('정말 삭제하시겠습니까?');">
						                삭제
						            </button>
						        </form>
						    </c:if>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty userList}">
                            <tr>
                                <td colspan="6"
                                    class="text-center text-muted py-4">
                                    회원이 없습니다.
                                </td>
                            </tr>
                        </c:if>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
