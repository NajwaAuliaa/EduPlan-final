<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ListTopic" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <title>Checklist Mode</title>
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                text-align: center;
                background-color: #f4f7fc;
                margin: 0;
                padding: 0;
            }
            h1 {
                color: #333;
                margin-top: 50px;
                font-size: 36px;
            }
            .container {
                background: white;
                border-radius: 10px;
                padding: 30px;
                max-width: 500px;
                margin: 50px auto;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }
            .timer {
                font-size: 60px;
                color: #2196F3;
                margin: 20px 0;
                font-weight: bold;
            }
            .status {
                font-size: 24px;
                color: #666;
                margin-bottom: 20px;
            }
            button {
                background-color: #6A7F92;
                color: white;
                padding: 10px 20px;
                margin: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            button:hover {
                background-color: #2D3F51;
            }
            input[type="number"], input[type="text"] {
                padding: 10px;
                font-size: 16px;
                width: 100%;
                border-radius: 5px;
                border: 1px solid #ccc;
                margin: 10px 0;
                box-sizing: border-box;
            }
            .activity-list {
                margin-top: 20px;
                text-align: left;
            }
            .activity-item {
                margin: 5px 0;
                font-size: 18px;
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
            .activity-item.completed {
                text-decoration: line-through;
                color: gray;
            }
        </style>
    </head>
    <body>
        <h1>Checklist Mode</h1>

        <div class="container">
            <!-- Timer display -->
            <div class="timer" id="timer-display">00:00</div>

            <!-- Status message -->
            <div class="status" id="status-display"></div>

            <!-- Form to input new activity -->
            <%
                Boolean activitiesStarted = (Boolean) session.getAttribute("activitiesStarted");
                if (activitiesStarted == null) {
                    activitiesStarted = false;
                }
            %>

            <% if (!activitiesStarted) { %>
            <!-- Form to input new activity -->
            <h2>Masukkan Topik Baru</h2>
            <form method="post" action="checklist">
                <label for="activityName">Nama Topik:</label>
                <input type="text" name="activityName" required><br>
                <label for="duration">Durasi (menit):</label>
                <input type="number" name="duration" required><br>
                <button type="submit" name="action" value="addActivity">Tambahkan Aktivitas</button>
            </form>
            <% } else { %>
            <p>Topik telah dimulai. Kembali ke jadwal untuk mengulang topik</p>
            <% } %>


            <!-- List of Activities -->
            <h2>Daftar Topik</h2>
            <div class="activity-list">
                <form method="post" action="checklist">
                    <%
                        List<ListTopic> activities = (List<ListTopic>) request.getAttribute("activities");
                        if (activities != null) {
                            for (ListTopic activity : activities) {
                                boolean isCompleted = activity.isCompleted();
                    %>
                    <div class="activity-item <%= isCompleted ? "completed" : ""%>">
                        <input type="checkbox" name="activities" value="<%= activity.getTopicName()%>" <%= isCompleted ? "disabled" : ""%>>
                        <label><%= activity.getTopicName()%> - <%= activity.getDuration()%> minutes <%= isCompleted ? "(Completed)" : ""%></label>
                    </div>

                    <%
                            }
                        }
                    %>
                    <button type="submit" name="action" value="startTimer">Mulai</button>
                </form>
            </div>

            <!-- Back to Schedule button -->
            <a href="checklist?action=clearAndRedirect" id="backToSchedule"><i class="fas fa-arrow-left icon"></i>Kembali ke Jadwal</a>

        </div>

        <script>
            let timeLeft = 0;
            let timerRunning = false;


            function updateTimerDisplay() {
                const minutes = Math.floor(timeLeft / 60);
                const seconds = timeLeft % 60;
                document.getElementById("timer-display").textContent =
                        String(minutes).padStart(2, '0') + ":" + String(seconds).padStart(2, '0');

                if (timeLeft === 0 && timerRunning) {
                    document.getElementById("status-display").textContent = "Topik Selanjutnya";
                    setTimeout(function() {
                        location.reload();
                    }, 1000); // ini milidetik (1 detik)

                } else if (timeLeft === 0 && !timerRunning) {
                    document.getElementById("status-display").textContent = "Waktu telah berhenti!";
                }
            }

            function fetchTimerUpdate() {
                const xhr = new XMLHttpRequest();
                xhr.open("GET", "checklist", true);
                xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        const response = JSON.parse(xhr.responseText);
                        timeLeft = response.timeLeft || 0;
                        timerRunning = response.timerRunning || false;
                        updateTimerDisplay();
                    }
                };
                xhr.send();
            }

            function goToNextActivity() {
                const xhr = new XMLHttpRequest();
                xhr.open("POST", "checklist", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        fetchTimerUpdate();
                    }
                };
                xhr.send("action=nextActivity");
            }

            function startClientTimer() {
                setInterval(function () {
                    if (timerRunning && timeLeft > 0) {
                        timeLeft--;
                        updateTimerDisplay();
                    } else if (timeLeft === 0 && timerRunning) {
                        updateTimerDisplay();
                        goToNextActivity();
                    }
                }, 1000);
            }
            
            fetchTimerUpdate();
            startClientTimer();
        </script>
    </body>
</html>
