<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title>Авторизация</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/main.css"/>"/>
    <style>
        body {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            background: rgb(248, 97, 35);
            background: radial-gradient(circle, rgba(248, 97, 35, 1) 0%, rgba(53, 100, 146, 1) 100%);
        }

        #login-form {
            /*width: 600px;*/
            background-color: white;
            padding: 0 30px 50px;
            border: 2px solid rgba(248, 97, 35, 0.5);
            border-radius: 10px;
            -webkit-box-shadow: 0 0 40px 5px rgba(0, 0, 0, 0.2);
            -moz-box-shadow: 0 0 40px 5px rgba(0, 0, 0, 0.2);
            box-shadow: 0 0 40px 5px rgba(0, 0, 0, 0.2);
        }

        .authorization-field {
            width: 100%;
            padding: 12px 20px;
            margin: 5px 0 25px;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        #login-button {
            background-color: #F86123;
            color: white;
            padding: 15px 0;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            font-size: 20px;
        }

        #login-div {
            width: 350px;
            margin: auto
        }

        a {
            display: block;
            text-align: center;
        }

        .error-field-text {
            font-size: 15px;
            color: darkred;
        }
    </style>
</head>
<body>
<div id="login-form">
    <img id="tenderLogo" src="<c:url value="/resources/logo.jpg"/>" alt="Logo" style="width: 600px">

    <h1 id="text-header">Вход в систему:</h1>
    <div id="login-div">
        <form:form action="/tender-app/authorization/login" modelAttribute="currentUser" method="post">
            <label><b>Логин</b></label>
            <c:if test="${loginError eq true}">
                <div class="error-field-text">Неверное имя пользователя или пароль</div>
            </c:if>
            <c:if test="${loginErrorUnknown eq true}">
                <div class="error-field-text">Неизвестная ошибка приложения</div>
            </c:if>
            <form:input path="login"
                        class="authorization-field"
                        placeholder="Введите логин"
                        required="required"/>
            <label><b>Пароль</b></label>
            <form:password path="password"
                           class="authorization-field"
                           placeholder="Введите пароль"
                           required="required"/>

            <input type="submit" id="login-button" class="authorization-field" value="Войти"/>
            <a href="/tender-app/registerStart">Зарегистрироваться</a>
        </form:form>
    </div>
</div>
</body>
</html>
