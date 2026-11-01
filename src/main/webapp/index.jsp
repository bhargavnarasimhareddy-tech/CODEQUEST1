<%@ page import="jakarta.servlet.ServletException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CodeQuest - Home</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: #101827;
    color: white;
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 8%;
    background: #1e293b;
}

.logo {
    font-size: 28px;
    font-weight: bold;
    color: #38bdf8;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin-left: 20px;
}

.hero {
    text-align: center;
    padding: 90px 20px;
    background: linear-gradient(135deg, #101827, #173454);
}

.hero h1 {
    font-size: 46px;
    color: #38bdf8;
}

.hero p {
    font-size: 18px;
    color: #cbd5e1;
    max-width: 650px;
    margin: 20px auto;
    line-height: 1.6;
}

.portals {
    display: flex;
    justify-content: center;
    gap: 30px;
    padding: 55px 20px;
    flex-wrap: wrap;
}

.card {
    background: #1e293b;
    width: 320px;
    padding: 35px 25px;
    text-align: center;
    border-radius: 15px;
    border: 1px solid #334155;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-8px);
    border-color: #38bdf8;
}

.card h2 {
    color: #38bdf8;
}

.card p {
    color: #cbd5e1;
    line-height: 1.5;
}

button {
    background: #0ea5e9;
    color: white;
    border: none;
    padding: 13px 28px;
    border-radius: 7px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 15px;
}

button:hover {
    background: #0284c7;
}

.features {
    text-align: center;
    padding: 40px 20px;
}

.features h2 {
    color: #38bdf8;
}

.feature-list {
    display: flex;
    justify-content: center;
    gap: 35px;
    flex-wrap: wrap;
    margin-top: 30px;
}

.feature {
    background: #1e293b;
    padding: 20px;
    width: 200px;
    border-radius: 10px;
}

footer {
    text-align: center;
    background: #1e293b;
    padding: 22px;
    color: #94a3b8;
    margin-top: 40px;
}

@media(max-width: 600px) {
    .hero h1 {
        font-size: 32px;
    }

    .navbar {
        padding: 18px;
    }
}
</style>
</head>

<body>

<nav class="navbar">

    <div class="logo">⚡ CodeQuest</div>

    <div>
        <a href="login.jsp">Student Login</a>
        <a href="adminLogin.jsp">Admin</a>
    </div>

</nav>

<section class="hero">

    <h1>Level Up Your Coding Skills!</h1>

    <p>
        Welcome to CodeQuest – an interactive programming
        learning platform. Learn programming, solve coding
        challenges, earn XP and compete with other students.
    </p>

    <h3>Choose Your Portal</h3>

</section>

<section class="portals">

    <div class="card">

        <h2>👨‍🎓 Student Portal</h2>

        <p>
            Start your coding journey! Practice programming,
            complete missions, earn experience points and
            climb the leaderboard.
        </p>

        <a href="login.jsp">
            <button>Student Login</button>
        </a>

        <br>

        <a href="register.jsp">
            <button>Create Student Account</button>
        </a>

    </div>

    <div class="card">

        <h2>🛠️ Admin Portal</h2>

        <p>
            Manage coding missions, update challenges,
            monitor registered students and view platform
            statistics.
        </p>

        <a href="adminLogin.jsp">
            <button>Admin Login</button>
        </a>

    </div>

</section>

<section class="features">

    <h2>Why Choose CodeQuest?</h2>

    <div class="feature-list">

        <div class="feature">
            <h3>💻 Practice</h3>
            <p>Solve programming missions.</p>
        </div>

        <div class="feature">
            <h3>⭐ Earn XP</h3>
            <p>Collect points and level up.</p>
        </div>

        <div class="feature">
            <h3>🏆 Compete</h3>
            <p>Climb the student leaderboard.</p>
        </div>

        <div class="feature">
            <h3>🎯 Achieve</h3>
            <p>Track your coding progress.</p>
        </div>

    </div>

</section>

<footer>
    <p>© 2026 CodeQuest | Learn • Code • Compete</p>
</footer>

</body>
</html>