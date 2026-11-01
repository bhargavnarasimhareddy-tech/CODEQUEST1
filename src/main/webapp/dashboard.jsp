
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="com.codequest.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
String username = (String) session.getAttribute("username");
Integer userId = (Integer) session.getAttribute("userId");

if (username == null || userId == null) {
    response.sendRedirect("login.jsp");
    return;
}

int totalXP = 0;
int playerLevel = 1;
int completedMissions = 0;
int totalMissions = 0;

try (Connection con = DBConnection.getConnection()) {

    String sql = "SELECT total_xp, player_level, " +
        "(SELECT COUNT(*) FROM mission_submissions ms " +
        "WHERE ms.user_id = users.id AND ms.is_correct = 1) " +
        "AS completed FROM users WHERE id = ?";

    try (PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);

        try (ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalXP = rs.getInt("total_xp");
                playerLevel = rs.getInt("player_level");
                completedMissions = rs.getInt("completed");
            }
        }
    }

    String countSQL = "SELECT COUNT(*) FROM missions";

    try (PreparedStatement ps = con.prepareStatement(countSQL);
         ResultSet rs = ps.executeQuery()) {

        if (rs.next()) {
            totalMissions = rs.getInt(1);
        }
    }

} catch (Exception e) {
    throw new ServletException(e);
}

int currentLevelXP = totalXP % 100;
int remainingXP = 100 - currentLevelXP;
int progress = currentLevelXP;
%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<title>CodeQuest Dashboard</title>

<style>

* {
    box-sizing: border-box;
}

body {
    background: #101827;
    color: white;
    font-family: Arial, sans-serif;
    text-align: center;
    padding: 30px 15px;
    margin: 0;
}

.container {
    background: #1e293b;
    padding: 30px;
    border-radius: 15px;
    max-width: 900px;
    margin: auto;
}

h1 {
    color: #38bdf8;
}

.navbar {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 12px;
    margin-bottom: 30px;
}

.navbar a {
    color: white;
    background: #0ea5e9;
    padding: 12px 18px;
    border-radius: 7px;
    text-decoration: none;
}

.navbar a:hover {
    background: #0284c7;
}

.stats-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 18px;
    margin-top: 25px;
}

.card {
    background: #334155;
    padding: 22px;
    border-radius: 12px;
    margin: 15px 0;
}

.card h2 {
    color: #38bdf8;
}

.progress-container {
    background: #0f172a;
    height: 22px;
    border-radius: 20px;
    overflow: hidden;
    margin-top: 20px;
}

.progress-bar {
    background: linear-gradient(90deg, #06b6d4, #38bdf8);
    height: 100%;
    width: <%= progress %>%;
    border-radius: 20px;
    transition: width 0.5s;
}

.progress-text {
    color: #38bdf8;
    margin-top: 15px;
}

.action-btn {
    background: #0ea5e9;
    color: white;
    padding: 12px 25px;
    border-radius: 7px;
    text-decoration: none;
    display: inline-block;
}

.action-btn:hover {
    background: #0284c7;
}

@media(max-width: 600px) {
    .stats-container {
        grid-template-columns: 1fr;
    }

    .container {
        padding: 15px;
    }
}

</style>

</head>

<body>

<div class="container">

    <!-- Navigation -->

    <div class="navbar">

        <a href="dashboard.jsp">🏠 Home</a>

        <a href="missions">💻 Missions</a>

        <a href="profile">👤 Profile</a>

        <a href="leaderboard">🏆 Leaderboard</a>

        <a href="logout">🚪 Logout</a>

    </div>

    <h1>Welcome to CodeQuest!</h1>

    <h2>Hello, <%= username %>!</h2>

    <p>Your coding journey starts here. Complete missions and earn XP!</p>

    <!-- Statistics -->

    <div class="stats-container">

        <div class="card">

            <h3>🏆 Player Level</h3>

            <h2>Level <%= playerLevel %></h2>

        </div>

        <div class="card">

            <h3>⭐ Total Experience</h3>

            <h2><%= totalXP %> XP</h2>

        </div>

        <div class="card">

            <h3>✅ Completed Missions</h3>

            <h2><%= completedMissions %></h2>

        </div>

        <div class="card">

            <h3>📚 Available Missions</h3>

            <h2><%= totalMissions %></h2>

        </div>

    </div>

    <!-- XP Progress -->

    <div class="card">

        <h3>🚀 Level Progress</h3>

        <h2>Level <%= playerLevel %></h2>

        <div class="progress-container">

            <div class="progress-bar"></div>

        </div>

        <p class="progress-text">

            <%= currentLevelXP %> / 100 XP

        </p>

        <p>

            <%= remainingXP %> XP remaining for next level!

        </p>

    </div>

    <!-- Missions -->

    <div class="card">

        <h3>💻 Start Coding!</h3>

        <p>Explore programming challenges and improve your skills.</p>

        <a href="missions" class="action-btn">

            Explore Coding Missions

        </a>

    </div>

    <!-- Leaderboard -->

    <div class="card">

        <h3>🏆 Leaderboard</h3>

        <p>Compare your XP and ranking with other students!</p>

        <a href="leaderboard" class="action-btn">

            View Leaderboard

        </a>

    </div>

    <!-- Profile -->

    <div class="card">

        <h3>👤 My Profile</h3>

        <p>View your coding achievements, XP and completed missions.</p>

        <a href="profile" class="action-btn">

            View My Profile

        </a>

    </div>

</div>

</body>
</html>
