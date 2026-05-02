<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouvelle consultation - MediCare</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; }
        .main-content { margin-left: 280px; padding: 20px; min-height: 100vh; }
        .card { background: white; border-radius: 15px; padding: 30px; max-width: 600px; margin: 0 auto; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card h1 { color: #2a5298; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        input, select, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px; }
        textarea { min-height: 80px; resize: vertical; }
        .btn-submit { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 12px; border: none; border-radius: 8px; width: 100%; cursor: pointer; font-size: 16px; }
        @media (max-width: 768px) { .main-content { margin-left: 70px; } }
    </style>
</head>
<body>
<jsp:include page="/layout/sidebar.jsp" />

<div class="main-content">
    <div class="card">
        <h1>Nouvelle consultation</h1>
        <form action="${pageContext.request.contextPath}/consultations/add" method="post">
            <div class="form-group">
                <label>Patient *</label>
                <select name="patientId" required>
                    <option value="">Sélectionner un patient</option>
                    <c:forEach var="patient" items="${patients}">
                        <option value="${patient.patientId}">${patient.firstName} ${patient.lastName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>Médecin *</label>
                <select name="doctor" required>
                    <option value="">Sélectionner un médecin</option>
                    <option value="Dr. Martin Bernard">Dr. Martin Bernard</option>
                    <option value="Dr. Sophie Laurent">Dr. Sophie Laurent</option>
                    <option value="Dr. Pierre Dubois">Dr. Pierre Dubois</option>
                </select>
            </div>
            <div class="form-group">
                <label>Diagnostic</label>
                <textarea name="diagnostic" placeholder="Description du diagnostic..."></textarea>
            </div>
            <div class="form-group">
                <label>Traitement prescrit</label>
                <textarea name="treatment" placeholder="Traitement recommandé..."></textarea>
            </div>
            <div class="form-group">
                <label>Date de consultation *</label>
                <input type="date" name="consultDate" required>
            </div>
            <div class="form-group">
                <label>Statut</label>
                <select name="status">
                    <option value="Planifié">Planifié</option>
                    <option value="En cours">En cours</option>
                    <option value="Terminé">Terminé</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Enregistrer la consultation</button>
        </form>
    </div>
</div>
</body>
</html>