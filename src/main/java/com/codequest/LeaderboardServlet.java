
package com.codequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Allow both students and admins
        boolean isStudent = session != null &&
                session.getAttribute("username") != null;

        boolean isAdmin = session != null &&
                session.getAttribute("adminUsername") != null;

        if (!isStudent && !isAdmin) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> students = new ArrayList<>();

        String sql = "SELECT u.username, u.total_xp, u.player_level, " +
                "COUNT(ms.id) AS completed_missions " +
                "FROM users u " +
                "LEFT JOIN mission_submissions ms " +
                "ON u.id = ms.user_id AND ms.is_correct = 1 " +
                "GROUP BY u.id, u.username, u.total_xp, u.player_level " +
                "ORDER BY u.total_xp DESC, u.username ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            int rank = 1;

            while (rs.next()) {

                Map<String, Object> student = new HashMap<>();

                student.put("rank", rank++);
                student.put("username", rs.getString("username"));
                student.put("totalXP", rs.getInt("total_xp"));
                student.put("level", rs.getInt("player_level"));

                students.add(student);
                student.put("completedMissions",
                        rs.getInt("completed_missions"));
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("students", students);

        request.getRequestDispatcher("leaderboard.jsp")
               .forward(request, response);
    }
}
