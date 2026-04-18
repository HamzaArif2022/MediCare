<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .top-bar {
        background: white;
        padding: 15px 30px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }

    .page-title {
        font-size: 24px;
        color: #333;
        margin: 0;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .counter-badge {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        font-size: 14px;
    }
</style>

<div class="top-bar">
    <h1 class="page-title">
        <%
            String title = "Dashboard";
            String uri = request.getRequestURI();
            if (uri.contains("/patients")) title = "Gestion des patients";
            else if (uri.contains("/consultations")) title = "Consultations médicales";
            else if (uri.contains("/dashboard")) title = "Tableau de bord";
            out.print(title);
        %>
    </h1>
    <div class="user-info">
        <div class="counter-badge">
            📊 Patients: ${totalPatients}
        </div>
    </div>
</div>