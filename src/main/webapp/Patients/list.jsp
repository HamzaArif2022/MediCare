<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des patients - MediCare</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; }
        .main-content { margin-left: 280px; padding: 20px; min-height: 100vh; }
        .card { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .header-card { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .header-card h1 { color: #2a5298; }
        .btn-add { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; }
        .search-box { background: #f8f9fa; border-radius: 10px; padding: 20px; margin-bottom: 20px; }
        .search-form { display: flex; gap: 10px; }
        .search-form input { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 8px; }
        .search-form button { background: #2a5298; color: white; padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; }
        .btn-clear { background: #95a5a6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #2a5298; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        tr:hover { background: #f8f9fa; }
        .btn-edit { background: #f39c12; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none; margin: 0 2px; display: inline-block; }
        .btn-delete { background: #e74c3c; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none; margin: 0 2px; display: inline-block; }
        .btn-view { background: #3498db; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none; margin: 0 2px; display: inline-block; }
        .counter { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 10px; border-radius: 10px; text-align: center; margin-bottom: 20px; }
        @media (max-width: 768px) { .main-content { margin-left: 70px; } }
    </style>
</head>
<body>
<jsp:include page="/layout/sidebar.jsp" />

<div class="main-content">
    <div class="counter">Patients enregistrés : ${totalPatients}</div>

    <div class="card">
        <div class="header-card">
            <h1>Liste des patients</h1>
            <a href="${pageContext.request.contextPath}/patients/add" class="btn-add">Nouveau patient</a>
        </div>

        <div class="search-box">
            <form action="${pageContext.request.contextPath}/patients/search" method="get" class="search-form">
                <input type="text" name="keyword" placeholder="Rechercher par nom ou email..." value="${searchKeyword}">
                <button type="submit">Rechercher</button>
                <c:if test="${not empty searchKeyword}">
                    <a href="${pageContext.request.contextPath}/patients/" class="btn-clear">✖ Effacer</a>
                </c:if>
            </form>
        </div>

        <table>
            <thead>
            <tr><th>ID</th><th>Nom complet</th><th>Email</th><th>Téléphone</th><th>Date naissance</th><th>Âge</th><th>Groupe</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <c:forEach var="patient" items="${patients}">
                <tr>
                    <td>${patient.patientId}</td>
                    <td>${patient.firstName} ${patient.lastName}</td>
                    <td>${patient.email}</td>
                    <td>${patient.phone}</td>
                    <td>${patient.birthDate}</td>
                    <td>${requestScope['age_' . patient.patientId]} ans</td>
                    <td>${patient.bloodType}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/patients/edit?id=${patient.patientId}" class="btn-edit">✏ Modifier</a>
                        <a href="${pageContext.request.contextPath}/patients/delete?id=${patient.patientId}" onclick="return confirm('Confirmer ?')" class="btn-delete">🗑 Supprimer</a>
                        <a href="${pageContext.request.contextPath}/consultations/history?patientId=${patient.patientId}" class="btn-view">📋 Consultations</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty patients}">
                <tr><td colspan="8" style="text-align: center;">Aucun patient trouvé</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>