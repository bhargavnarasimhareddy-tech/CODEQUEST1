<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
if (session.getAttribute("adminId") == null) {
    response.sendRedirect("adminLogin.jsp");
    return;
}

Integer students = (Integer) request.getAttribute("totalStudents");
Integer missions = (Integer) request.getAttribute("totalMissions");
Integer xp = (Integer) request.getAttribute("totalXP");
Integer completed = (Integer) request.getAttribute("completedMissions");

int totalStudents = students == null ? 0 : students;
int totalMissions = missions == null ? 0 : missions;
int totalXP = xp == null ? 0 : xp;
int completedMissions = completed == null ? 0 : completed;
%>

<!DOCTYPE html>
<html>
<head>
<title>CodeQuest Admin Statistics</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial, sans-serif;
    padding: 40px 20px;
}

.container {
    max-width: 900px;
    margin: auto;
    background: #1e293b;
    padding: 35px;
    border-radius: 15px;
}

h1 {
    text-align: center;
    color: #38bdf8;
    margin-bottom: 35px;
}

.grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
}

.card {
    background: #334155;
    padding: 30px 15px;
    border-radius: 12px;
    text-align: center;
}

.card h2 {
    color: #38bdf8;
    font-size: 32px;
}

.card p {
    color: #cbd5e1;
}

.back {
    display: block;
    width: fit-content;
    margin: 30px auto 0;
    background: #0ea5e9;
    color: white;
    padding: 12px 25px;
    text-decoration: none;
    border-radius: 7px;
}

.back:hover {
    background: #0284c7;
}

@media (max-width: 600px) {
    .grid {
        grid-template-columns: 1fr;
    }
}
</style>

</head>

<body>

<div class="container">

    <h1>📊 CodeQuest Statistics</h1>

    <div class="grid">

        <div class="card">
            <h2>👨‍🎓</h2>
            <h2><%= totalStudents %></h2>
            <p>Total Registered Students</p>
        </div>

        <div class="card">
            <h2>💻</h2>
            <h2><%= totalMissions %></h2>
            <p>Total Coding Missions</p>
        </div>

        <div class="card">
            <h2>⭐</h2>
            <h2><%= totalXP %></h2>
            <p>Total XP Earned</p>
        </div>

        <div class="card">
            <h2>✅</h2>
            <h2><%= completedMissions %></h2>
            <p>Correct Submissions</p>
        </div>

    </div>

    <a class="back" href="adminDashboard.jsp">
        Back to Admin Dashboard
    </a>

</div>

</body>
</html>