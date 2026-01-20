<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 상세 정보 | Storm BaseballBoard</title>

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
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user fa-fw"></i>
                </a>

                <ul class="dropdown-menu dropdown-menu-end">
                    <sec:authorize access="hasRole('USER')">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/user/mypage">
                                <i class="fas fa-user me-2"></i> 마이페이지
                            </a>
                        </li>
                    </sec:authorize>

                    <sec:authorize access="hasRole('ADMIN')">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/home">
                                <i class="fas fa-user-shield me-2"></i> 관리자 페이지
                            </a>
                        </li>
                    </sec:authorize>

                    <li><hr class="dropdown-divider"></li>

                    <li>
                        <form action="${pageContext.request.contextPath}/logout" method="post" class="px-3">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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


<div id="layoutSidenav_content">

<!-- =================== MAIN =================== -->
<main>
    <div class="container-fluid px-4 pt-5">

        <!-- 작성한 게시글 -->
        <div class="row justify-content-center mb-5">
            <div class="col-lg-10 col-md-11 mt-5">
                <div class="card">
                    <div class="card-header">작성한 게시글</div>
                    <div class="card-body">

                        <c:if test="${empty postList}">
                            <p class="text-center text-muted mb-0">작성한 게시글이 없습니다.</p>
                        </c:if>

                        <c:if test="${not empty postList}">
                            <table class="table table-hover align-middle">
                                <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성일</th>
                                    <th class="text-center">관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="post" items="${postList}">
                                    <tr id="post-${post.postId}">
                                        <td>${post.postId}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/post/detail?postId=${post.postId}">
                                                ${post.title}
                                            </a>
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${post.contentDate}" pattern="yyyy-MM-dd"/>
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-danger"
                                                    onclick="deletePost(${post.postId})">
                                                삭제
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>

        <!-- 작성한 댓글 -->
        <div class="row justify-content-center mb-5">
            <div class="col-lg-10 col-md-11 mt-5">
                <div class="card">
                    <div class="card-header">작성한 댓글</div>
                    <div class="card-body">

                        <c:if test="${empty commentList}">
                            <p class="text-center text-muted mb-0">작성한 댓글이 없습니다.</p>
                        </c:if>

                        <c:if test="${not empty commentList}">
                            <table class="table table-hover align-middle">
                                <thead>
                                <tr>
                                    <th>게시글</th>
                                    <th>내용</th>
                                    <th>작성일</th>
                                    <th class="text-center">관리</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="comment" items="${commentList}">
                                    <tr id="comment-${comment.commentId}">
                                        <td>
                                            <a href="${pageContext.request.contextPath}/post/detail?postId=${comment.postId}">
                                                ${comment.postTitle}
                                            </a>
                                        </td>
                                        <td>${comment.content}</td>
                                        <td>
                                            <fmt:formatDate value="${comment.contentDate}" pattern="yyyy-MM-dd HH:mm"/>
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-danger"
                                                    onclick="deleteComment(${comment.commentId})">
                                                삭제
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>

        <!-- 목록 이동 -->
        <div class="row justify-content-center mb-5">
            <div class="col-lg-10 text-end">
                <a href="${pageContext.request.contextPath}/admin/userlist"
                   class="btn btn-outline-secondary btn-sm">
                    회원 목록으로
                </a>
            </div>
        </div>

    </div>
</main>

<!-- =================== FOOTER (항상 맨 밑) =================== -->
<footer class="py-4 bg-light mt-auto">
    <div class="container-fluid px-4">
        <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">© Storm BaseballBoard</div>
        </div>
    </div>
</footer>

</div>

<!-- =================== JS =================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
function deletePost(postId) {
    if (!confirm("이 게시글을 삭제하시겠습니까?")) return;

    $.ajax({
        url: "/spring/admin/post/delete",
        type: "post",
        data: { postId: postId },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
        },
        success: function(result) {
            if (result === "success") {
                $("#post-" + postId).remove();
            } else {
                alert("삭제 실패");
            }
        },
        error: function() {
            alert("서버 오류");
        }
    });
}

function deleteComment(commentId) {
    if (!confirm("이 댓글을 삭제하시겠습니까?")) return;

    $.ajax({
        url: "/spring/admin/comment/delete",
        type: "post",
        data: { commentId: commentId },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
        },
        success: function(result) {
            if (result === "success") {
                $("#comment-" + commentId).remove();
            } else {
                alert("삭제 실패");
            }
        },
        error: function() {
            alert("서버 오류");
        }
    });
}
</script>

</body>
</html>
