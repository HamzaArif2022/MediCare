package com.medicare.listeners;

import com.medicare.model.PatientDAO;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class PatientCounterListener implements ServletContextListener {

    private PatientDAO patientDAO = new PatientDAO();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        updateCounter(context);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}

    // Méthode synchronisée pour mettre à jour le compteur
    public synchronized void updateCounter(ServletContext context) {
        int count = patientDAO.countPatients();
        context.setAttribute("totalPatients", count);
    }
}