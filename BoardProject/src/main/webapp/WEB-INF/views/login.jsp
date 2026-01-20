<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>Login | Storm BaseballBoard</title>

    <!-- SB Admin CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
</head>

<body class="login-bg">

<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">

                        <div class="card shadow-lg border-0 rounded-lg mt-5">

                            <!-- HEADER -->
                            <div class="card-header">
                                <h3 class="text-center my-4 fw-bold">
                                    ⚾ Storm BaseballBoard
                                </h3>
                            </div>

                            <!-- BODY -->
                            <div class="card-body">

                                <!-- 로그인 실패 알림 -->
                                <c:if test="${param.error != null}">
                                    <div class="alert alert-danger text-center">
                                        아이디 또는 비밀번호가 올바르지 않습니다.
                                    </div>
                                </c:if>

                                <!-- 로그인 FORM -->
                                <form action="${pageContext.request.contextPath}/loginDo" method="post">

                                    <!-- CSRF -->
                                    <input type="hidden"
                                           name="${_csrf.parameterName}"
                                           value="${_csrf.token}" />

                                    <div class="form-floating mb-3">
                                        <input class="form-control"
                                               id="userId"
                                               type="text"
                                               name="userId"
                                               placeholder="아이디"
                                               required />
                                        <label for="userId">아이디</label>
                                    </div>

                                    <div class="form-floating mb-3">
                                        <input class="form-control"
                                               id="password"
                                               type="password"
                                               name="password"
                                               placeholder="비밀번호"
                                               required />
                                        <label for="password">비밀번호</label>
                                    </div>

                                    <div class="d-flex align-items-center justify-content-between mt-4 mb-0">

                                        <!-- 로그인 버튼 -->
                                        <button type="submit" class="btn btn-primary">
                                            로그인
                                        </button>
                                    </div>

                                </form>
                            </div>

                            <!-- FOOTER -->
                            <div class="card-footer text-center py-3">
                                <div class="small">
                                    계정이 없으신가요?
                                    <!-- 회원가입 버튼 -->
                                    <a href="${pageContext.request.contextPath}/user/join" class="btn btn-outline-secondary btn-sm">
                                        회원가입
                                    </a>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </main>
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

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>

</body>
</html>
