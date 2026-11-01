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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String sql = "SELECT username, email, total_xp, player_level, " +
                     "(SELECT COUNT(*) FROM mission_submissions " +
                     "WHERE user_id = users.id AND is_correct = 1) " +
                     "AS completed_missions " +
                     "FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    request.setAttribute("username", rs.getString("username"));
                    request.setAttribute("email", rs.getString("email"));
                    request.setAttribute("totalXP", rs.getInt("total_xp"));
                    request.setAttribute("playerLevel", rs.getInt("player_level"));
                    request.setAttribute("completedMissions",
                            rs.getInt("completed_missions"));
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.getRequestDispatcher("profile.jsp")
               .forward(request, response);
    }
}