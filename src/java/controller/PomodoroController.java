package controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/pomodoroservlet")
public class PomodoroController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String studyTimeInput = request.getParameter("study-time");
        if (studyTimeInput != null) {
            try {
                int studyTimeInSeconds = Integer.parseInt(studyTimeInput) * 3600; //Jam ke detik
                session.setAttribute("studyTimeLeft", studyTimeInSeconds);
                session.setAttribute("isBreak", false);
                session.setAttribute("status", "Focus Time");
            } catch (NumberFormatException e) {
                session.setAttribute("studyTimeLeft", 0);
                session.setAttribute("status", "Invalid input. Please try again.");
            }
        }
        response.sendRedirect("pomodoro.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("reset".equals(action)) {
            session.removeAttribute("studyTimeLeft");
            session.removeAttribute("currentIntervalTime");
            session.removeAttribute("isBreak");
            session.removeAttribute("status");
            response.sendRedirect("schedule");
            return;
        }

        Integer studyTimeLeft = (Integer) session.getAttribute("studyTimeLeft");
        Boolean isBreak = (Boolean) session.getAttribute("isBreak");
        String status = (String) session.getAttribute("status");
        Integer currentIntervalTime = (Integer) session.getAttribute("currentIntervalTime");

        if (studyTimeLeft == null) studyTimeLeft = 0;
        if (isBreak == null) isBreak = false;
        if (status == null) status = "Tetapkan waktu belajar Anda untuk memulai!";
        if (currentIntervalTime == null) currentIntervalTime = 1500; 
        int focusInterval = 1500; // 25 menit fokus
        int breakInterval = 300;  // 5 menit istirhat

        if (studyTimeLeft > 0 && currentIntervalTime > 0) {
            studyTimeLeft--;
            currentIntervalTime--;
            session.setAttribute("studyTimeLeft", studyTimeLeft);
            session.setAttribute("currentIntervalTime", currentIntervalTime);

            if (currentIntervalTime == 0) {
                isBreak = !isBreak;
                session.setAttribute("isBreak", isBreak);
                currentIntervalTime = isBreak ? breakInterval : focusInterval;
                session.setAttribute("currentIntervalTime", currentIntervalTime);

                status = isBreak ? "Break Time" : "Focus Time";
                session.setAttribute("status", );
            }
        }

        response.setContentType("application/json");
        StringBuilder jsonResponse = new StringBuilder();
        jsonResponse.append("{")
                .append("\"timeLeft\": \"").append(studyTimeLeft).append("\", ")
                .append("\"status\": \"").append(status).append("\"")
                .append("}");
        response.getWriter().write(jsonResponse.toString());
    }
}
