<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
List<Map<String, Object>> missions =
    (List<Map<String, Object>>) request.getAttribute("missions");

if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
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
<title>CodeQuest Missions</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial;
    padding: 30px;
}

h1 {
    color: #38bdf8;
    text-align: center;
}

.container {
    max-width: 850px;
    margin: auto;
}

.card {
    background: #1e293b;
    padding: 25px;
    margin: 20px 0;
    border-radius: 12px;
}

button {
    background: #0ea5e9;
    color: white;
    border: none;
    padding: 12px 25px;
    border-radius: 6px;
    cursor: pointer;
}
</style>
</head>

<body>
<div style="width: 85%; margin: 20px auto; text-align: left;">
    <a href="<%= request.getContextPath() %>/dashboard.jsp"
       style="display: inline-block;
              background: #0ea5e9;
              color: white;
              padding: 12px 25px;
              text-decoration: none;
              border-radius: 8px;
              font-weight: bold;">
        🏠 Home
    </a>
</div>
<div class="container">

<h1>CodeQuest Coding Missions</h1>

<%
if (missions != null) {
    for (Map<String, Object> m : missions) {
%>

<div class="card">

    <h2><%= m.get("title") %></h2>

    <p><%= m.get("description") %></p>

    <p>Difficulty: <%= m.get("difficulty") %></p>

    <p>Reward: <%= m.get("xp") %> XP</p>

    <a href="mission.jsp?id=<%= m.get("id") %>">
    <button type="button">Start Mission</button>
</a>

</div>

<%
    }
}
%>

</div>

</body>
</html>
