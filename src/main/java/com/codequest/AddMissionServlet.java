
package com.codequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addMission")
public class AddMissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String difficulty = request.getParameter("difficulty");

        String question = request.getParameter("question");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");

        try {
            int xpReward = Integer.parseInt(
                    request.getParameter("xp_reward"));

            if (title == null || title.trim().isEmpty()
                    || description == null || description.trim().isEmpty()
                    || question == null || question.trim().isEmpty()
                    || optionA == null || optionA.trim().isEmpty()
                    || optionB == null || optionB.trim().isEmpty()
                    || optionC == null || optionC.trim().isEmpty()
                    || optionD == null || optionD.trim().isEmpty()
                    || correctAnswer == null
                    || !correctAnswer.matches("[ABCD]")
                    || xpReward < 1 || xpReward > 1000) {

                response.sendRedirect("addMission.jsp?error=1");
                return;
            }

            int adminId = (Integer) session.getAttribute("adminId");

            String sql = "INSERT INTO missions " +
                    "(title, description, question, category, difficulty, " +
                    "option_a, option_b, option_c, option_d, " +
                    "correct_answer, xp_reward, created_by) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, title.trim());
                ps.setString(2, description.trim());
                ps.setString(3, question.trim());
                ps.setString(4, category);
                ps.setString(5, difficulty);
                ps.setString(6, optionA.trim());
                ps.setString(7, optionB.trim());
                ps.setString(8, optionC.trim());
                ps.setString(9, optionD.trim());
                ps.setString(10, correctAnswer);
                ps.setInt(11, xpReward);
                ps.setInt(12, adminId);

                // Save mission into database
                ps.executeUpdate();
            }

            response.sendRedirect("addMission.jsp?success=1");

        } catch (NumberFormatException e) {
            response.sendRedirect("addMission.jsp?error=1");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
