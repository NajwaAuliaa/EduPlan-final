package controller;

import dao.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

@WebServlet("/signup")
public class SignupController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            if (userDAO.emailExists(email)) {
                response.sendRedirect("emailExist.jsp?error=Email sudah terdaftar. Silakan gunakan email lain.");
            } else {
                User user = new User();
                user.setEmail(email);
                user.setPassword(password);  

                userDAO.addUser(user);
                response.sendRedirect("login.jsp"); 
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Terjadi kesalahan. Silakan coba lagi.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
