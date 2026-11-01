<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CodeQuest - Student Registration</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.container {
    background: #1e293b;
    padding: 30px;
    width: 350px;
    border-radius: 12px;
}

h2 {
    text-align: center;
    color: #38bdf8;
}

input {
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    box-sizing: border-box;
    border: none;
    border-radius: 5px;
}

button {
    width: 100%;
    padding: 12px;
    background: #0ea5e9;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
}

.message {
    text-align: center;
    color: #f87171;
}
</style>
</head>

<body>

<div class="container">

<h2>Join CodeQuest</h2>

<%
String message = (String) request.getAttribute("message");
if (message != null) {
%>
<p class="message"><%= message %></p>
<%
}
%>

<form action="register" method="post">

    <input type="text" name="username"
        placeholder="Username" required>

    <input type="email" name="email"
        placeholder="Email Address" required>

    <input type="password" name="password"
        placeholder="Password" required>

    <input type="password" name="confirmPassword"
        placeholder="Confirm Password" required>

    <button type="submit">Register</button>

</form>

<p style="text-align:center">
Already registered?
<a href="login.jsp" style="color:#38bdf8">Login</a>
</p>

</div>

</body>
</html>
