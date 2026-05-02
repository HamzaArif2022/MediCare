# MediCare – Application de Gestion Médicale

Application web Java EE pour la gestion des patients et des consultations médicales.

---

## Prérequis

Avant de démarrer, assure-toi d'avoir installé :

| Outil | Version minimale | Lien |
|---|---|---|
| JDK | 11 | https://adoptium.net |
| Maven | 3.6+ | https://maven.apache.org/download.cgi |
| MySQL | 8.0+ | https://dev.mysql.com/downloads/mysql/ |
| GlassFish Server | 6.x (Jakarta EE 10) | https://glassfish.org/download |

> **Important :** GlassFish 6 est requis car le projet utilise Jakarta EE (Servlet 5.0, EJB 4.0).  
> Tomcat seul **ne supporte pas les EJB** — il faut GlassFish ou WildFly.

---

## Étape 1 — Cloner le projet

```bash
git clone <url-du-repo>
cd MediCare
```

---

## Étape 2 — Créer la base de données MySQL

Ouvre MySQL Workbench ou le terminal MySQL et exécute le script suivant :

```sql
-- Créer la base de données
CREATE DATABASE IF NOT EXISTS medicare_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE medicare_db;

-- Table des utilisateurs (login)
CREATE TABLE IF NOT EXISTS users (
    userId    INT AUTO_INCREMENT PRIMARY KEY,
    email     VARCHAR(100) NOT NULL UNIQUE,
    password  VARCHAR(100) NOT NULL,
    fullName  VARCHAR(100) NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des patients
CREATE TABLE IF NOT EXISTS patients (
    patientId INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(50)  NOT NULL,
    lastName  VARCHAR(50)  NOT NULL,
    email     VARCHAR(100) NOT NULL,
    phone     VARCHAR(20)  NOT NULL,
    birthDate DATE         NOT NULL,
    bloodType VARCHAR(5)   NOT NULL,
    createdAt TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
);

-- Table des consultations
CREATE TABLE IF NOT EXISTS consultations (
    consultId   INT AUTO_INCREMENT PRIMARY KEY,
    patientId   INT          NOT NULL,
    doctor      VARCHAR(100) NOT NULL,
    diagnostic  TEXT         NOT NULL,
    treatment   TEXT         NOT NULL,
    consultDate DATE         NOT NULL,
    status      VARCHAR(50)  NOT NULL,
    FOREIGN KEY (patientId) REFERENCES patients(patientId) ON DELETE CASCADE
);

-- Compte de test pour se connecter à l'application
INSERT INTO users (email, password, fullName)
VALUES ('admin@medicare.com', 'admin123', 'Administrateur');
```

---

## Étape 3 — Vérifier la connexion MySQL dans le code

Le projet se connecte à MySQL avec ces paramètres (déjà configurés) :

| Paramètre | Valeur |
|---|---|
| URL | `jdbc:mysql://localhost:3306/medicare_db` |
| Utilisateur | `root` |
| Mot de passe | *(vide)* |

Si ton MySQL a un **mot de passe**, modifie la constante `PASSWORD` dans ces 3 fichiers :

- [PatientDAO.java](src/main/java/com/medicare/model/PatientDAO.java) — ligne 10
- [ConsultationDAO.java](src/main/java/com/medicare/model/ConsultationDAO.java) — ligne 10
- [UserDAO.java](src/main/java/com/medicare/model/UserDAO.java) — ligne 9

```java
// Exemple : changer la ligne
private static final String PASSWORD = "";
// En :
private static final String PASSWORD = "ton_mot_de_passe";
```

---

## Étape 4 — Compiler et packager le projet

Dans le répertoire racine du projet (là où se trouve `pom.xml`) :

```bash
mvn clean package
```

Si la commande réussit, un fichier `MediCare.war` sera créé dans le dossier `target/`.

```
target/
└── MediCare.war   ← c'est ce fichier qu'on déploie
```

---

## Étape 5 — Déployer sur GlassFish

### Option A — Via l'interface d'administration GlassFish (recommandé)

1. Démarre GlassFish :
   ```bash
   # Windows
   <glassfish-install>\bin\asadmin start-domain
   
   # Linux / macOS
   <glassfish-install>/bin/asadmin start-domain
   ```

2. Ouvre l'interface d'admin dans le navigateur :
   ```
   http://localhost:4848
   ```

3. Va dans **Applications** → **Deploy** (ou Déployer)

4. Clique sur **Choisir un fichier** et sélectionne `target/MediCare.war`

5. Clique sur **OK** pour déployer

### Option B — Via la commande `asadmin`

```bash
<glassfish-install>/bin/asadmin deploy target/MediCare.war
```

---

## Étape 6 — Accéder à l'application

Une fois déployé, ouvre le navigateur :

```
http://localhost:8080/MediCare
```

### Identifiants de connexion

| Champ | Valeur |
|---|---|
| Email | `admin@medicare.com` |
| Mot de passe | `admin123` |

---

## Fonctionnalités de l'application

| Module | Description |
|---|---|
| **Dashboard** | Vue d'ensemble : statistiques, priorités médicales, recommandations de suivi |
| **Patients** | Ajouter, modifier, supprimer, rechercher des patients |
| **Consultations** | Enregistrer des consultations, voir l'historique par patient, rechercher par médecin |

---

## Structure du projet

```
MediCare/
├── src/main/java/com/medicare/
│   ├── controllers/        # Servlets (LoginServlet, PatientServlet, ...)
│   ├── model/              # Entités + DAOs (Patient, Consultation, User)
│   ├── ejb/                # MedicalAnalyzer (logique métier : âge, priorité)
│   ├── filters/            # AuthFilter (protection des routes)
│   └── listeners/          # PatientCounterListener (compteur au démarrage)
├── src/main/webapp/
│   ├── layout/             # Composants réutilisables (sidebar, header)
│   ├── Patients/           # Pages JSP des patients
│   ├── Consultations/      # Pages JSP des consultations
│   ├── css/style.css       # Feuille de style globale
│   ├── login.jsp           # Page de connexion
│   └── dashboard.jsp       # Tableau de bord
├── pom.xml                 # Configuration Maven
└── README.md               # Ce fichier
```

---

## Résolution des problèmes courants

### Erreur : `Communications link failure` (MySQL)
- Vérifie que MySQL est bien démarré
- Vérifie l'URL, le nom de la base et le mot de passe dans les fichiers DAO

### Erreur : `404 Not Found` après déploiement
- Vérifie que le déploiement a réussi dans la console GlassFish (`http://localhost:4848`)
- Assure-toi que l'URL est bien `http://localhost:8080/MediCare`

### Erreur : `EJB not found` ou `NamingException`
- Tomcat seul ne supporte pas les EJB — utilise GlassFish ou WildFly

### La page de login s'affiche mais la connexion échoue
- Assure-toi d'avoir exécuté le script SQL complet (étape 2)
- Vérifie que l'utilisateur `admin@medicare.com` existe dans la table `users`

---

## Technologies utilisées

- **Java 11** — Langage principal
- **Jakarta EE** (Servlet 5.0, JSP 3.0, EJB 4.0) — Framework web
- **Maven** — Gestion des dépendances et build
- **MySQL 8** — Base de données
- **JSTL 2.0** — Balises JSP pour les vues
- **CSS3** — Interface utilisateur responsive
