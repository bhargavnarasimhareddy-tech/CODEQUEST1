
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

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String sql = "SELECT id, username FROM admins "
                   + "WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    // Remove any previous student/admin session
                    HttpSession oldSession = request.getSession(false);

                    if (oldSession != null) {
                        oldSession.invalidate();
                    }

                    // Create a fresh admin session
                    HttpSession session = request.getSession(true);

                    session.setAttribute("adminId", rs.getInt("id"));
                    session.setAttribute("adminUsername",
                            rs.getString("username"));

                    response.sendRedirect(
                            request.getContextPath() + "/adminDashboard.jsp");

                } else {
                    response.sendRedirect(
                            request.getContextPath() + "/adminLogin.jsp?error=1");
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
