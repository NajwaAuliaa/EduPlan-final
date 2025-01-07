<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <title>Pomodoro Timer</title>
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
            input[type="number"] {
                padding: 10px;
                font-size: 16px;
                width: 100%;
                border-radius: 5px;
                border: 1px solid #ccc;
                margin: 10px 0;
                box-sizing: border-box;
            }
            label {
                font-size: 18px;
                color: #333;
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
        <h1>Pengatur Waktu Pomodoro</h1>

        <div class="container">
            <div class="timer" id="timer-display">00:00</div>

            <div class="status" id="status-display">Tetapkan waktu belajar Anda untuk memulai!</div>

            <form action="pomodoroservlet" method="post">
                <label for="study-time">Masukkan Waktu Belajar (jam):</label>
                <input type="number" id="study-time" name="study-time" min="1" max="24" required>
                <button type="submit">Mulai Pengatur Waktu</button>
            </form>

            <a href="schedule"><i class="fas fa-arrow-left icon"></i>Kembali ke Jadwal</a>
        </div>

        <script>
            function fetchTimerUpdate() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "pomodoroservlet", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText);

                        if (response.timeLeft && !isNaN(response.timeLeft)) {
                            var timeLeft = parseInt(response.timeLeft);
                            var minutes = Math.floor(timeLeft / 60);
                            var seconds = timeLeft % 60;

                            document.getElementById("timer-display").textContent =
                                    String(minutes).padStart(2, '0') + ":" + String(seconds).padStart(2, '0');
                        } else {
                            document.getElementById("timer-display").textContent = "00:00";
                        }

                        document.getElementById("status-display").textContent = response.status;
                    }
                };
                xhr.send();
            }

            setInterval(fetchTimerUpdate, 100);
        </script>

    </body>
</html>
