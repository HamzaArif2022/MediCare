<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getRequestURI();
    String contextPath = request.getContextPath();
%>
<style>
    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        width: 280px;
        background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
        color: white;
        box-shadow: 2px 0 10px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        z-index: 1000;
    }
    .sidebar-header {
        padding: 25px 20px;
        text-align: center;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        margin-bottom: 20px;
    }
    .sidebar-header h2 { font-size: 24px; margin: 0; color: white; }
    .sidebar-header p { font-size: 12px; margin: 5px 0 0; opacity: 0.8; }
    .nav-menu { list-style: none; padding: 0; margin: 0; }
    .nav-item { margin: 8px 15px; }
    .nav-link {
        display: flex;
        align-items: center;
        padding: 12px 20px;
        color: white;
        text-decoration: none;
        border-radius: 10px;
        transition: all 0.3s ease;
        gap: 12px;
    }
    .nav-link:hover { background: rgba(255,255,255,0.15); transform: translateX(5px); }
    .nav-link.active { background: rgba(255,255,255,0.25); box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
    .nav-icon { font-size: 20px; width: 30px; text-align: center; }
    .nav-text { font-size: 15px; font-weight: 500; }
    .sidebar-footer {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        padding: 20px;
        text-align: center;
        border-top: 1px solid rgba(255,255,255,0.1);
        font-size: 12px;
        opacity: 0.7;
    }
    /* Style du bouton de déconnexion */
    .logout-btn {
        display: inline-block;
        margin-top: 15px;
        padding: 8px 20px;
        background-color: white;
        color: #2a5298 !important;
        text-decoration: none;
        border-radius: 30px;
        font-weight: bold;
        font-size: 13px;
        transition: all 0.3s ease;
        border: 1px solid white;
    }
    .logout-btn:hover {
        background-color: rgba(255,255,255,0.9);
        transform: translateY(-2px);
        box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        color: #1e3c72 !important;
    }
    .main-content { margin-left: 280px; min-height: 100vh; background: #f5f7fa; padding: 20px; }
    @media (max-width: 768px) {
        .sidebar { width: 70px; }
        .sidebar-header h2, .sidebar-header p, .nav-text { display: none; }
        .main-content { margin-left: 70px; }
        .nav-link { justify-content: center; }
        .nav-icon { font-size: 24px; width: auto; }
        .logout-btn { padding: 6px 12px; font-size: 11px; }
    }
</style>

<div class="sidebar">
    <div class="sidebar-header">
        <h2>🏥 MediCare</h2>
        <p>Gestion Clinique</p>
    </div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="<%= contextPath %>/dashboard" class="nav-link <%= currentPage.contains("/dashboard") ? "active" : "" %>">
                <span class="nav-icon">📊</span>
                <span class="nav-text">Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%= contextPath %>/patients/" class="nav-link <%= currentPage.contains("/patients") ? "active" : "" %>">
                <span class="nav-icon">👥</span>
                <span class="nav-text">Gestion des patients</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="<%= contextPath %>/consultations/add" class="nav-link <%= currentPage.contains("/consultations") ? "active" : "" %>">
                <span class="nav-icon">📋</span>
                <span class="nav-text">Consultations</span>
            </a>
        </li>
    </ul>
    <div class="sidebar-footer">
        <p>© 2024 MediCare</p>
        <p>Version 1.0</p>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Déconnexion</a>
    </div>
</div>