<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <title>Login</title>
</head>
<body>
    <div class="container" id="container">
        <div class="form-container sign-up-container">
            <form action="signup" method="post">
                <h1>Buat Akun</h1>
                <input type="email" name="email" placeholder="Email" required />
                <input type="password" name="password" placeholder="Kata Sandi" required />
                <button type="submit">Daftar</button>
            </form>
        </div>
        <div class="form-container sign-in-container">
            <form action="login" method="post">
                <h1>Login</h1>
                <input type="email" name="email" placeholder="Email" required />
                <input type="password" name="password" placeholder="Kata Sandi" required />
                <button type="submit">Masuk</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>Selamat Datang Kembali!</h1>
                    <p>Masuk dan lanjutkan mengatur jadwal Anda dengan EduPlan</p>
                    <button class="ghost" id="signIn">Masuk</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>Halo, Pengguna Baru!</h1>
                    <p>Atur jadwal Anda dengan mudah bersama EduPlan. Daftar sekarang untuk memulai!</p>
                    <button class="ghost" id="signUp">Daftar</button>
                </div>
            </div>
        </div>
    </div>
    <script src="script.js"></script>
    
</body>
</html>
