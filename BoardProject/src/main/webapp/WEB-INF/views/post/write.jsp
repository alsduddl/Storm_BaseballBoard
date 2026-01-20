<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 작성 | Storm BaseballBoard</title>

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

    <div class="row justify-content-center mb-4">
        <div class="col-lg-8 col-md-10 mt-5">
            <h1 class="fs-3">
                게시글 작성
            </h1>
        </div>
    </div>

    <!-- 게시글 작성 -->
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card mb-5">
                <div class="card-body">

                    <form action="${pageContext.request.contextPath}/post/write" method="post" onsubmit="return validateForm();">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <!-- 제목 -->
                        <div class="mb-3">
                            <label class="form-label">제목</label>
                            <input type="text" name="title" class="form-control" required>
                        </div>

                        <!-- 좌석 정보 -->
                        <div id="seatArea" class="mb-3">
                            <label class="form-label">좌석 정보</label>
                            <input type="text" name="seatInfo" class="form-control" placeholder="예: 응원단석">
                        </div>

                        <!-- 응원 분위기 점수 -->
                        <div id="seatArea" class="mb-4">
                            <label class="form-label d-block">좌석 응원 분위기</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="cheerScore" value="5">
                                <label class="form-check-label">5점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="cheerScore" value="4">
                                <label class="form-check-label">4점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="cheerScore" value="3">
                                <label class="form-check-label">3점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="cheerScore" value="2">
                                <label class="form-check-label">2점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="cheerScore" value="1">
                                <label class="form-check-label">1점</label>
                            </div>
                        </div>

                        <!-- 좌석 만족도 점수 -->
                        <div id="seatArea" class="mb-4">
                            <label class="form-label d-block">좌석 만족도</label>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="satisfactionScore" value="5">
                                <label class="form-check-label">5점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="satisfactionScore" value="4">
                                <label class="form-check-label">4점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="satisfactionScore" value="3">
                                <label class="form-check-label">3점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="satisfactionScore" value="2">
                                <label class="form-check-label">2점</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="satisfactionScore" value="1">
                                <label class="form-check-label">1점</label>
                            </div>
                        </div>
                        
                        <!-- 내용 -->
                        <div class="mb-4">
                            <label class="form-label">내용</label>
                            <textarea name="content" rows="15" class="form-control" required></textarea>
                        </div>

                        <!-- 버튼 -->
                        <div class="d-flex justify-content-center gap-3">
                            <button type="submit" class="btn btn-primary">
                                등록
                            </button>
                            <a href="${pageContext.request.contextPath}/"
                               class="btn btn-outline-secondary">
                                취소
                            </a>
                        </div>

                    </form>
                    <sec:authorize access="hasRole('ADMIN')">
				    <script>
				        const isAdmin = true;
				    </script>
				</sec:authorize>
				
				<sec:authorize access="!hasRole('ADMIN')">
				    <script>
				        const isAdmin = false;
				    </script>
				</sec:authorize>
				<script>
					function validateForm() {
					    // 관리자는 점수 선택 안 해도 됨
					    if (isAdmin) {
					        return true;
					    }
					
					    // 회원만 검사
					    const cheer = document.querySelector('input[name="cheerScore"]:checked');
					    const satis = document.querySelector('input[name="satisfactionScore"]:checked');
					
					    if (!cheer || !satis) {
					        alert('좌석 응원 분위기와 좌석 만족도를 모두 선택해주세요.');
					        return false;
					    }
					    return true;
					}
				</script>
				<script>
					document.addEventListener("DOMContentLoaded", function () {
					    const noticeCheckbox = document.getElementById("isNotice");
					    const seatArea = document.getElementById("seatArea");
					
					    if (!noticeCheckbox || !seatArea) return;
					
					    noticeCheckbox.addEventListener("change", function () {
					        if (this.checked) {
					            seatArea.style.display = "none";
					        } else {
					            seatArea.style.display = "block";
					        }
					    });
					});
					</script>
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
