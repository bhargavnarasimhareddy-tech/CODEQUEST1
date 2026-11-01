<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

if (session.getAttribute("adminUsername") == null) {
    response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
    return;
}

List<Map<String, Object>> missions =
    (List<Map<String, Object>>) request.getAttribute("missions");

if (missions == null) {
    missions = new ArrayList<>();
}
%>

<!DOCTYPE html>


<html>
<head>
<title>Manage Missions - CodeQuest</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial, sans-serif;
    padding: 30px;
}

.container {
    max-width: 1100px;
    margin: auto;
    background: #1e293b;
    padding: 30px;
    border-radius: 15px;
}

h1 {
    color: #38bdf8;
    text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 25px;
}

th, td {
    padding: 13px;
    border-bottom: 1px solid #475569;
    text-align: center;
}

th {
    background: #0f172a;
    color: #38bdf8;
}

tr:hover {
    background: #334155;
}

.action {
    display: inline-block;
    padding: 8px 12px;
    border-radius: 5px;
    color: white;
    text-decoration: none;
    margin: 3px;
}

.edit {
    background: #0284c7;
}

.delete {
    background: #dc2626;
}

.back {
    display: inline-block;
    background: #0ea5e9;
    padding: 12px 20px;
    color: white;
    text-decoration: none;
    border-radius: 7px;
    margin-top: 25px;
}
</style>
</head>

<body>

<div class="container">

<h1>🛠️ Manage Coding Missions</h1>
<%
String error = request.getParameter("error");
String deleted = request.getParameter("deleted");

if ("hasSubmissions".equals(error)) {
%>
    <p style="color:#f87171; text-align:center;">
        Cannot delete this mission because students have already submitted answers.
    </p>
<%
} else if ("notfound".equals(error)) {
%>
    <p style="color:#f87171; text-align:center;">
        Mission not found.
    </p>
<%
} else if ("invalid".equals(error)) {
%>
    <p style="color:#f87171; text-align:center;">
        Invalid mission ID.
    </p>
<%
} else if ("1".equals(deleted)) {
%>
    <p style="color:#4ade80; text-align:center;">
        Mission deleted successfully!
    </p>
<%
}
%>

<p style="text-align:center;">
View, edit and delete your coding missions.
</p>

<table>

<tr>
    <th>ID</th>
    <th>Title</th>
    <th>Category</th>
    <th>Difficulty</th>
    <th>XP</th>
    <th>Actions</th>
</tr>

<%
for (Map<String, Object> m : missions) {
%>

<tr>
    <td><%= m.get("id") %></td>
    <td><%= m.get("title") %></td>
    <td><%= m.get("category") %></td>
    <td><%= m.get("difficulty") %></td>
    <td><%= m.get("xp") %></td>

    <td>
        <a class="action edit"
           href="editMission?id=<%= m.get("id") %>">
           Edit
        </a>

        <form action="deleteMission" method="post"
      style="display:inline;"
      onsubmit="return confirm('Are you sure you want to delete this mission?');">

    <input type="hidden" name="id"
           value="<%= m.get("id") %>">

    <button type="submit"
            class="action delete"
            style="border:none; cursor:pointer;">
        Delete
    </button>

</form>
    </td>
</tr>

<%
}
%>

<% if (missions.isEmpty()) { %>
<tr>
    <td colspan="6">No missions found.</td>
</tr>
<% } %>

</table>

<a class="back" href="adminDashboard.jsp">
Back to Admin Dashboard
</a>

</div>

</body>
</html>