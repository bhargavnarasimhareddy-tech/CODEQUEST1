package com.codequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/manageStudents")
public class ManageStudentsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check admin session
        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect("adminLogin.jsp");
            return;
        }

        List<Map<String, Object>> students = new ArrayList<>();

        // Get search input
        String search = request.getParameter("search");

        String sql = "SELECT id, username, email, total_xp, " +
                     "player_level, created_at FROM users ";

        // Add search condition
        if (search != null && !search.trim().isEmpty()) {
            sql += "WHERE username LIKE ? OR email LIKE ? ";
        }

        sql += "ORDER BY total_xp DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Set search parameters
            if (search != null && !search.trim().isEmpty()) {

                String pattern = "%" + search.trim() + "%";

                ps.setString(1, pattern);
                ps.setString(2, pattern);
            }

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Map<String, Object> student = new HashMap<>();

                    student.put("id", rs.getInt("id"));
                    student.put("username", rs.getString("username"));
                    student.put("email", rs.getString("email"));
                    student.put("xp", rs.getInt("total_xp"));
                    student.put("level", rs.getInt("player_level"));
                    student.put("created", rs.getTimestamp("created_at"));

                    students.add(student);
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }

        // Send data to JSP
        request.setAttribute("students", students);
        request.setAttribute("search", search);

        request.getRequestDispatcher("manageStudents.jsp")
               .forward(request, response);
    }
}