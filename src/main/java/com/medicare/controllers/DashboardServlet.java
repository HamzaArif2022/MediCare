package com.medicare.controllers;

import com.medicare.model.Patient;
import com.medicare.model.PatientDAO;
import com.medicare.model.ConsultationDAO;
import com.medicare.ejb.MedicalAnalyzer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();
    private ConsultationDAO consultationDAO = new ConsultationDAO();

    @EJB
    private MedicalAnalyzer medicalAnalyzer;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Patient> patients = patientDAO.getAllPatients();
        List<Map<String, Object>> patientAnalyses = new ArrayList<>();
        int totalConsultations = 0;

        for (Patient patient : patients) {
            Map<String, Object> analysis = new HashMap<>();

            // Calculer l'âge
            int age = medicalAnalyzer.calculateAge(patient.getBirthDate());

            // Compter les consultations
            int consultationCount = consultationDAO.countConsultationsByPatientId(patient.getPatientId());
            totalConsultations += consultationCount;

            // Déterminer la priorité
            String priority = medicalAnalyzer.determinePriority(patient.getBloodType(), consultationCount);

            // Générer la recommandation
            String recommendation = medicalAnalyzer.generateRecommendation(consultationCount);

            analysis.put("patientId", patient.getPatientId());
            analysis.put("firstName", patient.getFirstName());
            analysis.put("lastName", patient.getLastName());
            analysis.put("age", age);
            analysis.put("bloodType", patient.getBloodType());
            analysis.put("consultationCount", consultationCount);
            analysis.put("priority", priority);
            analysis.put("priorityClass", priority.contains("HAUTE") ? "high" : (priority.contains("MOYENNE") ? "medium" : "normal"));
            analysis.put("recommendation", recommendation);

            patientAnalyses.add(analysis);
        }

        // Incrémenter le compteur d'analyses
        int analysisCount = medicalAnalyzer.countAnalyses();

        ServletContext context = getServletContext();
        request.setAttribute("patients", patientAnalyses);
        request.setAttribute("totalPatients", context.getAttribute("totalPatients"));
        request.setAttribute("totalConsultations", totalConsultations);
        request.setAttribute("analysisCount", analysisCount);

        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }
}