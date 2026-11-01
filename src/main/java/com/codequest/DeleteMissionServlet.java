
package com.codequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteMission")
public class DeleteMissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp");
            return;
        }

        String redirectURL =
            request.getContextPath() + "/manageMissions";

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            if (id <= 0) {
                response.sendRedirect(redirectURL + "?error=invalid");
                return;
            }

            String sql = "DELETE FROM missions WHERE id = ?";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);

                int deleted = ps.executeUpdate();

                if (deleted == 0) {
                    response.sendRedirect(
                        redirectURL + "?error=notfound");
                    return;
                }
            }

            response.sendRedirect(redirectURL + "?deleted=1");

        } catch (NumberFormatException e) {

            response.sendRedirect(redirectURL + "?error=invalid");

        } catch (SQLException e) {

            // MySQL error 1451: mission is referenced by submissions.
            if (e.getErrorCode() == 1451) {
                response.sendRedirect(
                    redirectURL + "?error=hasSubmissions");
            } else {
                throw new ServletException(
                    "Database error while deleting mission.", e);
            }
        }
    }
}
