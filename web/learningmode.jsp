<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pilih Mode Pembelajaran</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                background-color: #f1f5f9;
                margin: 0;
                padding: 20px;
                color: #333;
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 40px;
                font-size: 32px;
                font-weight: 800;
            }
            .container {
                max-width: 1000px;
                margin: 0 auto;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                gap: 30px;
            }
            .mode-card {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
                padding: 30px;
                flex: 1 1 calc(45% - 30px);
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                overflow: hidden;
            }
            .mode-card:hover {
                transform: scale(1.05);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            }
            .mode-title {
                font-size: 24px;
                color: #2d3e50;
                margin-bottom: 15px;
                font-weight: 700;
            }
            .mode-description {
                font-size: 16px;
                color: #7f8c8d;
                margin-bottom: 25px;
                line-height: 1.6;
                text-align: left;
            }
            .mode-button {
                background-color: #4C5D6E;
                color: #fff;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 18px;
                font-weight: 600;
                transition: background-color 0.3s;
            }
            .mode-button:hover {
                background-color: #2D3F51;
            }
            .back-button {
                background-color: #3498db;
                color: #fff;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 18px;
                font-weight: 600;
                margin-top: 30px;
                transition: background-color 0.3s;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
            .back-button:hover {
                background-color: #2980b9;
            }
            @media (max-width: 768px) {
                .mode-card {
                    flex: 1 1 100%;
                }
                .container {
                    gap: 20px;
                }
            }
        </style>
    </head>
    <body>
        <h1>Pilih Mode Pembelajaran Anda</h1>

        <div class="container">
            <!-- Pomodoro Mode -->
            <form action="pomodoroservlet" method="post" class="mode-card">
                <div class="mode-title">Mode Pomodoro</div>
                <div class="mode-description">
                    Teknik Pomodoro dirancang untuk meningkatkan fokus dan produktivitas Anda. Cara kerjanya:
                    <ul>
                        <li><strong>Belajar selama 25 menit</strong>: Fokus pada tugas yang ada tanpa gangguan.</li>
                        <li><strong>Istirahat 5 menit</strong>: Berikan waktu untuk memulihkan energi dan menjaga pikiran tetap segar.</li>
                        <li><strong>Ulangi siklus tersebut</strong></li>
                    </ul>
                </div>
                <button type="submit" name="mode" value="PomodoroMode" class="mode-button">
                    Mulai Mode Pomodoro
                </button>
            </form>

            <!-- Checklist Mode -->
            <form action="checklist" method="post" class="mode-card">
                <div class="mode-title">Mode Checklist</div>
                <div class="mode-description">
                    Mode Checklist membantu Anda untuk lebih terorganisir dan produktif. Berikut cara kerjanya:
                    <ul>
                        <li><strong>Tuliskan topik yang akan dilakukan</strong>: Buat daftar pekerjaan yang perlu diselesaikan.</li>
                        <li><strong>Atur waktu untuk topik</strong>: Tandai setiap tugas yang sudah selesai, agar lebih terstruktur.</li>
                    </ul>
                    Dengan sistem checklist ini, Anda dapat melacak setiap pencapaian, menjadikan pekerjaan terasa lebih ringan dan terkontrol.
                </div>
                <button type="submit" name="mode" value="ChecklistMode" class="mode-button">
                    Mulai Mode Checklist
                </button>
            </form>
        </div>

        <button class="back-button" onclick="window.history.back();">
            Kembali ke Jadwal
        </button>
    </body>
</html>
