
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

@WebServlet("/editMission")
public class EditMissionServlet extends HttpServlet {

    private boolean isAdmin(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp"
            );
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setHeader("Cache-Control",
                "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        if (!isAdmin(request, response)) return;

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            String sql = "SELECT * FROM missions WHERE id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        request.setAttribute("id", rs.getInt("id"));
                        request.setAttribute("title", rs.getString("title"));
                        request.setAttribute("description",
                                rs.getString("description"));
                        request.setAttribute("category",
                                rs.getString("category"));
                        request.setAttribute("difficulty",
                                rs.getString("difficulty"));
                        request.setAttribute("xp",
                                rs.getInt("xp_reward"));
                    } else {
                        response.sendRedirect(
                            request.getContextPath() + "/manageMissions"
                        );
                        return;
                    }
                }
            }

            request.getRequestDispatcher("/editMission.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/manageMissions"
            );
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request, response)) return;

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String difficulty = request.getParameter("difficulty");
            int xp = Integer.parseInt(request.getParameter("xp_reward"));

            if (title == null || title.trim().isEmpty()
                    || description == null
                    || description.trim().isEmpty()
                    || xp < 1 || xp > 1000) {

                response.sendRedirect(
                    request.getContextPath()
                    + "/editMission?id=" + id + "&error=1"
                );
                return;
            }

            String sql = "UPDATE missions SET title=?, description=?, "
                       + "category=?, difficulty=?, xp_reward=? WHERE id=?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, title.trim());
                ps.setString(2, description.trim());
                ps.setString(3, category);
                ps.setString(4, difficulty);
                ps.setInt(5, xp);
                ps.setInt(6, id);

                int updated = ps.executeUpdate();

                if (updated == 0) {
                    response.sendRedirect(
                        request.getContextPath()
                        + "/manageMissions?error=notfound"
                    );
                    return;
                }
            }

            response.sendRedirect(
                request.getContextPath() + "/manageMissions?updated=1"
            );

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/manageMissions?error=invalid"
            );
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
