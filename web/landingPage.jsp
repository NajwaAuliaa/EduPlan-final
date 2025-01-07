<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <title>EduPlan Landing Page</title>
        <style>
            body {
                margin: 0;
                font-family: 'Montserrat', sans-serif;
                background-color: #f6f5f7;
            }

            #landing {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 60px 100px;
                background: linear-gradient(to bottom right, #f6f5f7, #2D3F51);
                color: white;
                height: 100vh;
            }

            /* Left Content */
            .landing-content {
                flex: 1;
                max-width: 650px;
            }

            .landing-content .logo {
                display: flex;
                align-items: center;
                margin-bottom: 30px;
            }

            .landing-content .logo img {
                width: 60px;
                height: 60px;
                margin-right: 15px;
            }

            .landing-content h1 {
                font-size: 3.5rem;
                margin: 20px 0;
            }

            .landing-content p {
                font-size: 1.3rem;
                margin-bottom: 30px;
                color: rgba(255, 255, 255, 0.8);
            }

            .landing-buttons a {
                display: inline-block;
                padding: 15px 30px;
                margin-right: 20px;
                font-size: 1.2rem;
                text-decoration: none;
                color: white;
                border-radius: 5px;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            .btn-link {
                background-color: transparent;
                color: white;
                border: 2px solid white;
            }

            .btn-link:hover {
                background-color: white;
                color: #2D3F51;
            }

            /* Right Section */
            .landing-image {
                flex: 1;
                text-align: center;
            }

            .landing-image img {
                max-width: 80%;
                height: auto;
                border-radius: 15px;
            }
        </style>
    </head>
    <body>
        <section id="landing">
            <!-- Left Section -->
            <div class="landing-content">
                <h1>Selamat Datang</h1>
                <p>Atur jadwal harianmu dengan mudah dan raih semua tujuanmu dengan lebih terorganisir.</p>
                <div class="landing-buttons">
                    <a href="login.jsp" class="btn btn-primary">Mulai Mengatur Jadwal</a>
                </div>
            </div>

            <!-- Right Section -->
            <div class="landing-image">
                <img src="gambar/EduplanLogo.png" alt="Eduplan Logo">
            </div>
        </section>
    </body>
</html>
