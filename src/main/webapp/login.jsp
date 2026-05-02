<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - MediCare</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            overflow: hidden;
        }

        /* Conteneur principal : deux colonnes */
        .login-wrapper {
            display: flex;
            width: 100%;
            height: 100%;
        }

        /* PARTIE GAUCHE - FORMULAIRE */
        .form-section {
            flex: 1;
            background: white;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        .login-container {
            width: 100%;
            max-width: 450px;
        }

        .logo {
            text-align: center;
            font-size: 64px;
            margin-bottom: 20px;
        }

        h1 {
            text-align: center;
            color: #2a5298;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 14px 12px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 15px;
            transition: border 0.3s;
        }

        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        button {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .error {
            color: #e74c3c;
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            background: #fdeaea;
            padding: 10px;
            border-radius: 8px;
        }

        /* PARTIE DROITE - IMAGE */
        .image-section {
            flex: 1;
            background: url('${pageContext.request.contextPath}/images/doctor.jpg') no-repeat center center;
            background-size: cover;
            position: relative;
        }

        /* Overlay subtil pour rendre le texte lisible si besoin */
        .image-section::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.1);
        }

        /* Responsive : sur mobile, l'image passe en dessous */
        @media (max-width: 768px) {
            .login-wrapper {
                flex-direction: column;
            }
            .image-section {
                min-height: 200px;
            }
        }
    </style>
</head>
<body>
<div class="login-wrapper">
    <!-- Section formulaire (gauche) -->
    <div class="form-section">
        <div class="login-container">
            <div class="logo">🏥</div>
            <h1>MediCare</h1>
            <p style="text-align: center; margin-bottom: 25px; color: #666;">Connexion à votre espace</p>
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label>Email professionnel</label>
                    <input type="email" name="email" placeholder="admin@medicare.com" required>
                </div>
                <div class="form-group">
                    <label>Mot de passe</label>
                    <input type="password" name="password" placeholder="••••••" required>
                </div>
                <button type="submit">Se connecter</button>
                <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
                <% } %>
            </form>
            <p style="text-align: center; margin-top: 25px; font-size: 12px; color: #999;">© 2026    MediCare - Tous droits réservés</p>
        </div>
    </div>

    <!-- Section image (droite) -->
    <div class="image-section">
        <!-- L'image doctor.jpg sera affichée en background -->
    </div>
</div>
</body>
</html>