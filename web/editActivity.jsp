<%@page import="model.Activity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Activity</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f6f5f7;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 400px;
            width: 100%;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }
        input, select, button {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            background-color: #6A7F92;
            color: #fff;
            font-size: 16px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #2D3F51;
        }
        a {
            display: block;
            text-align: center;
            text-decoration: none;
            color: #3B4C5D;
            font-weight: bold;
            margin-top: 10px;
        }
        a:hover {
            text-decoration: underline;
        }
        .icon {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-edit icon"></i>Edit Aktivitas</h1>
        <form action="editActivity" method="post">
            <input type="hidden" name="activityId" value="<%= request.getParameter("activityId") %>">
            
            <label for="activityName">Nama Aktivitas:</label>
            <input type="text" id="activityName" name="activityName" 
                   value="<%= request.getParameter("activityName") %>" required>

            <label for="dayOfWeek">Hari:</label>
            <select id="dayOfWeek" name="dayOfWeek" required>
                <option value="Monday" <%= "Monday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Senin</option>
                <option value="Tuesday" <%= "Tuesday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Selasa</option>
                <option value="Wednesday" <%= "Wednesday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Rabu</option>
                <option value="Thursday" <%= "Thursday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Kamis</option>
                <option value="Friday" <%= "Friday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Jumat</option>
                <option value="Saturday" <%= "Saturday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Sabtu</option>
                <option value="Sunday" <%= "Sunday".equals(request.getParameter("dayOfWeek")) ? "selected" : "" %>>Minggu</option>
            </select>

            <label for="startTime">Waktu Mulai:</label>
            <input type="time" id="startTime" name="startTime" 
                   value="<%= request.getParameter("startTime") %>" required>

            <button type="submit"><i class="fas fa-save icon"></i>Pembaruan Aktivitas</button>
        </form>
        <a href="schedule"><i class="fas fa-arrow-left icon"></i>Kembali ke </a>
    </div>
</body>
</html>
