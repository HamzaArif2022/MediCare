package com.medicare.controllers;

import com.medicare.model.Consultation;
import com.medicare.model.ConsultationDAO;
import com.medicare.model.Patient;
import com.medicare.model.PatientDAO;
import com.medicare.ejb.MedicalAnalyzer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ejb.EJB;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/consultations/*")
public class ConsultationServlet extends HttpServlet {

    private ConsultationDAO consultationDAO = new ConsultationDAO();
    private PatientDAO patientDAO = new PatientDAO();

    @EJB
    private MedicalAnalyzer medicalAnalyzer;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path.equals("/add")) {
            showAddForm(request, response);
        } else if (path.equals("/history")) {
            showHistory(request, response);
        } else if (path.equals("/search")) {
            searchByDoctor(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path.equals("/add")) {
            addConsultation(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Patient> patients = patientDAO.getAllPatients();
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("/Consultations/add.jsp").forward(request, response);
    }

    private void addConsultation(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int patientId = Integer.parseInt(request.getParameter("patientId"));
        String doctor = request.getParameter("doctor");
        String diagnostic = request.getParameter("diagnostic");
        String treatment = request.getParameter("treatment");
        String consultDateStr = request.getParameter("consultDate");
        String status = request.getParameter("status");

        try {
            Consultation consultation = new Consultation();
            consultation.setPatientId(patientId);
            consultation.setDoctor(doctor);
            consultation.setDiagnostic(diagnostic);
            consultation.setTreatment(treatment);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date consultDate = sdf.parse(consultDateStr);
            consultation.setConsultDate(consultDate);
            consultation.setStatus(status);

            consultationDAO.addConsultation(consultation);
            medicalAnalyzer.countAnalyses();

            response.sendRedirect(request.getContextPath() + "/consultations/history?patientId=" + patientId);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/consultations/add");
        }
    }

    private void showHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int patientId = Integer.parseInt(request.getParameter("patientId"));
        Patient patient = patientDAO.getPatientById(patientId);
        List<Consultation> consultations = consultationDAO.getConsultationsByPatientId(patientId);
        int consultationCount = consultationDAO.countConsultationsByPatientId(patientId);

        request.setAttribute("patient", patient);
        request.setAttribute("consultations", consultations);
        request.setAttribute("consultationCount", consultationCount);

        request.getRequestDispatcher("/Consultations/history.jsp").forward(request, response);
    }

    private void searchByDoctor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doctor = request.getParameter("doctor");
        List<Consultation> consultations = consultationDAO.getConsultationsByDoctor(doctor);
        request.setAttribute("consultations", consultations);
        request.setAttribute("searchDoctor", doctor);
        request.getRequestDispatcher("/Consultations/search.jsp").forward(request, response);
    }
}