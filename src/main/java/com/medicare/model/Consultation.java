package com.medicare.model;

import java.util.Date;

public class Consultation {

    private int consultId;
    private int patientId;
    private String doctor;
    private String diagnostic;
    private String treatment;
    private Date consultDate;
    private String status;

    // Constructeur par défaut
    public Consultation() {
    }

    // Constructeur avec paramètres
    public Consultation(int patientId, String doctor, String diagnostic,
                        String treatment, Date consultDate, String status) {
        this.patientId = patientId;
        this.doctor = doctor;
        this.diagnostic = diagnostic;
        this.treatment = treatment;
        this.consultDate = consultDate;
        this.status = status;
    }

    // Constructeur complet avec ID
    public Consultation(int consultId, int patientId, String doctor,
                        String diagnostic, String treatment, Date consultDate, String status) {
        this.consultId = consultId;
        this.patientId = patientId;
        this.doctor = doctor;
        this.diagnostic = diagnostic;
        this.treatment = treatment;
        this.consultDate = consultDate;
        this.status = status;
    }

    // Getters et Setters
    public int getConsultId() {
        return consultId;
    }

    public void setConsultId(int consultId) {
        this.consultId = consultId;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public String getDoctor() {
        return doctor;
    }

    public void setDoctor(String doctor) {
        this.doctor = doctor;
    }

    public String getDiagnostic() {
        return diagnostic;
    }

    public void setDiagnostic(String diagnostic) {
        this.diagnostic = diagnostic;
    }

    public String getTreatment() {
        return treatment;
    }

    public void setTreatment(String treatment) {
        this.treatment = treatment;
    }

    public Date getConsultDate() {
        return consultDate;
    }

    public void setConsultDate(Date consultDate) {
        this.consultDate = consultDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // Méthode toString pour le débogage
    @Override
    public String toString() {
        return "Consultation{" +
                "consultId=" + consultId +
                ", patientId=" + patientId +
                ", doctor='" + doctor + '\'' +
                ", diagnostic='" + diagnostic + '\'' +
                ", treatment='" + treatment + '\'' +
                ", consultDate=" + consultDate +
                ", status='" + status + '\'' +
                '}';
    }
}