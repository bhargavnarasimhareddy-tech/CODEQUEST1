<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" %>

<%
String admin = (String) session.getAttribute("adminUsername");

if (admin == null) {
    response.sendRedirect("adminLogin.jsp");
    return;
}
%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if (session.getAttribute("adminUsername") == null) {
    response.sendRedirect("admin-login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>CodeQuest Admin Dashboard</title>

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
    max-width: 850px;
    margin: auto;
    padding: 35px;
    border-radius: 15px;
}

h1 {
    color: #38bdf8;
}

.card {
    background: #334155;
    padding: 25px;
    margin: 18px 0;
    border-radius: 12px;
}

a {
    display: inline-block;
    background: #0ea5e9;
    color: white;
    padding: 12px 25px;
    border-radius: 7px;
    text-decoration: none;
    margin-top: 10px;
}

a:hover {
    background: #0284c7;
}

.logout {
    background: #dc2626;
}
.navbar {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
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
</style>
</head>

<body>
<div class="navbar">
    <a href="adminDashboard.jsp">🏠 Home</a>
    <a href="addMission.jsp">➕ Add Mission</a>
    <a href="manageMissions">📚 Manage Missions</a>
    <a href="manageStudents">👨‍🎓 Manage Students</a>
    <a href="adminStats">📊 Statistics</a>
    <a href="adminLogout">🚪 Logout</a>
</div>

<div class="container">

    <h1>🛠️ CodeQuest Admin Dashboard</h1>

    <h2>Welcome, <%= admin %>!</h2>

    <div class="card">
        <h3>➕ Add New Mission</h3>
        <p>Create new programming challenges for students.</p>
        <a href="addMission.jsp">Add Mission</a>
    </div>

    <div class="card">
        <h3>📝 Manage Missions</h3>
        <p>View, edit and delete existing coding missions.</p>
        <a href="manageMissions">Manage Missions</a>
    </div>

    <div class="card">
        <h3>👨‍🎓 Student Management</h3>
        <p>View registered students and their XP.</p>
        <a href="manageStudents">View Students</a>
    </div>
    <div class="card">
    <h3>📊 Platform Statistics</h3>
    <p>Monitor CodeQuest students, missions and XP.</p>
    <a href="adminStats">View Statistics</a>
</div>

    <div class="card">
        <h3>📊 Leaderboard</h3>
        <p>View student rankings and XP.</p>
        <a href="leaderboard">View Leaderboard</a>
    </div>

    <a class="logout" href="adminLogout">Logout</a>

</div>

</body>
</html>