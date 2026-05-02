<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historique des consultations - MediCare</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; }
        .main-content { margin-left: 280px; padding: 20px; min-height: 100vh; }
        .card { background: white; border-radius: 15px; padding: 25px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .patient-info { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px; border-radius: 15px; margin-bottom: 20px; }
        .stats { background: #f8f9fa; padding: 15px; border-radius: 10px; text-align: center; margin-bottom: 20px; }
        .stats span { font-size: 24px; font-weight: bold; color: #2a5298; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #2a5298; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        .status { display: inline-block; padding: 3px 10px; border-radius: 15px; font-size: 12px; font-weight: bold; }
        .status-terminé { background: #2ecc71; color: white; }
        .status-encours { background: #f39c12; color: white; }
        .status-planifié { background: #3498db; color: white; }
        @media (max-width: 768px) { .main-content { margin-left: 70px; } }
    </style>
</head>
<body>
<jsp:include page="/layout/sidebar.jsp" />

<div class="main-content">
    <div class="patient-info">
        <h2>${patient.firstName} ${patient.lastName}</h2>
        <p>📧 ${patient.email} | 📞 ${patient.phone} | 🩸 Groupe: ${patient.bloodType}</p>
    </div>

    <div class="stats">
        <p> Nombre total de consultations : <span>${consultationCount}</span></p>
    </div>

    <div class="card">
        <table>
            <thead>
            <tr><th>ID</th><th>Date</th><th>Médecin</th><th>Diagnostic</th><th>Traitement</th><th>Statut</th></tr>
            </thead>
            <tbody>
            <c:forEach var="consult" items="${consultations}">
                <tr>
                    <td>${consult.consultId}</td>
                    <td>${consult.consultDate}</td>
                    <td>${consult.doctor}</td>
                    <td>${consult.diagnostic}</td>
                    <td>${consult.treatment}</td>
                    <td><span class="status status-${consult.status.toLowerCase()}">${consult.status}</span></td>
                </tr>
            </c:forEach>
            <c:if test="${empty consultations}">
                <tr><td colspan="6" style="text-align: center;">Aucune consultation trouvée</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>