<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 | Storm BaseballBoard</title>

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

        <!-- 제목 & 좋아요 -->
        <div class="row justify-content-center mb-4 mt-5">
            <div class="col-lg-8 col-md-10 mt-5">
                <h1 class="fs-3 fw-bold">${post.title}</h1>

                <div class="mt-2">
                    <sec:authorize access="isAuthenticated()">
						        <button id="likeBtn" class="btn btn-outline-danger btn-sm" data-postid="${post.postId}">♥</button>
						        <span id="likeBtn-${post.postId}" class="ms-2">${post.likeCount}</span>
                    </sec:authorize>

                    <sec:authorize access="isAnonymous()">
                        <button class="btn btn-outline-danger btn-sm"
                                onclick="alert('로그인이 필요합니다.')">♥</button> ${post.likeCount} 
                    </sec:authorize>
                </div>
            </div>
        </div>

        <!-- 게시글 정보 카드 -->
        <div class="row justify-content-center mb-4">
            <div class="col-lg-8 col-md-10">
                <div class="card">
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th class="w-25">작성자</th>
                                <td>${post.userId}</td>
                            </tr>
                            <tr>
                                <th>작성일</th>
                                <td><fmt:formatDate value="${post.contentDate}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                            <c:if test="${post.isNotice eq 'N'}">
                                <tr>
                                    <th>좌석 정보</th>
                                    <td>${post.seatInfo}</td>
                                </tr>
                                <tr>
                                    <th>응원 분위기</th>
                                    <td>${post.cheerScore}점</td>
                                </tr>
                                <tr>
                                    <th>좌석 만족도</th>
                                    <td>${post.satisfactionScore}점</td>
                                </tr>
                            </c:if>
                            <tr>
                                <th>내용</th>
                                <td style="white-space: pre-wrap;">${post.content}</td>
                            </tr>
                        </table>

                        <!-- 수정 / 삭제 버튼 -->
                        <c:if test="${not empty loginUserId and (loginUserId eq post.userId or fn:contains(pageContext.request.userPrincipal.authorities, 'ROLE_ADMIN'))}">
					    <div class="d-flex gap-2">
					        <a href="${pageContext.request.contextPath}/post/update?postId=${post.postId}" class="btn btn-sm btn-outline-secondary">수정</a>
					        <form action="${pageContext.request.contextPath}/post/delete" method="post">
					            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					            <input type="hidden" name="postId" value="${post.postId}">
					            <button class="btn btn-sm btn-outline-navy" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
					        </form>
					    </div>
					</c:if>

                    </div>
                </div>
            </div>
        </div>

        <!-- 댓글 카드 -->
        <div class="row justify-content-center mb-5">
            <div class="col-lg-8 col-md-10">
                <div class="card">
                    <div class="card-header">댓글</div>
                    <div class="card-body">

                        <!-- 댓글 입력 -->
                        <sec:authorize access="isAuthenticated()">
                            <textarea id="commentContent" class="form-control mb-2" rows="2" placeholder="댓글을 입력하세요"></textarea>
                            <button id="commentBtn" class="btn btn-primary btn-sm">등록</button>
                            <input type="hidden" id="postId" value="${post.postId}">
                        </sec:authorize>
                        <sec:authorize access="isAnonymous()">
                            <p class="text-muted">댓글을 작성하려면 로그인이 필요합니다.</p>
                        </sec:authorize>

                        <hr>

                        <!-- 댓글 리스트 -->
                        <div id="commentArea">
                            <c:forEach var="comment" items="${commentList}">
                                <c:if test="${comment.parentCommentId == null}">
                                    <div class="card mb-3" id="comment-${comment.commentId}">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <strong>${comment.userId}</strong>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${comment.contentDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                </small>
                                            </div>
                                            <p class="mb-2 content-area"><span class="content">${comment.content}</span></p>

                                            <!-- 작성자 버튼 -->
                                            <c:if test="${not empty loginUserId and comment.userId eq loginUserId}">
                                                <div class="mb-2 btn-area">
                                                    <button class="btn btn-sm btn-outline-secondary" onclick="commentEdit(${comment.commentId})">수정</button>
                                                    <button class="btn btn-sm btn-outline-navy" onclick="deleteComment(${comment.commentId})">삭제</button>
                                                </div>
                                            </c:if>

                                            <!-- 답글 -->
                                            <sec:authorize access="isAuthenticated()">
                                                <button class="btn btn-sm btn-outline-secondary" onclick="toggleReplyForm(${comment.commentId})">답글쓰기</button>
                                                <div id="reply-form-${comment.commentId}" class="mt-2" style="display:none;">
                                                    <textarea id="reply-content-${comment.commentId}" class="form-control mb-2" rows="2" placeholder="답글을 입력하세요"></textarea>
                                                    <button class="btn btn-sm btn-primary" onclick="writeReply(${comment.commentId})">등록</button>
                                                </div>
                                            </sec:authorize>

                                            <!-- 대댓글 리스트 -->
                                            <div class="mt-3 ms-4">
                                                <c:forEach var="reply" items="${commentList}">
                                                    <c:if test="${reply.parentCommentId == comment.commentId}">
                                                        <div class="border-start ps-3 mb-2" id="comment-${reply.commentId}">
                                                            <div class="d-flex justify-content-between">
                                                                <strong>${reply.userId}</strong>
                                                                <small class="text-muted">
                                                                    <fmt:formatDate value="${reply.contentDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                                </small>
                                                            </div>
                                                            <div class="content-area mt-1">
                                                                <span class="content">${reply.content}</span>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>

                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</main>
</div>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/datatables-simple-demo.js"></script>

<script>
const loginUserId = "${loginUserId}";
$(document).ready(function() {
	//좋아요 버튼
	$("#likeBtn").on("click", function() {
		const postId = $(this).data("postid");
	    const $count = $("#likeBtn-" + postId);
		$.ajax({
			url: "${pageContext.request.contextPath}/like/toggle",
			type: "post",
			data: {postId: postId},
			beforeSend: function(xhr) {
				xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
				},
			success: function(count) {
				$count.text(count);
			}
		});
	});
	
	//댓글 등록 버튼
	$("#commentBtn").on("click", function() {
		let content = $("#commentContent").val();
		if(content.trim() === "") {
			alert("댓글을 입력하세요.")
			return;
		}
		
		$.ajax({
			url: "/spring/comment/write",
			type: "post",
			data: {
				postId: ${post.postId},
				content: content
				},
			beforeSend: function(xhr) {
				xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
				},
				success: function(comment) {
				    let html =
				    '<div class="card mb-3" id="comment-' + comment.commentId + '">' +
				    '  <div class="card-body">' +
				    '    <div class="d-flex justify-content-between align-items-center mb-2">' +
				    '      <strong>' + comment.userId + '</strong>' +
				    '      <small class="text-muted">' + formatDate(comment.contentDate) + '</small>' +
				    '    </div>' +
				    '    <p class="mb-2 content-area">' +
				    '      <span class="content">' + comment.content + '</span>' +
				    '    </p>' +
				    '    <div class="mb-2 btn-area">' +
				    '      <button class="btn btn-sm btn-outline-secondary" onclick="commentEdit(' + comment.commentId + ')">수정</button>' +
				    '      <button class="btn btn-sm btn-outline-navy" onclick="deleteComment(' + comment.commentId + ')">삭제</button>' +
				    '    </div>' +
				    '  </div>' +
				    '</div>';

				    $("#commentArea").append(html);
				    $("#commentContent").val("");
				},
	        error: function() {
	            alert("댓글 등록 실패");
	        }
		});
	});
	
});

//대댓글
function toggleReplyForm(id) {
  $("#reply-form-" + id).toggle();
}

//대댓글 등록
function writeReply(parentId) {
  let content = $("#reply-content-" + parentId).val();
  if(content.trim() === "") {
    alert("대댓글 입력");
    return;
  }

  $.ajax({
    url: "/spring/comment/write",
    type: "post",
    data: {
      postId: $("#postId").val(),
      content: content,
      parentCommentId: parentId
    },
    beforeSend: function(xhr) {
    	xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
    },
    success: function() { 
    	location.reload();
    	}   
  });
}

//댓글 삭제
function deleteComment(commentId) {
    if(!confirm("삭제하시겠습니까?")) 
    	return;

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

//댓글 수정
function commentEdit(commentId) {
    const $comment = $("#comment-" + commentId);
    const content = $comment.find(".content").text();

    $comment.data("originalContent", $comment.find(".content-area").html());

    $comment.find(".content-area").html(
        '<textarea id="edit-' + commentId + '" class="form-control mb-2" rows="2">' + content + '</textarea>' +
        '<div class="edit-btn-area">' +
        '<button class="btn btn-sm btn-outline-secondary" onclick="updateComment(' + commentId + ')">수정완료</button>' +
        '<button class="btn btn-sm btn-outline-navy" onclick="cancelEdit(' + commentId + ')"> 취소</button>' +
        '</div>'
    );

    $comment.find(".btn-area").hide();
}

//댓글 수정 취소
function cancelEdit(commentId) {
    const $comment = $("#comment-" + commentId);

    $comment.find(".content-area").html(
        $comment.data("originalContent")
    );

    $comment.find(".btn-area").show();
}

//댓글 수정 완료
function updateComment(commentId) {
    const content = $("#edit-" + commentId).val();

    if (content.trim() === "") {
        alert("내용을 입력하세요.");
        return;
    }

    $.ajax({
        url: "/spring/comment/update",
        type: "post",
        contentType: "application/json",
        data: JSON.stringify({ 
        	commentId : commentId,
        	content : content 
        	}),
        beforeSend: function(xhr) {
            xhr.setRequestHeader("X-CSRF-TOKEN", "${_csrf.token}");
        },
        success: function(updatedComment) {
            const $comment = $("#comment-" + commentId);

            $comment.find(".content-area").empty().append(
                    $("<span>").addClass("content").text(updatedComment.content)
                    );
            $comment.find(".time").text(
                formatDate(updatedComment.contentDate)
            );
            $comment.find(".btn-area").show();
        },
        error: function() {
            alert("댓글 수정 실패");
        }
    });
}

//댓글 날짜
function formatDate(dateValue) {
    if (!dateValue) return "";

    let d;

    if (typeof dateValue === "number") {
        d = new Date(dateValue);
    }
    else if (typeof dateValue === "string") {
        d = new Date(dateValue.replace(" ", "T"));
    }
    else if (dateValue instanceof Date) {
        d = dateValue;
    }
    else {
        return "";
    }

    const yyyy = d.getFullYear();
    const MM = String(d.getMonth() + 1).padStart(2, '0');
    const dd = String(d.getDate()).padStart(2, '0');
    const HH = String(d.getHours()).padStart(2, '0');
    const mm = String(d.getMinutes()).padStart(2, '0');
    const ss = String(d.getSeconds()).padStart(2, '0');

    return yyyy + "/" + MM + "/" + dd + " " + HH + ":" + mm + ":" + ss;
}

</script>
<!-- FOOTER -->
<footer class="mt-auto py-4 bg-light">
    <div class="container-fluid px-4">
        <div class="d-flex align-items-center justify-content-between small">
            <div class="text-muted">© Storm BaseballBoard</div>
        </div>
    </div>
</footer>

</body>
</html>