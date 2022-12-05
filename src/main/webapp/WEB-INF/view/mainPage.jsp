<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Агрегатор тендеров</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/main.css"/>"/>
    <style>
        body {
            max-width: 1800px;
            padding-bottom: 50px;
        }

        #open-tender-btn {
            background-color: #356492;
            color: white;
            padding: 20px 30px;
            display: block;
            margin: 40px auto;
            border: none;
            width: 500px;
            font-size: 30px;
        }

        .actions-table-form {
            margin-bottom: 0;
        }

        .actions-table-div {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .open-tender-btn {
            background-color: #F86123;
            color: white;
            border: none;
            font-size: 15px;
            padding: 5px;
            margin: 2px 0;
            cursor: pointer;
        }

        #tenders-table {
            margin: auto;
            width: 1500px;
        }

        #tenders-table, td, th {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 20px;
            border: 3px solid grey;
            border-collapse: collapse;
            text-align: center;
            padding: 10px;
        }

        #tenders-table-header {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 35px;
            display: block;
            text-align: center;
            margin: 50px auto 20px;
        }

        tr {
            background-color: white;
        }

        tr th {
            background-color: #356492;
            color: white;
        }

        td {
            height: 100px;
            cursor: pointer;
            transition: background-color 0.6s ease;
        }

        tr:hover {
            background-color: #e3e3e3 !important;
        }
    </style>
</head>
<body>
<c:import url="globalHeader.jsp"/>

<form:form action="/tender-app/main/createStart"
           method="post"
           modelAttribute="requestInfo">
    <form:hidden path="currentUserLogin"
                 value="${currentUser.login}"/>
    <button type="submit" id="open-tender-btn">Объявить новый тендер</button>
</form:form>

<div id="tenders-table-header">Объявленные тендеры</div>
<table id="tenders-table">
    <thead>
    <tr>
        <th>Заказчик</th>
        <th>Наименование</th>
        <th>Срок действия</th>
        <th>Начальная стоимость</th>
        <th>Текущая стоимость</th>
        <th>Текущий исполнитель</th>
        <th>Статус</th>
        <th>Действия</th>
    </tr>
    </thead>
    <c:forEach items="${tenders}" var="tender">
        <tr class="tender-row"
            style="background-color:${tender.status.value == 'Отменён' or tender.status.value == 'Закрыт' ? 'rgba(255, 0, 0, 0.1)' : 'white'}">
            <td>${tender.owner.description}</td>
            <td>${tender.name}</td>
            <td style="white-space: nowrap">${tender.date}</td>
            <td>${tender.startingPrice} BYN</td>
            <td><c:choose>
                <c:when test="${tender.currentPrice != 0}">${tender.currentPrice} BYN</c:when>
                <c:otherwise>Отсутствует</c:otherwise>
            </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${tender.executant != null}">${tender.executant.description}</c:when>
                    <c:otherwise>Отсутствует</c:otherwise>
                </c:choose>
            </td>
            <td>${tender.status.value}</td>
            <td>
                <form:form action="/tender-app/tender/open"
                           method="post"
                           modelAttribute="requestInfo"
                           cssClass="actions-table-form">
                    <form:hidden path="currentUserLogin" value="${currentUser.login}"/>
                    <form:hidden path="tenderId" value="${tender.id}"/>
                    <div class="actions-table-div">
                        <button class="open-tender-btn" type="submit">Просмотр</button>
                    </div>
                </form:form>
            </td>
        </tr>
    </c:forEach>
</table>
</div>

</body>
</html>