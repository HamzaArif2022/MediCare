package com.medicare.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ConsultationDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/medicare_db?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; // Mettez votre mot de passe

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // Ajouter une consultation
    public boolean addConsultation(Consultation consultation) {
        String sql = "INSERT INTO consultations (patientId, doctor, diagnostic, treatment, consultDate, status) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, consultation.getPatientId());
            pstmt.setString(2, consultation.getDoctor());
            pstmt.setString(3, consultation.getDiagnostic());
            pstmt.setString(4, consultation.getTreatment());
            pstmt.setDate(5, new java.sql.Date(consultation.getConsultDate().getTime()));
            pstmt.setString(6, consultation.getStatus());

            int affectedRows = pstmt.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    consultation.setConsultId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Récupérer les consultations d'un patient
    public List<Consultation> getConsultationsByPatientId(int patientId) {
        List<Consultation> consultations = new ArrayList<>();
        String sql = "SELECT * FROM consultations WHERE patientId = ? ORDER BY consultDate DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, patientId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Consultation consultation = new Consultation();
                consultation.setConsultId(rs.getInt("consultId"));
                consultation.setPatientId(rs.getInt("patientId"));
                consultation.setDoctor(rs.getString("doctor"));
                consultation.setDiagnostic(rs.getString("diagnostic"));
                consultation.setTreatment(rs.getString("treatment"));
                consultation.setConsultDate(rs.getDate("consultDate"));
                consultation.setStatus(rs.getString("status"));
                consultations.add(consultation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consultations;
    }

    // Récupérer les consultations par médecin
    public List<Consultation> getConsultationsByDoctor(String doctor) {
        List<Consultation> consultations = new ArrayList<>();
        String sql = "SELECT * FROM consultations WHERE doctor LIKE ? ORDER BY consultDate DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + doctor + "%");
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Consultation consultation = new Consultation();
                consultation.setConsultId(rs.getInt("consultId"));
                consultation.setPatientId(rs.getInt("patientId"));
                consultation.setDoctor(rs.getString("doctor"));
                consultation.setDiagnostic(rs.getString("diagnostic"));
                consultation.setTreatment(rs.getString("treatment"));
                consultation.setConsultDate(rs.getDate("consultDate"));
                consultation.setStatus(rs.getString("status"));
                consultations.add(consultation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return consultations;
    }

    // Compter les consultations d'un patient
    public int countConsultationsByPatientId(int patientId) {
        String sql = "SELECT COUNT(*) FROM consultations WHERE patientId = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, patientId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}