<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
String username = (String) request.getAttribute("username");
String email = (String) request.getAttribute("email");

Integer totalXP = (Integer) request.getAttribute("totalXP");
Integer playerLevel = (Integer) request.getAttribute("playerLevel");
Integer completedMissions = (Integer) request.getAttribute("completedMissions");

if (username == null) {
    response.sendRedirect("login.jsp");
    return;
}

int xp = totalXP != null ? totalXP : 0;
int level = playerLevel != null ? playerLevel : 1;
int missions = completedMissions != null ? completedMissions : 0;
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
<title>CodeQuest - My Profile</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial, sans-serif;
    text-align: center;
    padding: 40px 20px;
}

.container {
    background: #1e293b;
    max-width: 650px;
    margin: auto;
    padding: 35px;
    border-radius: 18px;
}

.avatar {
    width: 100px;
    height: 100px;
    background: #0ea5e9;
    border-radius: 50%;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 45px;
}

h1 {
    color: #38bdf8;
}

.card {
    background: #334155;
    padding: 20px;
    margin: 15px 0;
    border-radius: 12px;
}

.value {
    color: #38bdf8;
    font-size: 25px;
    font-weight: bold;
}

a {
    display: inline-block;
    background: #0ea5e9;
    color: white;
    padding: 12px 24px;
    border-radius: 7px;
    text-decoration: none;
    margin: 8px;
}

a:hover {
    background: #0284c7;
}
</style>
</head>

<body>

<div class="container">

    <div class="avatar">👨‍💻</div>

    <h1>My Coding Profile</h1>

    <h2><%= username %></h2>

    <div class="card">
        <h3>📧 Email</h3>
        <p><%= email == null ? "Not available" : email %></p>
    </div>

    <div class="card">
        <h3>🏆 Player Level</h3>
        <div class="value">Level <%= level %></div>
    </div>

    <div class="card">
        <h3>⭐ Total Experience</h3>
        <div class="value"><%= xp %> XP</div>
    </div>

    <div class="card">
        <h3>🎯 Completed Missions</h3>
        <div class="value"><%= missions %></div>
    </div>

    <div class="card">
        <h3>🎖️ Achievement</h3>
        <p>
            <%= missions > 0 ? "First Mission Completed!" :
                "Complete your first mission to unlock an achievement!" %>
        </p>
    </div>

    <a href="dashboard.jsp">Back to Dashboard</a>

    <a href="missions">Explore Missions</a>

</div>

</body>
</html>