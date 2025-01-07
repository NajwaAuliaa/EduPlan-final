package controller;

import model.ListTopic;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/checklist")
public class checklistController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("clearAndRedirect".equals(action)) {
            ListTopic.getAllTopics().clear();
            HttpSession session = request.getSession();
            session.removeAttribute("timeLeft");
            session.removeAttribute("timerRunning");
            session.removeAttribute("currentActivityIndex");
            session.setAttribute("activitiesStarted", false);
            response.sendRedirect("schedule");
            return;
        }
        
        HttpSession session = request.getSession();
        Integer timeLeft = (Integer) session.getAttribute("timeLeft");
        Boolean timerRunning = (Boolean) session.getAttribute("timerRunning");
        Integer currentTopicIndex = (Integer) session.getAttribute("currentActivityIndex");

        if (timeLeft == null) {
            timeLeft = 0;
            session.setAttribute("timeLeft", timeLeft);
        }
        if (timerRunning == null) {
            timerRunning = false;
            session.setAttribute("timerRunning", timerRunning);
        }
        if (currentTopicIndex == null) {
            currentTopicIndex = 0;
            session.setAttribute("currentActivityIndex", currentTopicIndex);
        }

        List<ListTopic> topics = ListTopic.getAllTopics();
        request.setAttribute("activities", topics);
        request.setAttribute("timeLeft", timeLeft);
        request.setAttribute("timerRunning", timerRunning);

        String requestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(requestedWith);
        if (isAjax) {
            response.setContentType("application/json");
            response.getWriter().write("{" +
                    "\"timeLeft\": " + timeLeft + ", " +
                    "\"timerRunning\": " + timerRunning +
                    "}");
        } else {
            request.getRequestDispatcher("/checklist.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("addActivity".equals(action)) {
            Boolean topicsStarted = (Boolean) session.getAttribute("activitiesStarted");
            if (topicsStarted != null && topicsStarted) {
                response.sendRedirect("checklist"); // Redirect if topics have started
                return;
            }
            String topicName = request.getParameter("activityName");
            int duration = Integer.parseInt(request.getParameter("duration"));
            ListTopic.addTopic(topicName, duration);
        }

        if ("startTimer".equals(action)) {
            List<ListTopic> allTopics = ListTopic.getAllTopics().stream()
                .filter(activity -> !activity.isCompleted())
                .collect(Collectors.toList());

            if (!allTopics.isEmpty()) {
                session.setAttribute("timeLeft", allTopics.get(0).getDuration() * 60);
                session.setAttribute("timerRunning", true);
                session.setAttribute("currentActivityIndex", 0);
                session.setAttribute("activitiesStarted", true); // Mark topics as started
                for (ListTopic topic : allTopics) {
                    topic.setChecked(true);
                }
            }
        }

        if ("nextActivity".equals(action)) {
            List<ListTopic> checkedTopics = ListTopic.getCheckedTopics();
            Integer currentTopicIndex = (Integer) session.getAttribute("currentActivityIndex");

            if (currentTopicIndex == null) {
                currentTopicIndex = 0;
            }

            if (currentTopicIndex < checkedTopics.size()) {
                checkedTopics.get(currentTopicIndex).setCompleted(true);
            }

            if (currentTopicIndex + 1 < checkedTopics.size()) {
                session.setAttribute("currentActivityIndex", currentTopicIndex + 1);
                session.setAttribute("timeLeft", checkedTopics.get(currentTopicIndex + 1).getDuration() * 60);
            } else {
                session.setAttribute("timerRunning", false);
                session.setAttribute("timeLeft", 0);
            }
        }
        response.sendRedirect("checklist");
    }
}
