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
%>

<!DOCTYPE html>

<html>
<head>
<title>Add Coding Mission</title>

<style>
body {
    background: #101827;
    color: white;
    font-family: Arial;
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

input, textarea, select {
    width: 100%;
    padding: 12px;
    margin: 10px 0 18px;
    box-sizing: border-box;
    border-radius: 7px;
    border: none;
}

button {
    width: 100%;
    padding: 13px;
    background: #0ea5e9;
    color: white;
    border: none;
    border-radius: 7px;
    cursor: pointer;
}
</style>
</head>

<body>

<div class="container">

<h1>➕ Add New Mission</h1>

<form action="addMission" method="post">

    <label>Mission Title</label>
    <input type="text" name="title" required>

    <label>Description</label>
    <textarea name="description" rows="4" required></textarea>

    <label>Category</label>
    <select name="category" required>
        <option value="Java">Java</option>
        <option value="Python">Python</option>
        <option value="C">C</option>
        <option value="DSA">DSA</option>
    </select>

    <label>Difficulty</label>
    <select name="difficulty" required>
        <option value="Easy">Easy</option>
        <option value="Medium">Medium</option>
        <option value="Hard">Hard</option>
    </select>

    <label>XP Reward</label>
    <input type="number" name="xp_reward"
           min="1" max="1000" required>
     <label>Question</label>
<textarea name="question" placeholder="Enter your question" required></textarea>

<label>Option A</label>
<input type="text" name="optionA" required>

<label>Option B</label>
<input type="text" name="optionB" required>

<label>Option C</label>
<input type="text" name="optionC" required>

<label>Option D</label>
<input type="text" name="optionD" required>

<label>Correct Answer</label>
<select name="correctAnswer" required>
    <option value="">Select Correct Answer</option>
    <option value="A">Option A</option>
    <option value="B">Option B</option>
    <option value="C">Option C</option>
    <option value="D">Option D</option>
</select>

    <button type="submit">Create Mission</button>

</form>

<br>

<a href="adminDashboard.jsp"
   style="color:#38bdf8;">Back to Admin Dashboard</a>

</div>

</body>
</html>