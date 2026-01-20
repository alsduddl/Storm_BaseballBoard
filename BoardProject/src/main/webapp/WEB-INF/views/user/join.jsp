<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 | Storm BaseballBoard</title>
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
</head>
<body class="login-bg">

<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-8">
                        <div class="card shadow-lg border-0 rounded-lg mt-4 mb-4">
                            <div class="card-header">
                                <h3 class="text-center font-weight-light my-4">회원가입</h3>
                            </div>
                            <div class="card-body">
                                <form:form action="${pageContext.request.contextPath}/user/join" method="post" modelAttribute="user" onsubmit="return beforeSubmit()">
                                    
                                    <!-- 아이디 -->
                                    <div class="form-floating mb-3">
                                        <form:input path="userId" cssClass="form-control" id="userId" placeholder="아이디"/>
                                        <label for="userId">아이디</label>
                                        <form:errors path="userId" cssClass="text-danger"/>
                                        <button id="userIdCheck" type="button" class="btn btn-outline-secondary btn-sm mt-1">아이디 중복체크</button>
                                    </div>

                                    <!-- 비밀번호 -->
                                    <div class="form-floating mb-3">
                                        <form:input path="password" cssClass="form-control" id="password" type="password" placeholder="비밀번호"/>
                                        <label for="password">비밀번호</label>
                                        <form:errors path="password" cssClass="text-danger"/>
                                    </div>

                                    <!-- 이름 -->
                                    <div class="form-floating mb-3">
                                        <form:input path="userName" cssClass="form-control" id="userName" placeholder="이름"/>
                                        <label for="userName">이름</label>
                                        <form:errors path="userName" cssClass="text-danger"/>
                                    </div>

                                    <!-- 이메일 -->
                                    <div class="form-floating mb-3">
                                        <form:input path="email" cssClass="form-control" id="email" placeholder="이메일"/>
                                        <label for="email">이메일</label>
                                        <form:errors path="email" cssClass="text-danger"/>
                                    </div>

                                    <!-- 전화번호 -->
                                    <div class="form-floating mb-3">
                                        <form:input path="phoneNumber" cssClass="form-control" id="phoneNumber" placeholder="전화번호"/>
                                        <label for="phoneNumber">전화번호</label>
                                        <form:errors path="phoneNumber" cssClass="text-danger"/>
                                    </div>

                                    <!-- 닉네임 -->
                                    <div class="form-floating mb-3">
                                        <form:input path="nickname" cssClass="form-control" id="nickname" placeholder="닉네임"/>
                                        <label for="nickname">닉네임</label>
                                        <form:errors path="nickname" cssClass="text-danger"/>
                                        <button id="nicknameCheck" type="button" class="btn btn-outline-secondary btn-sm mt-1">닉네임 중복체크</button>
                                    </div>

                                    <div class="d-grid mt-4 mb-0">
                                        <button type="submit" class="btn btn-primary btn-block">회원가입</button>
                                    </div>
                                </form:form>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small">
                                    이미 계정이 있으신가요?
                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary btn-sm">로그인</a>
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

<script>
let IdCheck = false;
let nickCheck = false;

// 정규식 체크
function validateUserId(userId){
    const regex = /^[a-zA-Z0-9]{4,20}$/;
    return regex.test(userId);
}
function validateNickname(nickname){
    const regex = /^[a-zA-Z0-9가-힣]{2,12}$/;
    return regex.test(nickname);
}

$(document).ready(function() {
    const token = $("meta[name='_csrf']").attr("content");
    const header = $("meta[name='_csrf_header']").attr("content");

    if (token && header) {
        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(header, token);
            }
        });
    }

    // 아이디 중복 체크
    $("#userIdCheck").on("click", function() {
        let userId = $("#userId").val();

        if (!validateUserId(userId)) {
            alert("아이디는 4~20자의 영문 또는 숫자 조합이어야 합니다.");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/user/userIdCheck",
            type: "post",
            data: { userId: userId },
            success: function(result) {
                if (result > 0) {
                    alert("아이디가 중복됩니다.");
                } else {
                    alert("사용 가능한 아이디입니다.");
                    $("#userId").attr("readonly", true);
                    $("#userIdCheck").remove();
                    IdCheck = true;
                }
            },
            error: function() {
                alert("아이디 중복 검사 중 오류가 발생하였습니다.");
            }
        });
    });

    // 닉네임 중복 체크
    $("#nicknameCheck").on("click", function() {
        let nickname = $("#nickname").val();

        if (!validateNickname(nickname)) {
            alert("닉네임은 2~12자의 한글, 영문 또는 숫자만 가능합니다.");
            return;
        }

        $.ajax({
            url: "${pageContext.request.contextPath}/user/nicknameCheck",
            type: "post",
            data: { nickname: nickname },
            success: function(result) {
                if (result > 0) {
                    alert("닉네임이 중복됩니다.");
                } else {
                    alert("사용 가능한 닉네임입니다.");
                    $("#nickname").attr("readonly", true);
                    $("#nicknameCheck").remove();
                    nickCheck = true;
                }
            },
            error: function() {
                alert("닉네임 중복 검사 중 오류가 발생하였습니다.");
            }
        });
    });

    // 입력 변경 시 중복 상태 초기화
    $("#userId").on("input", function(){
        IdCheck = false;
        $("#userIdCheck").prop("disabled", false);
    });
    $("#nickname").on("change keydown paste", function(){
        nickCheck = false;
        $("#nicknameCheck").prop("disabled", false);
    });
});

function beforeSubmit(){
    if(!IdCheck) {
        alert("아이디 중복검사를 진행해 주세요.");
        return false;
    }
    if(!nickCheck) {
        alert("닉네임 중복검사를 진행해 주세요.");
        return false;
    }
    return true;
}
</script>

</body>
</html>
