<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Tidak Valid</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="error-container">
        <h1><i class="fas fa-times-circle"></i> Email atau Password Tidak Valid</h1>
        <p>Email atau kata sandi yang Anda masukkan salah. Silakan coba lagi.</p>
        <a href="login.jsp">
            <button class="error-btn"><i class="fas fa-arrow-left"></i> Kembali ke Halaman Login</button>
        </a>
    </div>
</body>
</html>
