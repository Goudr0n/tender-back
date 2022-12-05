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
            padding-bottom: 50px;
        }

        #tender-params-div {
            margin: auto;
            width: 1200px;
            padding: 70px 70px 50px;
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
            margin: 20px 0;
            padding-bottom: 7px;
            border-bottom: 2px solid #F86123;
        }

        label {
            width: 230px;
            text-align: end;
        }

        .info-value {
            width: 930px;
            text-align: start;
        }

        #new-price-btn {
            background-color: #356492;
            color: white;
            padding: 20px 25px;
            display: block;
            margin: 30px auto 0;
            border: none;
            cursor: pointer;
            width: 500px;
            font-size: 30px;
        }

        #cancel-tender-btn {
            background-color: darkred;
            color: white;
            padding: 20px 25px;
            display: block;
            margin: 30px auto 0;
            border: none;
            cursor: pointer;
            width: 500px;
            font-size: 30px;
        }

        .new-price-form {
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        #new-price-form * {
            font-size: 30px;
        }

        .new-price-text {
            font-size: 30px;
            margin: auto 15px;
        }

        #new-price-input {
            width: 200px
        }

        #price-updated-notification {
            font-size: 40px;
            color: darkgreen;
            text-align: center;
            margin-bottom: 30px;
        }
        #text-header {
            font-size: 40px;
        }
    </style>
</head>
<body>
<c:import url="globalHeader.jsp"/>

<div id="tender-params-div">
    <h1 id="text-header">Информация о тендере</h1>
    <div class="tender-params-row">
        <label>Статус:</label>
        <div class="info-value">${tender.status.value}</div>
    </div>
    <div class="tender-params-row">
        <label>Заказчик:</label>
        <div class="info-value">${tender.owner.description}</div>
    </div>
    <div class="tender-params-row">
        <label>Наименование:</label>
        <div class="info-value">${tender.name}</div>
    </div>
    <div class="tender-params-row">
        <label>Описание:</label>
        <div class="info-value">${tender.description}</div>
    </div>
    <div class="tender-params-row">
        <label>Срок действия:</label>
        <div class="info-value">${tender.date}</div>
    </div>
    <div class="tender-params-row">
        <label>Начальная стоимость:</label>
        <div class="info-value">${tender.startingPrice} BYN</div>
    </div>
    <div class="tender-params-row">
        <label>Текущая стоимость:</label>
        <div class="info-value">${tender.currentPrice} BYN</div>
    </div>
    <div class="tender-params-row">
        <label>Текущий исполнитель:</label>
        <div class="info-value">
            <c:choose>
                <c:when test="${tender.executant != null}">${tender.executant.description}</c:when>
                <c:otherwise>Отсутствует</c:otherwise>
            </c:choose>
        </div>
    </div>
    <br>
    <hr>
    <br>

    <c:if test="${not currentUserIsOwner and tender.status.value == 'Открыт'}">
        <c:if test="${isPriceUpdated}">
            <div id="price-updated-notification">Цена успешно обновлена</div>
        </c:if>

        <form:form action="/tender-app/tender/bid" modelAttribute="requestInfo" method="post">
            <form:hidden path="currentUserLogin" value="${user.login}"/>
            <form:hidden path="tenderId" value="${tender.id}"/>
            <div class="new-price-form">
                <p class="new-price-text">Новая цена: </p>
                <form:input path="newPrice"
                            type="number"
                            value="${tender.currentPrice - 1}"
                            min="1"
                            max="${tender.currentPrice - 1}"
                            id="new-price-input"/>
                <p class="new-price-text">BYN</p>
            </div>
            <input type="submit" id="new-price-btn" value="Предложить цену"/>
        </form:form>
    </c:if>
    <c:if test="${currentUserIsOwner and tender.status.value == 'Открыт'}">
        <form:form action="/tender-app/tender/cancel" modelAttribute="requestInfo" method="post">
            <form:hidden path="currentUserLogin" value="${user.login}"/>
            <form:hidden path="tenderId" value="${tender.id}"/>
            <input type="submit" id="cancel-tender-btn" value="Отменить тендер"/>
        </form:form>
    </c:if>


    <form:form action="/tender-app/tender/mainPage" modelAttribute="requestInfo" method="post">
        <form:hidden path="currentUserLogin" value="${currentUser.login}"/>
        <input type="submit" id="back-btn" value="Назад"/>
    </form:form>
</div>
</body>
</html>