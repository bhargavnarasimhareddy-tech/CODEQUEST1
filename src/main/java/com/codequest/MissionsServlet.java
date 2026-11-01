
package com.codequest;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/missions")
public class MissionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> missions = new ArrayList<>();

        String sql = "SELECT id, title, description, difficulty, xp_reward FROM missions";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> mission = new HashMap<>();

                mission.put("id", rs.getInt("id"));
                mission.put("title", rs.getString("title"));
                mission.put("description", rs.getString("description"));
                mission.put("difficulty", rs.getString("difficulty"));
                mission.put("xp", rs.getInt("xp_reward"));

                missions.add(mission);
            }

            request.setAttribute("missions", missions);

            request.getRequestDispatcher("missions.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Unable to load missions");
        }
    }
}
