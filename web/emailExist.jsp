<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Already Exists</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="error-container">
        <h1><i class="fas fa-exclamation-circle"></i> Email Sudah Terdaftar</h1>
        <p>Email yang Anda berikan sudah terdaftar. Gunakan email lain atau masuk jika Anda sudah punya akun.</p>
        <a href="login.jsp">
            <button class="error-btn"><i class="fas fa-sign-in-alt"></i> Kembali ke Halaman Login</button>
        </a>
    </div>
</body>
</html>
