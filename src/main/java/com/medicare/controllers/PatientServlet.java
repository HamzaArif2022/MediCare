package com.medicare.controllers;

import com.medicare.ejb.MedicalAnalyzer;
import com.medicare.listeners.PatientCounterListener;
import com.medicare.model.Patient;
import com.medicare.model.PatientDAO;
import jakarta.servlet.ServletContext;
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

@WebServlet("/patients/*")
public class PatientServlet extends HttpServlet {

    private PatientDAO patientDAO = new PatientDAO();

    @EJB
    private MedicalAnalyzer medicalAnalyzer;

    @EJB
    private MedicalAnalyzer medicalAnalyzer2;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        System.out.println("=== Démonstration EJB Stateless ===");
        System.out.println("Instance 1: " + medicalAnalyzer.getInstanceId());
        System.out.println("Instance 2: " + medicalAnalyzer2.getInstanceId());
        System.out.println("Les deux instances sont identiques = " +
                medicalAnalyzer.getInstanceId().equals(medicalAnalyzer2.getInstanceId()));

        if (path == null || path.equals("/")) {
            listPatients(request, response);
        } else if (path.equals("/add")) {
            showAddForm(request, response);
        } else if (path.equals("/edit")) {
            showEditForm(request, response);
        } else if (path.equals("/delete")) {
            deletePatient(request, response);
        } else if (path.equals("/search")) {
            searchPatients(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path.equals("/add")) {
            addPatient(request, response);
        } else if (path.equals("/update")) {
            updatePatient(request, response);
        }
    }

    private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Patient> patients = patientDAO.getAllPatients();
        request.setAttribute("patients", patients);

        if (patients != null) {
            for (Patient p : patients) {
                if (p.getBirthDate() != null) {
                    int age = medicalAnalyzer.calculateAge(p.getBirthDate());
                    request.setAttribute("age_" + p.getPatientId(), age);
                }
            }
        }

        ServletContext context = getServletContext();
        request.setAttribute("totalPatients", context.getAttribute("totalPatients"));
        request.getRequestDispatcher("/Patients/list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Patients/add.jsp").forward(request, response);
    }

    private void addPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String birthDateStr = request.getParameter("birthDate");
        String bloodType = request.getParameter("bloodType");

        boolean hasError = false;

        if (firstName == null || firstName.trim().isEmpty()) {
            request.setAttribute("firstNameError", "Le prénom est obligatoire");
            hasError = true;
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            request.setAttribute("lastNameError", "Le nom est obligatoire");
            hasError = true;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("emailError", "L'email est obligatoire");
            hasError = true;
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("emailError", "Format d'email invalide");
            hasError = true;
        }
        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("phoneError", "Le téléphone est obligatoire");
            hasError = true;
        } else if (!phone.matches("\\d{10}")) {
            request.setAttribute("phoneError", "Le téléphone doit contenir exactement 10 chiffres");
            hasError = true;
        }

        if (hasError) {
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("birthDate", birthDateStr);
            request.setAttribute("bloodType", bloodType);
            request.getRequestDispatcher("/Patients/add.jsp").forward(request, response);
            return;
        }

        try {
            Patient patient = new Patient();
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setEmail(email);
            patient.setPhone(phone);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date birthDate = sdf.parse(birthDateStr);
            patient.setBirthDate(birthDate);
            patient.setBloodType(bloodType);

            if (patientDAO.addPatient(patient)) {
                ServletContext context = getServletContext();
                int count = patientDAO.countPatients();
                context.setAttribute("totalPatients", count);
                response.sendRedirect(request.getContextPath() + "/patients/");
            } else {
                request.setAttribute("error", "Erreur lors de l'ajout");
                request.getRequestDispatcher("/Patients/add.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("/Patients/add.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = patientDAO.getPatientById(id);
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/Patients/edit.jsp").forward(request, response);
    }

    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("patientId"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String birthDateStr = request.getParameter("birthDate");
        String bloodType = request.getParameter("bloodType");

        try {
            Patient patient = new Patient();
            patient.setPatientId(id);
            patient.setFirstName(firstName);
            patient.setLastName(lastName);
            patient.setEmail(email);
            patient.setPhone(phone);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date birthDate = sdf.parse(birthDateStr);
            patient.setBirthDate(birthDate);
            patient.setBloodType(bloodType);

            patientDAO.updatePatient(patient);
            response.sendRedirect(request.getContextPath() + "/patients/");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/patients/");
        }
    }

    private void deletePatient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        if (patientDAO.deletePatient(id)) {
            ServletContext context = getServletContext();
            int count = patientDAO.countPatients();
            context.setAttribute("totalPatients", count);
        }
        response.sendRedirect(request.getContextPath() + "/patients/");
    }

    private void searchPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        List<Patient> patients = patientDAO.searchPatients(keyword);
        request.setAttribute("patients", patients);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/Patients/list.jsp").forward(request, response);
    }
}