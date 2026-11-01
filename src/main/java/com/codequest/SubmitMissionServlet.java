
package com.codequest;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/submitMission")
public class SubmitMissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        int missionId;

        try {
            missionId = Integer.parseInt(
                request.getParameter("missionId"));
        } catch (Exception e) {
            response.sendRedirect(
                request.getContextPath() + "/missions");
            return;
        }

        String answer = request.getParameter("answer");

        if (answer == null ||
            !answer.matches("(?i)[ABCD]")) {

            showMessage(request, response, missionId,
                "Please select an answer.");
            return;
        }

        answer = answer.toUpperCase();

        try (Connection con = DBConnection.getConnection()) {

            // Get correct answer and XP reward
            String sql =
                "SELECT correct_answer, xp_reward " +
                "FROM missions WHERE id = ?";

            String correctAnswer;
            int xpReward;

            try (PreparedStatement ps =
                    con.prepareStatement(sql)) {

                ps.setInt(1, missionId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (!rs.next()) {
                        response.sendRedirect(
                            request.getContextPath() + "/missions");
                        return;
                    }

                    correctAnswer =
                        rs.getString("correct_answer");

                    xpReward = rs.getInt("xp_reward");
                }
            }

            boolean isCorrect =
                correctAnswer != null &&
                answer.equalsIgnoreCase(correctAnswer.trim());

            // Begin transaction
            con.setAutoCommit(false);

            try {

                // Save both correct and incorrect attempts
                String insertSQL =
                    "INSERT INTO mission_submissions " +
                    "(user_id, mission_id, answer, is_correct) " +
                    "VALUES (?, ?, ?, ?)";

                try (PreparedStatement ps =
                        con.prepareStatement(insertSQL)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, missionId);
                    ps.setString(3, answer);
                    ps.setInt(4, isCorrect ? 1 : 0);

                    ps.executeUpdate();
                }

                // Award XP only for a correct answer
                if (isCorrect) {


String updateSQL =
    "UPDATE users SET " +
    "player_level = FLOOR((total_xp + ?) / 100) + 1, " +
    "total_xp = total_xp + ? " +
    "WHERE id = ?";


                    try (PreparedStatement ps =
                            con.prepareStatement(updateSQL)) {

                    	ps.setInt(1, xpReward);
                    	ps.setInt(2, xpReward);
                    	ps.setInt(3, userId);

                        int updatedRows = ps.executeUpdate();

                        if (updatedRows == 0) {
                            throw new SQLException(
                                "Student record not found.");
                        }
                    }
                }

                // Save submission and XP update together
                con.commit();

                if (isCorrect) {
                    showMessage(request, response, missionId,
                        "Correct Answer! You earned " +
                        xpReward + " XP!");
                } else {
                    showMessage(request, response, missionId,
                        "Incorrect answer! No XP awarded. " +
                        "This mission attempt is completed.");
                }

            } catch (SQLException e) {

                con.rollback();

                // MySQL duplicate entry error
                if (e.getErrorCode() == 1062) {

                    showMessage(request, response, missionId,
                        "Mission already attempted or completed! " +
                        "You cannot submit it again.");

                } else {
                    throw e;
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showMessage(HttpServletRequest request,
                             HttpServletResponse response,
                             int missionId,
                             String message)
            throws ServletException, IOException {

        request.setAttribute("message", message);

        request.getRequestDispatcher(
            "mission.jsp?id=" + missionId)
            .forward(request, response);
    }
}
