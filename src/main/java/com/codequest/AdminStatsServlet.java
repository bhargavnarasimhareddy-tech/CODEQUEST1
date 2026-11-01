package com.codequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminStats")
public class AdminStatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        int totalStudents = 0;
        int totalMissions = 0;
        int totalXP = 0;
        int completedMissions = 0;

        try (Connection con = DBConnection.getConnection()) {

            // Total registered students
            String studentSQL = "SELECT COUNT(*) FROM users";

            try (PreparedStatement ps = con.prepareStatement(studentSQL);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalStudents = rs.getInt(1);
                }
            }

            // Total coding missions
            String missionSQL = "SELECT COUNT(*) FROM missions";

            try (PreparedStatement ps = con.prepareStatement(missionSQL);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalMissions = rs.getInt(1);
                }
            }

            // Total XP earned by all students
            String xpSQL = "SELECT COALESCE(SUM(total_xp), 0) FROM users";

            try (PreparedStatement ps = con.prepareStatement(xpSQL);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalXP = rs.getInt(1);
                }
            }

            // Correct mission submissions
            String completedSQL =
                    "SELECT COUNT(*) FROM mission_submissions " +
                    "WHERE is_correct = 1";

            try (PreparedStatement ps = con.prepareStatement(completedSQL);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    completedMissions = rs.getInt(1);
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("totalMissions", totalMissions);
        request.setAttribute("totalXP", totalXP);
        request.setAttribute("completedMissions", completedMissions);

        request.getRequestDispatcher("adminStats.jsp")
               .forward(request, response);
    }
}