package controller;

import dao.UserDAO;
import model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = userDAO.getUserByEmail(email);
            if (user != null && user.getPassword().equals(password)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);       
                session.setAttribute("userId", user.getId()); 
                response.sendRedirect("schedule");
            } else {
                response.sendRedirect("invalidLogin.jsp?error=Invalid credentials");
            }
        } catch (SQLException e) {
            response.sendRedirect("login.jsp?error=Something Wrong Happened");
        }
    }
}
