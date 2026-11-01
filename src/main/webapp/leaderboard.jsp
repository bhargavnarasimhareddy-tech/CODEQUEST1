
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    List<Map<String, Object>> students =
        (List<Map<String, Object>>) request.getAttribute("students");

    if (students == null) {
        students = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>CodeQuest Leaderboard</title>

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
            max-width: 1000px;
            margin: auto;
            padding: 30px;
            border-radius: 15px;
        }

        h1 {
            color: #38bdf8;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            background: #334155;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 16px;
            border-bottom: 1px solid #475569;
        }

        th {
            background: #0f172a;
            color: #38bdf8;
        }

        tr:hover {
            background: #475569;
        }

        .rank {
            font-size: 22px;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 25px;
            background: #0ea5e9;
            color: white;
            text-decoration: none;
            border-radius: 7px;
        }

        .back:hover {
            background: #0284c7;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>🏆 CodeQuest Leaderboard</h1>

    <p>Compete with other programmers and become the top coder!</p>

    <table>

        <tr>
            <th>Rank</th>
            <th>Username</th>
            <th>Total XP</th>
            <th>Level</th>
            <th>Completed Missions</th>
        </tr>

        <%
            int rank = 1;

            for (Map<String, Object> student : students) {

                String medal = "";

                if (rank == 1)
                    medal = "🥇";
                else if (rank == 2)
                    medal = "🥈";
                else if (rank == 3)
                    medal = "🥉";
        %>

        <tr>

            <td class="rank">
                <%= medal.isEmpty() ? rank : medal %>
            </td>

            <td>
                <%= student.get("username") %>
            </td>

            <td>
                <%= student.get("totalXP") %> XP
            </td>

            <td>
                Level <%= student.get("level") %>
            </td>

            <td>
                <%= student.get("completedMissions") %>
            </td>

        </tr>

        <%
                rank++;
            }

            if (students.isEmpty()) {
        %>

        <tr>
            <td colspan="5">No students registered yet.</td>
        </tr>

        <%
            }
        %>

    </table>

    <a class="back" href="dashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>
</html>
