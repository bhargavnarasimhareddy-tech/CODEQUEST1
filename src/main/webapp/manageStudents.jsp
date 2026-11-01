<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%
if (session.getAttribute("adminId") == null) {
    response.sendRedirect("adminLogin.jsp");
    return;
}

List<Map<String, Object>> students =
    (List<Map<String, Object>>) request.getAttribute("students");

if (students == null) {
    students = new ArrayList<>();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Management - CodeQuest</title>
<form action="manageStudents" method="get"
      style="text-align:center; margin:25px;">

    <input type="text"
           name="search"
           placeholder="Search username or email..."
           value="<%= request.getAttribute("search") == null ? "" :
           request.getAttribute("search") %>"
           style="padding:12px; width:60%; border-radius:7px;">

    <button type="submit"
            style="padding:12px 20px; background:#0ea5e9;
            color:white; border:none; border-radius:7px;">
        Search
    </button>

    <a href="manageStudents"
       style="color:#38bdf8; margin-left:10px;">
        Clear
    </a>

</form>

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
    text-align: center;
    color: #38bdf8;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 25px;
}

th, td {
    padding: 14px;
    text-align: center;
    border-bottom: 1px solid #475569;
}

th {
    background: #0f172a;
    color: #38bdf8;
}

tr:hover {
    background: #334155;
}

.back {
    display: inline-block;
    margin-top: 25px;
    padding: 12px 22px;
    background: #0ea5e9;
    color: white;
    text-decoration: none;
    border-radius: 7px;
}

.empty {
    text-align: center;
    padding: 25px;
}
</style>
</head>

<body>

<div class="container">

    <h1>👨‍🎓 Student Management</h1>

    <p style="text-align:center;">
        View registered students and their coding progress.
    </p>

    <table>

        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Total XP</th>
            <th>Level</th>
            <th>Registration Date</th>
        </tr>

        <%
        for (Map<String, Object> student : students) {
        %>

        <tr>
            <td><%= student.get("id") %></td>
            <td><%= student.get("username") %></td>
            <td><%= student.get("email") %></td>
            <td><%= student.get("xp") %> XP</td>
            <td>Level <%= student.get("level") %></td>
            <td><%= student.get("created") %></td>
        </tr>

        <%
        }
        %>

        <% if (students.isEmpty()) { %>
        <tr>
            <td colspan="6" class="empty">
                No registered students found.
            </td>
        </tr>
        <% } %>

    </table>

    <a class="back" href="adminDashboard.jsp">
        Back to Admin Dashboard
    </a>

</div>

</body>
</html>