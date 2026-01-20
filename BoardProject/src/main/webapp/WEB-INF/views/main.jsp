<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>Storm BaseballBoard</title>

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
    <div class="position-relative mb-5" style="height: 400px; width: 100%;">
        
        <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;
                    background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                                      url('${pageContext.request.contextPath}/resources/assets/img/tim-gouw-VvQSzMJ_h0U-unsplash (1).jpg');
                    background-size: cover;
                    background-position: center;
                    z-index: 1;">
        </div>

        <div class="position-absolute top-50 start-50 translate-middle w-100" style="z-index: 2;">
            <div class="d-flex flex-column align-items-center">
                
                <form class="w-25 mb-4" style="min-width: 350px;" 
                      action="${pageContext.request.contextPath}/post/search" method="get">
                    <div class="input-group">
                        <input class="form-control" type="text" name="keyword" 
                               value="${keyword}" placeholder="구역 / 좌석 검색" />
                        <button class="btn btn-primary">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>

                <div class="d-flex justify-content-center mt-4">
                    <a href="${pageContext.request.contextPath}/recommend" class="btn btn-primary">
                        구역 추천 페이지
                    </a>
                </div>
                
            </div>
        </div>
    </div>
    
	<div class="container-fluid px-4">
	
    <!-- 최신 게시글 --> 
    <div class="row justify-content-center">
    <div class="col-lg-10 col-md-11">
    <h1 class="fs-3 mb-4">
        <i class="fas fa-baseball-ball me-2"></i> 최신 게시글
    </h1>

    <div class="card mb-5">
        <div class="card-header">
            최신 게시글
        </div>
        
        <div class="card-body">
			<table class="table text-center align-middle">
			    <thead>
			        <tr>
			            <th>번호</th>
			            <th>제목</th>
			            <th>작성자</th>
			            <th>좋아요</th>
			        </tr>
			    </thead>
			    <tbody>
                <c:forEach var="post" items="${mainPostList}" varStatus="status">
			    <tr>
			        <td>${status.index + 1}</td>
			        <td>
			            <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}">
			                <c:if test="${post.isNotice == 'Y'}">
			                    <span class="badge bg-danger me-1">[공지]</span>
			                </c:if>
			                ${post.title}
			            </a>
			        </td>
			        <td>${post.userId}</td>
			        <td>
			        <c:if test="${post.isNotice != 'Y'}">
			            ♥ ${post.likeCount}
			        </c:if>
			        </td>
			    </tr>
			</c:forEach>
			    </tbody>
			</table>
			
            <div class="d-flex justify-content-between mt-3">
                <a href="${pageContext.request.contextPath}/post/list"
                   class="btn btn-outline-secondary">
                    게시글 더 보기
                </a>

                <sec:authorize access="isAuthenticated()">
                    <a href="${pageContext.request.contextPath}/post/write"
                       class="btn btn-primary">
                        게시글 작성
                    </a>
                </sec:authorize>

                <sec:authorize access="isAnonymous()">
                    <button class="btn btn-primary"
                            onclick="alert('로그인이 필요합니다.');
                            location.href='${pageContext.request.contextPath}/login';">
                        게시글 작성
                    </button>
                </sec:authorize>
            </div>
        </div>
    </div>
    </div>
    </div>

    <!-- 좋아요 TOP5 -->   
    <div class="row justify-content-center">
    <div class="col-lg-10 col-md-11">
    <h1 class="fs-3 mb-4">
        <i class="fas fa-baseball-ball me-2"></i> 좋아요 TOP5
    </h1>

    <div class="card mb-5">
        <div class="card-header">
            인기 게시글
        </div>
        <div class="card-body">
			<table class="table text-center align-middle">
			    <thead>
			        <tr>
			            <th>번호</th>
			            <th>제목</th>
			            <th>작성자</th>
			            <th>좋아요</th>
			        </tr>
			    </thead>
			    <tbody>
			        <c:forEach var="post" items="${topLikePost}">
                                <tr>
                                    <td>${post.postListSn}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}">
                                            ${post.title}
                                        </a>
                                    </td>
                                    <td>${post.userId}</td>
                                    <td>♥ ${post.likeCount}</td>
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

</body>
</html>
