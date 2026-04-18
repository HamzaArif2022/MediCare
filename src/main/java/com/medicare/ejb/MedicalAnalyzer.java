package com.medicare.ejb;

import jakarta.ejb.Stateless;
import jakarta.ejb.LocalBean;
import java.util.Calendar;
import java.util.Date;

@Stateless
@LocalBean
public class MedicalAnalyzer {

    private static int analysisCount = 0;

    /**
     * Calcule l'âge d'un patient à partir de sa date de naissance
     * Compatible avec java.util.Date et java.sql.Date
     */
    public int calculateAge(Date birthDate) {
        if (birthDate == null) {
            return 0;
        }

        // Utilisation de Calendar - 100% compatible
        Calendar birthCal = Calendar.getInstance();
        birthCal.setTime(birthDate);

        Calendar nowCal = Calendar.getInstance();

        int age = nowCal.get(Calendar.YEAR) - birthCal.get(Calendar.YEAR);

        // Vérifier si l'anniversaire est déjà passé cette année
        if (nowCal.get(Calendar.DAY_OF_YEAR) < birthCal.get(Calendar.DAY_OF_YEAR)) {
            age--;
        }

        return age;
    }

    /**
     * Détermine la priorité selon le groupe sanguin et l'historique des consultations
     */
    public String determinePriority(String bloodType, int consultationCount) {
        if (bloodType == null || bloodType.isEmpty()) {
            return "PRIORITÉ NORMALE";
        }

        // Groupes sanguins rares = priorité haute
        if (bloodType.equals("AB-") || bloodType.equals("O-")) {
            return "HAUTE PRIORITÉ";
        }

        // Consultation fréquente = priorité selon le nombre
        if (consultationCount > 10) {
            return "HAUTE PRIORITÉ";
        } else if (consultationCount > 5) {
            return "PRIORITÉ MOYENNE";
        }

        return "PRIORITÉ NORMALE";
    }

    /**
     * Génère une recommandation de suivi médical selon le nombre de consultations
     */
    public String generateRecommendation(int consultationCount) {
        if (consultationCount == 0) {
            return "Aucune consultation. Suivi médical recommandé.";
        } else if (consultationCount <= 3) {
            return "Suivi régulier recommandé tous les 6 mois.";
        } else if (consultationCount <= 6) {
            return "Suivi rapproché recommandé tous les 3 mois.";
        } else {
            return "Suivi intensif recommandé mensuel.";
        }
    }

    /**
     * Compte le nombre total d'analyses effectuées depuis le démarrage du serveur
     */
    public synchronized int countAnalyses() {
        analysisCount++;
        return analysisCount;
    }

    /**
     * Retourne l'ID de l'instance (démonstration du comportement Stateless)
     */
    public String getInstanceId() {
        return this.toString();
    }
}