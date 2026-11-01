
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>

<%!
    private String escapeHtml(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int missionId;

    try {
        missionId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("missions");
        return;
    }

    String title = null;
    String description = null;
    String question = null;
    String optionA = null;
    String optionB = null;
    String optionC = null;
    String optionD = null;
    String difficulty = null;
    String missionType = null;
    String supportedLanguages = null;

    int xpReward = 0;
    boolean found = false;

    String sql = "SELECT title, description, question, " +
            "option_a, option_b, option_c, option_d, " +
            "difficulty, xp_reward, mission_type, " +
            "supported_languages FROM missions WHERE id = ?";

    try (Connection con = com.codequest.DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, missionId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                found = true;

                title = rs.getString("title");
                description = rs.getString("description");
                question = rs.getString("question");

                optionA = rs.getString("option_a");
                optionB = rs.getString("option_b");
                optionC = rs.getString("option_c");
                optionD = rs.getString("option_d");

                difficulty = rs.getString("difficulty");
                xpReward = rs.getInt("xp_reward");

                missionType = rs.getString("mission_type");
                supportedLanguages = rs.getString("supported_languages");
            }
        }

    } catch (Exception e) {
        throw new ServletException(e);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CodeQuest - Mission</title>

    <style>
        body {
            background: #101827;
            color: white;
            font-family: Arial, sans-serif;
            padding: 40px;
        }

        .container {
            background: #202c40;
            max-width: 850px;
            margin: auto;
            padding: 30px;
            border-radius: 15px;
        }

        h1 {
            color: #25baff;
        }

        .question-box {
            background: #172338;
            padding: 20px;
            border-radius: 10px;
            margin-top: 25px;
        }

        .option {
            display: block;
            background: #293950;
            padding: 15px;
            margin: 12px 0;
            border-radius: 8px;
            cursor: pointer;
        }

        .option:hover {
            background: #354d6b;
        }

        input[type="radio"] {
            margin-right: 10px;
        }

        textarea {
            width: 100%;
            height: 300px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 15px;
            border-radius: 8px;
            font-family: monospace;
            margin-top: 15px;
        }

        select {
            padding: 12px;
            border-radius: 7px;
            margin: 15px 0;
            font-size: 15px;
        }

        button {
            background: #08a9e5;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
        }

        button:hover {
            background: #0284c7;
        }

        .back-link {
            color: #25baff;
            display: inline-block;
            margin-top: 20px;
        }

        .details {
            color: #aabbd0;
        }

        .message {
            background: #172338;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            color: #38f59b;
            white-space: pre-wrap;
        }

        label {
            display: block;
            margin-top: 15px;
        }
    </style>
</head>

<body>

<div class="container">

<% if (!found) { %>

    <h1>Mission Not Found</h1>
    <p>This mission does not exist.</p>

<% } else { %>

    <h1><%= escapeHtml(title) %></h1>

    <p class="details">
        Difficulty: <%= escapeHtml(difficulty) %>
        | XP Reward: <%= xpReward %> XP
    </p>

    <h3>Problem Description</h3>
    <p><%= escapeHtml(description) %></p>

    <%
        String message = (String) request.getAttribute("message");

        if (message != null) {
    %>
        <div class="message"><%= escapeHtml(message) %></div>
    <% } %>

    <% if ("CODING".equalsIgnoreCase(missionType)) { %>

        <!-- CODING MISSION -->

        <div class="question-box">

            <h2>Coding Challenge</h2>

            <p><%= escapeHtml(question) %></p>

            <h3>Choose Programming Language</h3>

            <form action="runCode" method="post">

                <input type="hidden" name="missionId"
                       value="<%= missionId %>">

                <select id="language" name="language"
                        onchange="updateCode()" required>

                    <% if ("BOTH".equalsIgnoreCase(supportedLanguages)
                            || "JAVA".equalsIgnoreCase(supportedLanguages)) { %>

                        <option value="JAVA">Java</option>

                    <% } %>

                    <% if ("BOTH".equalsIgnoreCase(supportedLanguages)
                            || "PYTHON".equalsIgnoreCase(supportedLanguages)) { %>

                        <option value="PYTHON">Python</option>

                    <% } %>

                </select>

                <!-- FIRST BOX: WRITE YOUR CODE -->

                <h3>Write Your Code</h3>

                <textarea id="codeEditor" name="code"
                          placeholder="Write your code here..."
                          required></textarea>

                <!-- SECOND BOX: CUSTOM INPUT -->

                <h3>Custom Input (if required)</h3>

                <textarea
                    name="programInput"
                    id="programInput"
                    rows="3"
                    placeholder="Example: 121"
                    style="height:100px;"></textarea>

                <br>

                <button type="submit">
                    Run Code
                </button>

            </form>

        </div>

        <script>
            const missionId = <%= missionId %>;

            function updateCode() {

                const language =
                    document.getElementById("language").value;

                const editor =
                    document.getElementById("codeEditor");

                if (missionId === 1) {

                    if (language === "JAVA") {
                        editor.value = `public class Main {
    public static void main(String[] args) {
        System.out.println("Hello World");
    }
}`;
                    } else {
                        editor.value = `print("Hello World")`;
                    }

                } else if (missionId === 3) {

                    if (language === "JAVA") {
                        editor.value = `import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();

        // Write your prime number logic here

        sc.close();
    }
}`;
                    } else {
                        editor.value = `n = int(input())

# Write your prime number logic here`;
                    }

                } else {

                    if (language === "JAVA") {
                        editor.value = `import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        // Write your solution here

        sc.close();
    }
}`;
                    } else {
                        editor.value = `# Write your Python solution here`;
                    }
                }
            }

            updateCode();
        </script>

    <% } else if ("MCQ".equalsIgnoreCase(missionType)) { %>

        <!-- MCQ MISSION -->

        <div class="question-box">

            <h2>Question</h2>

            <p><%= escapeHtml(question) %></p>

            <form action="submitMission" method="post">

                <input type="hidden" name="missionId"
                       value="<%= missionId %>">

                <label class="option">
                    <input type="radio" name="answer"
                           value="A" required>
                    A. <%= escapeHtml(optionA) %>
                </label>

                <label class="option">
                    <input type="radio" name="answer"
                           value="B">
                    B. <%= escapeHtml(optionB) %>
                </label>

                <label class="option">
                    <input type="radio" name="answer"
                           value="C">
                    C. <%= escapeHtml(optionC) %>
                </label>

                <label class="option">
                    <input type="radio" name="answer"
                           value="D">
                    D. <%= escapeHtml(optionD) %>
                </label>

                <button type="submit">
                    Submit Answer
                </button>

            </form>

        </div>

    <% } else { %>

        <h3>Mission type is not configured.</h3>

    <% } %>

<% } %>

<a class="back-link" href="missions">
    ← Back to Missions
</a>

</div>

</body>
</html>
