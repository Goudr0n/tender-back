<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        #header {
            display: flex;
            justify-content: space-around;
            align-items: center;
            /*border-bottom: 2px solid grey;*/
            min-height: 150px;
            background-color: white;
        }

        #header-right {
            display: flex;
            flex-direction: column;
            justify-content: space-around;
            align-items: end;
        }

        .header-center {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 45px;
            width: 800px;
        }

        .header-right-info {
            font-family: Arial, Helvetica, sans-serif;
            margin: 10px;
            text-align: right;
            max-width: 350px;
        }

        #header-gradient {
            height: 20px;
            background-image: linear-gradient(to bottom, rgb(150, 150, 150, 0.8), rgba(150, 150, 150, 0));
        }

        .user-info {
            font-weight: bold;
            font-size: 20px;
        }
    </style>
</head>
<body>
<div id="header">
    <img src="<c:url value="/resources/logo.jpg"/>" alt="Logo" style="height: 150px">
    <p class="header-center">Система создания и поиска тендеров</p>
    <div id="header-right">
        <div class="header-right-info user-info">${currentUser.description}</div>
        <a href="/tender-app" class="header-right-info">Выйти</a>
    </div>
</div>
<div id="header-gradient"></div>
<br>
</body>
</html>
