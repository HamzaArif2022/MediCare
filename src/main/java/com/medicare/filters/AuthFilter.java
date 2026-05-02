package com.medicare.filters;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        // Pages autorisées sans authentification
        if (uri.equals(contextPath + "/login") || uri.equals(contextPath + "/login.jsp")
                || uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            // Utilisateur connecté
            chain.doFilter(request, response);
        } else {
            // Non connecté : rediriger vers login
            res.sendRedirect(contextPath + "/login");
        }
    }

    @Override
    public void destroy() {}
}