<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - MediCare</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }

        /* Contenu principal */
        .main-content {
            margin-left: 280px;
            padding: 20px;
        }

        /* Cartes de statistiques */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card .icon {
            font-size: 40px;
            margin-bottom: 15px;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
            color: #2a5298;
            margin-bottom: 5px;
        }

        .stat-card .label {
            color: #666;
            font-size: 14px;
        }

        /* Tableau des patients */
        .section-title {
            margin: 30px 0 20px;
            color: #333;
        }

        .patient-table {
            background: white;
            border-radius: 15px;
            overflow-x: auto;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #2a5298;
            color: white;
            padding: 15px;
            text-align: left;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f8f9fa;
        }

        .priority-high {
            color: #e74c3c;
            font-weight: bold;
        }

        .priority-medium {
            color: #f39c12;
            font-weight: bold;
        }

        .priority-normal {
            color: #27ae60;
        }

        .top-bar {
            background: white;
            padding: 20px 30px;
            margin-bottom: 30px;
            border-radius: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar h1 {
            color: #333;
            margin: 0;
        }

        .counter-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 70px;
            }
        }
    </style>
</head>
<body>
<!-- Inclure la sidebar -->
<jsp:include page="/layout/sidebar.jsp" />

<div class="main-content">
    <!-- En-tête -->
    <div class="top-bar">
        <h1>Tableau de bord médical</h1>
        <div class="counter-badge">
            📊 Patients: ${totalPatients}
        </div>
    </div>

    <!-- Statistiques -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="icon">👥</div>
            <div class="number">${totalPatients}</div>
            <div class="label">Patients enregistrés</div>
        </div>
        <div class="stat-card">
            <div class="icon">📋</div>
            <div class="number">${totalConsultations}</div>
            <div class="label">Consultations totales</div>
        </div>
        <div class="stat-card">
            <div class="icon">🔬</div>
            <div class="number">${analysisCount}</div>
            <div class="label">Analyses EJB</div>
        </div>
    </div>

    <!-- Analyse des patients -->
    <h2 class="section-title">🏥 Analyse médicale des patients</h2>
    <div class="patient-table">
        <table>
            <thead>
            <tr>
                <th>Patient</th>
                <th>Âge</th>
                <th>Groupe sanguin</th>
                <th>Consultations</th>
                <th>Priorité</th>
                <th>Recommandation</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="patient" items="${patients}">
                <tr>
                    <td>${patient.firstName} ${patient.lastName}</td>
                    <td>${patient.age} ans</td>
                    <td>${patient.bloodType}</td>
                    <td>${patient.consultationCount}</td>
                    <td class="priority-${patient.priorityClass}">${patient.priority}</td>
                    <td>${patient.recommendation}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>