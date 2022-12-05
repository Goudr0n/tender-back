<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Открытие тендера</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/main.css"/>"/>
    <style>
        * {
            font-size: 20px
        }

        body {
            max-width: 1800px;
        }

        #tender-params-div {
            margin: auto;
            width: 800px;
            padding: 50px;
            background-color: white;
            border: 2px solid rgba(248, 97, 35, 0.5);
            border-radius: 10px;
            -webkit-box-shadow: 15px 15px 40px 0px rgba(0, 0, 0, 0.3);
            -moz-box-shadow: 15px 15px 40px 0px rgba(0, 0, 0, 0.3);
            box-shadow: 15px 15px 40px 0px rgba(0, 0, 0, 0.3);
        }

        .tender-params-row {
            display: flex;
            justify-content: space-between;
            margin: 20px 10px;
            padding: 0 0 10px;
            border-bottom: 2px solid #F86123;
        }

        input, textarea {
            width: 400px;
        }

        textarea {
            resize: none;
        }

        input[type=date] {
            padding: 1px 2px;
        }

        #open-tender-btn {
            background-color: #356492;
            color: white;
            padding: 20px 30px;
            display: block;
            margin: 50px auto 0;
            border: none;
            cursor: pointer;
            width: 500px;
            font-size: 30px;
        }

        label {
            width: 340px;
            text-align: end;
        }
    </style>
</head>
<body>
<c:import url="globalHeader.jsp"/>

<div id="tender-params-div">
    <form:form action="/tender-app/tender/createFinish" modelAttribute="tender" method="post" id="tender-params-form">

        <h1 id="text-header">Заполните необходимую информацию о Вашем тендере</h1>
        <div class="tender-params-row">
            <label for="tender-name">Наименование тендера</label>
            <form:input path="name"
                        id="tender-name"
                        type="text"
                        required="required"
                        placeholder="Введите наименование тендера"
                        maxlength="255"/>
        </div>
        <div class="tender-params-row">
            <label for="tender-description">Описание</label>
            <form:textarea path="description"
                           id="tender-description"
                           rows="4"
                           cols="25"
                           placeholder="Введите подробное описание тендера"
                           maxlength="10000"
                           required="required"/>
        </div>
        <div class="tender-params-row">
            <label for="tender-price">Начальная стоимость (BYN)</label>
            <form:input path="startingPrice"
                        id="tender-price"
                        type="number"
                        min="1"
                        max="1000000000"/>
        </div>
        <div class="tender-params-row">
            <label for="tender-date">Срок действия</label>
            <form:input path="date"
                        id="tender-date"
                        type="date"
                        required="required"/>
        </div>
        <input type="hidden" name="currentUserLogin" value="${currentUser.login}">

        <input type="submit" id="open-tender-btn" value="Объявить тендер">
    </form:form>

    <form:form action="/tender-app/tender/mainPage" modelAttribute="requestInfo" method="post">
        <form:hidden path="currentUserLogin" value="${currentUser.login}"/>
        <input type="submit" id="back-btn" value="Назад"/>
    </form:form>
</div>

<script>
    document.getElementById('tender-date').min = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000).toISOString().split("T")[0];
</script>
</body>
</html>