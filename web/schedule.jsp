<%@page import="java.util.List"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="model.Activity"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Weekly Schedule</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,800">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f6f5f7;
            color: #2C3E50;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #2D3F51;
            margin-bottom: 20px;
            font-size: 2.5rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 15px;
            text-align: center;
            vertical-align: top;
            font-size: 14px;
        }

        th {
            background-color: #3E4F60;
            color: white;
            font-size: 16px;
        }

        td {
            background-color: #F9FAFB;
            transition: background-color 0.3s;
        }

        td:hover {
            background-color: #E3EDF5;
        }

        td.no-activities {
            color: #999;
            font-style: italic;
        }

        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        button {
            background-color: #4C5D6E;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #2D3F51;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .logout-btn {
            display: inline-block;
            text-decoration: none;
            color: #fff;
            background-color: #3498db;
            padding: 10px 15px;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        a {
            display: inline-block;
            margin-top: 10px;
            color: #3B4C5D;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #2D3F51;
        }
    </style>
</head>
<body>
    <h1><i class="fas fa-calendar-week"></i> Jadwal Mingguan</h1>

    <table>
        <thead>
            <tr>
                <th>Senin</th>
                <th>Selasa</th>
                <th>Rabu</th>
                <th>Kamis</th>
                <th>Jumat</th>
                <th>Sabtu</th>
                <th>Minggu</th>
            </tr>
        </thead>
        <script>
            function confirmDelete() {
                return confirm("Apakah Anda yakin ingin menghapus aktivitas ini? Tindakan ini tidak dapat dibatalkan.");
            }
        </script>

        <tbody>
            <tr>
                <%-- Initialize empty schedules for each day --%>
                <% 
                    String[] daysOfWeek = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
                    String[] schedules = new String[7];
                    for (int i = 0; i < schedules.length; i++) {
                        schedules[i] = ""; // Default to empty
                    }

                    List<Activity> activities = (List<Activity>) request.getAttribute("activities");

                    if (activities != null) {
                        Collections.sort(activities, new Comparator<Activity>() {
                            @Override
                            public int compare(Activity a1, Activity a2) {
                                try {
                                    Date time1 = new SimpleDateFormat("HH:mm:ss").parse(a1.getStartTime());
                                    Date time2 = new SimpleDateFormat("HH:mm:ss").parse(a2.getStartTime());
                                    return time1.compareTo(time2);
                                } catch (ParseException e) {
                                    return a1.getStartTime().compareTo(a2.getStartTime());
                                }
                            }
                        });

                        for (Activity activity : activities) {
                            String dayOfWeek = activity.getDayOfWeek();
                            String rawStartTime = activity.getStartTime();
                            String formattedStartTime;

                            try {
                                Date parsedTime = new SimpleDateFormat("HH:mm:ss").parse(rawStartTime);
                                formattedStartTime = new SimpleDateFormat("HH:mm").format(parsedTime);
                            } catch (ParseException e) {
                                formattedStartTime = rawStartTime;
                            }

                            String activityDetails = "<strong>" + activity.getActivityName() + "</strong><br>" +
                                    formattedStartTime + "<br>" +
                                    "<div class='button-group'>" +
                                    "<form action='deleteActivity' method='post' style='display:inline;' onsubmit='return confirmDelete();'>" +
                                    "<input type='hidden' name='activityId' value='" + activity.getId() + "'>" +
                                    "<button type='submit'><i class='fas fa-trash'></i> Hapus</button>" +
                                    "</form>" +
                                    "<form action='editActivity.jsp' method='get' style='display:inline;'>" +
                                    "<input type='hidden' name='activityId' value='" + activity.getId() + "'>" +
                                    "<input type='hidden' name='activityName' value='" + activity.getActivityName() + "'>" +
                                    "<input type='hidden' name='dayOfWeek' value='" + activity.getDayOfWeek() + "'>" +
                                    "<input type='hidden' name='startTime' value='" + formattedStartTime + "'>" +
                                    "<button type='submit'><i class='fas fa-edit'></i> Edit</button>" +
                                    "</form>" +
                                    "</div>";

                            for (int i = 0; i < daysOfWeek.length; i++) {
                                if (dayOfWeek.equalsIgnoreCase(daysOfWeek[i])) {
                                    schedules[i] += activityDetails + "<br><br>";
                                    break;
                                }
                            }
                        }
                    }

                    for (String schedule : schedules) {
                        if (schedule.isEmpty()) {
                            out.println("<td class='no-activities'>Tidak Ada Aktivitas</td>");
                        } else {
                            out.println("<td>" + schedule + "</td>");
                        }
                    }
                %>
            </tr>
        </tbody>
    </table>

    <a href="addActivity.jsp"><i class="fas fa-plus-circle"></i> Tambahkan Aktivitas</a>
    <br><br>
    <a href="learningmode.jsp" class="logout-btn"><i class="fas fa-play-circle"></i> Mulai Mode Pembelajaran</a>
    <br><br>
    <a href="login.jsp" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Keluar</a>
</body>
</html>