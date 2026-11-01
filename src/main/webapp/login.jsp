<%@ page import="jakarta.servlet.ServletException" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
<title>CodeQuest - Student Login</title>
<style>
body {
    background: #101827;
    color: white;
    font-family: Arial;
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
    color: #38bdf8;
    text-align: center;
}
input {
    width: 100%;
    padding: 12px;
    margin: 12px 0;
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
}
</style>
</head>
<body>
<div class="container">
    <h2>Welcome to CodeQuest</h2>
    <%
String message = (String) request.getAttribute("message");

if (message != null) {
%>

<p style="color:#ff6b6b;text-align:center">
    <%= message %>
</p>

<%
}
%>

    <form action="login" method="post" autocomplete="off">
       <input type="text" name="username"
       placeholder="Username" autocomplete="off" required>

<input type="password" name="password"
       placeholder="Password" autocomplete="new-password" required>

        <button type="submit">Login</button>
    </form>

    <p style="text-align:center">
        New student?
        <a href="register.jsp" style="color:#38bdf8">
            Register
        </a>
    </p>
</div>
</body>
</html>
