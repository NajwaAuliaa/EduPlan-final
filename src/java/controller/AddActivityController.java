package controller;

import dao.ActivityDAO;
import dao.IActivityDAO;
import model.Activity;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/addActivity")
public class AddActivityController extends HttpServlet {
    private final IActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in to add activities");
            return;
        }

        String activityName = request.getParameter("activityName");
        String dayOfWeek = request.getParameter("dayOfWeek");
        String startTime = request.getParameter("startTime");

        try {
            Activity activity = new Activity(0, userId, activityName, dayOfWeek, startTime);
            activityDAO.addActivity(activity);
            response.sendRedirect("schedule");
        } catch (SQLException e) {
            throw new ServletException("Error adding activity", e);
        }
    }
}

