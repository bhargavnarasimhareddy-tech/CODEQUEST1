
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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("message",
                    "Passwords do not match!");
            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                throw new Exception("Database connection failed");
            }

            String checkSql =
                "SELECT id FROM users WHERE username=? OR email=?";

            try (PreparedStatement check =
                    con.prepareStatement(checkSql)) {

                check.setString(1, username);
                check.setString(2, email);

                try (ResultSet rs = check.executeQuery()) {

                    if (rs.next()) {
                        request.setAttribute("message",
                                "Username or email already exists!");

                        request.getRequestDispatcher("register.jsp")
                                .forward(request, response);
                        return;
                    }
                }
            }

            String sql =
                "INSERT INTO users " +
                "(username,email,password,total_xp,player_level) " +
                "VALUES (?,?,?,0,1)";

            try (PreparedStatement ps =
                    con.prepareStatement(sql)) {

                ps.setString(1, username);
                ps.setString(2, email);
                ps.setString(3, password);

                ps.executeUpdate();
            }

            request.setAttribute("message",
                    "Registration successful! You can now log in.");

            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("message",
                    "Registration failed. Please try again.");

            request.getRequestDispatcher("register.jsp")
                    .forward(request, response);
        }
    }
}
