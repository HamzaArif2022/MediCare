<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier un patient - MediCare</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f5f7fa; }
        .main-content { margin-left: 280px; padding: 20px; min-height: 100vh; }
        .card { background: white; border-radius: 15px; padding: 30px; max-width: 600px; margin: 0 auto; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card h1 { color: #2a5298; margin-bottom: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #333; font-weight: 500; }
        input, select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 8px; font-size: 14px; }
        .btn-submit { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 12px; border: none; border-radius: 8px; width: 100%; cursor: pointer; font-size: 16px; }
        .btn-back { background: #95a5a6; color: white; padding: 10px 20px; text-decoration: none; border-radius: 8px; display: inline-block; margin-bottom: 20px; }
        @media (max-width: 768px) { .main-content { margin-left: 70px; } }
    </style>
</head>
<body>
<jsp:include page="/layout/sidebar.jsp" />

<div class="main-content">
    <div class="card">
        <h1>✏ Modifier un patient</h1>
        <form action="${pageContext.request.contextPath}/patients/update" method="post">
            <input type="hidden" name="patientId" value="${patient.patientId}">
            <div class="form-group">
                <label>Prénom</label>
                <input type="text" name="firstName" value="${patient.firstName}" required>
            </div>
            <div class="form-group">
                <label>Nom</label>
                <input type="text" name="lastName" value="${patient.lastName}" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="${patient.email}" required>
            </div>
            <div class="form-group">
                <label>Téléphone</label>
                <input type="tel" name="phone" value="${patient.phone}" required>
            </div>
            <div class="form-group">
                <label>Date de naissance</label>
                <input type="date" name="birthDate" value="${patient.birthDate}">
            </div>
            <div class="form-group">
                <label>Groupe sanguin</label>
                <select name="bloodType">
                    <option value="">Sélectionner</option>
                    <option value="A+" ${patient.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                    <option value="A-" ${patient.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                    <option value="B+" ${patient.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                    <option value="B-" ${patient.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                    <option value="AB+" ${patient.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                    <option value="AB-" ${patient.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                    <option value="O+" ${patient.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                    <option value="O-" ${patient.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Mettre à jour</button>
        </form>
        <div style="margin-top: 20px; text-align: center;">
            <a href="${pageContext.request.contextPath}/patients/" class="btn-back">← Retour à la liste</a>
        </div>
    </div>
</div>
</body>
</html>