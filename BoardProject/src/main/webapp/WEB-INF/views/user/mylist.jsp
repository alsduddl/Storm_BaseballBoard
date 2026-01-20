<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 쓴 게시글 | Storm BaseballBoard</title>
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
</head>
<body class="login-bg d-flex flex-column min-vh-100">

<div class="container mt-5 flex-grow-1">
    <div class="row justify-content-center mt-5">
        <div class="col-lg-9 col-md-10">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-dark text-white text-center">
                    <h3 class="card-header">내가 쓴 게시글</h3>
                </div>
                <div class="card-body">
                    <table class="table table-bordered mt-2">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>좋아요 수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="post" items="${postList}">
                                <tr>
                                    <td>${post.postListSn}</td>
                                    <td><a href="/spring/post/detail?postId=${post.postId}">${post.title}</a></td>
                                    <td>${post.userId}</td>
                                    <td><fmt:formatDate value="${post.contentDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>${post.likeCount}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty postList}">
                                <tr><td colspan="5">게시글이 없습니다.</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/user/mypage" class="btn btn-outline-secondary btn-center">
                            마이페이지로 돌아가기
                        </a>
                    </div>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
