<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>게시글 목록 | Storm BaseballBoard</title>

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

    <!-- 페이지 제목 + 버튼 -->
    <div class="row justify-content-center mb-4">
        <div class="col-lg-8 col-md-10 mt-5 d-flex justify-content-between align-items-center">
            <h1 class="fs-3">
                <i class="fas fa-list me-2"></i> 게시글 목록
            </h1>

            <div class="d-flex gap-2">
                <sec:authorize access="isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/post/write"
                       class="btn btn-primary btn-sm">
                        게시글 작성
                    </a>
                </sec:authorize>

                <sec:authorize access="isAnonymous()">
                    <button class="btn btn-primary btn-sm"
                            onclick="alert('로그인이 필요합니다.');
                            location.href='${pageContext.request.contextPath}/login';">
                        게시글 작성
                    </button>
                </sec:authorize>
            </div>
        </div>
    </div>

    <!-- 게시글 목록 -->
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card">
                <div class="card-header">
                    게시글 목록
                </div>

                <div class="card-body">
                    <table class="table text-center align-middle">
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>좋아요</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="post" items="${postList}" varStatus="status">
                        <tr>
                        	<td>
			                    ${status.index + 1}
			                    </td>
					        <td>
						    <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}">
			                        <c:if test="${post.userRole == 'ADMIN'}">
			                            <span class="badge bg-danger me-1">[공지]</span>
			                        </c:if>
			                        ${post.title}
			                    </a>
								</td>
                                <td>${post.userId}</td>
                                <td>
                                    <fmt:formatDate value="${post.contentDate}" pattern="yyyy-MM-dd"/>
                                </td>
                                <td>
                                <c:if test="${post.userRole == 'USER'}">
						            ♥ ${post.likeCount}
						        </c:if>
						        </td>
                        </c:forEach>

                        <c:if test="${empty postList}">
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">
                                    게시글이 없습니다.
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