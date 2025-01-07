package controller;

import dao.IActivityDAO;
import dao.ActivityDAO;
import model.Activity;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editActivity")
public class EditActivityController extends HttpServlet {
    private final IActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in to edit activities");
            return;
        }

        try {
            int activityId = Integer.parseInt(request.getParameter("activityId"));
            String activityName = request.getParameter("activityName");
            String dayOfWeek = request.getParameter("dayOfWeek");
            String startTime = request.getParameter("startTime");

            Activity activity = new Activity(activityId, userId, activityName, dayOfWeek, start);
            activityDAO.updateActivity(activity);
            response.sendRedirect("schedule");
        } catch (NumberFormatException e) {
            response.sendRedirect("schedule?error=Invalid input for activity");
        } catch (SQLException e) {
            throw new ServletException("Error updating activity", e);
        }
    }
}
