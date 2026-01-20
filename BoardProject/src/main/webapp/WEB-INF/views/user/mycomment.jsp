<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 쓴 댓글 | Storm BaseballBoard</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
</head>
<body class="login-bg d-flex flex-column min-vh-100">

<div class="container mt-5 flex-grow-1">
    <div class="row justify-content-center mt-5">
        <div class="col-lg-9 col-md-10">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-dark text-white text-center">
                    <h3 class="card-header">내가 쓴 댓글</h3>
                </div>
                <div class="card-body">
                    <table class="table table-bordered mt-2">
                        <thead>
                            <tr>
                                <th>게시글</th>
                                <th>댓글 내용</th>
                                <th>작성일</th>
                                <th>삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="comment" items="${commentList}">
                                <tr id="comment-${comment.commentId}">
                                    <td><a href="/spring/post/detail?postId=${comment.postId}">${comment.postTitle}</a></td>
                                    <td>${comment.content}</td>
                                    <td><fmt:formatDate value="${comment.contentDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>
                                        <button class="btn-delete" onclick="deleteMyComment(${comment.commentId})">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty commentList}">
                                <tr>
                                    <td colspan="4">작성한 댓글이 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>

                    <!-- 버튼 가운데 정렬 -->
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
function deleteMyComment(commentId) {
    if(!confirm("댓글을 삭제하시겠습니까?")) return;

    $.ajax({
        url: "/spring/comment/delete",
        type: "post",
        data: { commentId: commentId },
        beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
        },
        success: function(result) {
            if(result === "success") {
                $("#comment-" + commentId).remove();
            }
        }
    });
}
</script>
</body>
</html>
