<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>CodeQuest Admin Login</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 90vh;
}

.container {
    background: #1e293b;
    padding: 40px;
    border-radius: 15px;
    width: 350px;
    text-align: center;
}

h1 {
    color: #38bdf8;
}

input {
    width: 100%;
    padding: 12px;
    margin: 12px 0;
    box-sizing: border-box;
    border-radius: 7px;
    border: none;
}

button {
    width: 100%;
    padding: 12px;
    background: #0ea5e9;
    color: white;
    border: none;
    border-radius: 7px;
    cursor: pointer;
}

.error {
    color: #fb7185;
}
</style>
</head>

<body>

<div class="container">

    <h1>🛠️ Admin Login</h1>

    <p>CodeQuest Administration</p>

    <%
    String error = request.getParameter("error");
    if (error != null) {
    %>
        <p class="error">Invalid username or password!</p>
    <%
    }
    %>

    <form action="adminLogin" method="post">

        <input type="text" name="username"
               placeholder="Admin Username" required>

        <input type="password" name="password"
               placeholder="Admin Password" required>

        <button type="submit">Login as Admin</button>

    </form>

</div>

</body>
</html>