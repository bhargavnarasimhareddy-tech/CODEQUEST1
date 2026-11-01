
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

Integer id = (Integer) request.getAttribute("id");

if (id == null) {
    response.sendRedirect(request.getContextPath() + "/manageMissions");
    return;
}

String title = (String) request.getAttribute("title");
String description = (String) request.getAttribute("description");
String category = (String) request.getAttribute("category");
String difficulty = (String) request.getAttribute("difficulty");

int xp = (Integer) request.getAttribute("xp");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Mission - CodeQuest</title>

    <style>
        body {
            background: #101827;
            color: white;
            font-family: Arial, sans-serif;
            padding: 30px;
        }

        .container {
            background: #1e293b;
            max-width: 600px;
            margin: auto;
            padding: 30px;
            border-radius: 15px;
        }

        h1 {
            color: #38bdf8;
            text-align: center;
        }

        label {
            display: block;
            margin-top: 15px;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            box-sizing: border-box;
            border-radius: 7px;
            border: none;
        }

        button {
            width: 100%;
            padding: 13px;
            margin-top: 20px;
            background: #0ea5e9;
            color: white;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background: #0284c7;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            color: #38bdf8;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>✏️ Edit Coding Mission</h1>

    <form action="<%= request.getContextPath() %>/editMission" method="post">

        <input type="hidden" name="id" value="<%= id %>">

        <label>Mission Title</label>
        <input type="text" name="title"
               value="<%= title %>" required>

        <label>Description</label>
        <textarea name="description" rows="4"
                  required><%= description %></textarea>

        <label>Category</label>
        <select name="category" required>
            <option value="Java"
                <%= "Java".equals(category) ? "selected" : "" %>>
                Java
            </option>

            <option value="Python"
                <%= "Python".equals(category) ? "selected" : "" %>>
                Python
            </option>

            <option value="C"
                <%= "C".equals(category) ? "selected" : "" %>>
                C
            </option>

            <option value="DSA"
                <%= "DSA".equals(category) ? "selected" : "" %>>
                DSA
            </option>
        </select>

        <label>Difficulty</label>
        <select name="difficulty" required>
            <option value="Easy"
                <%= "Easy".equals(difficulty) ? "selected" : "" %>>
                Easy
            </option>

            <option value="Medium"
                <%= "Medium".equals(difficulty) ? "selected" : "" %>>
                Medium
            </option>

            <option value="Hard"
                <%= "Hard".equals(difficulty) ? "selected" : "" %>>
                Hard
            </option>
        </select>

        <label>XP Reward</label>
        <input type="number" name="xp_reward"
               value="<%= xp %>" min="1" max="1000" required>

        <button type="submit">Update Mission</button>

    </form>

    <a class="back"
       href="<%= request.getContextPath() %>/manageMissions">
        ← Back to Manage Missions
    </a>

</div>

</body>
</html>
