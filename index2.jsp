
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.time.LocalDate,java.time.YearMonth,java.time.format.DateTimeFormatter" %>

<%
    LocalDate today = LocalDate.now();
    YearMonth currentMonth = YearMonth.now();

    String monthName = currentMonth.format(
        DateTimeFormatter.ofPattern("MMMM yyyy")
    );

    int daysInMonth = currentMonth.lengthOfMonth();
    int firstDay = currentMonth.atDay(1).getDayOfWeek().getValue();

    String[] weekdays = {
        "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", "Sunday"
    };
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Dashboard</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4f6fa;
    color: #333;
}

/* Main layout */
.container {
    display: flex;
    min-height: 100vh;
}

/* Sidebar */
.sidebar {
    width: 230px;
    background: #253858;
    color: white;
    padding: 25px 15px;
}

.logo {
    font-size: 23px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 40px;
}

.sidebar ul {
    list-style: none;
}

.sidebar ul li {
    padding: 15px;
    margin-bottom: 8px;
    border-radius: 6px;
    cursor: pointer;
}

.sidebar ul li:hover,
.sidebar ul li.active {
    background: #3e5b89;
}

.sidebar ul li a {
    color: white;
    text-decoration: none;
    display: block;
}

/* Main content */
.main-content {
    flex: 1;
    padding: 25px;
    min-width: 0;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 15px;
}

.header h1 {
    font-size: 26px;
    color: #253858;
}

.profile {
    background: white;
    padding: 12px 18px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

/* Welcome section */
.welcome {
    background: linear-gradient(120deg, #4169a8, #668bd0);
    color: white;
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 25px;
}

.welcome h2 {
    margin-bottom: 10px;
}

/* Dashboard cards */
.cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 25px;
}

.card {
    background: white;
    padding: 22px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.card h3 {
    font-size: 15px;
    color: #777;
    margin-bottom: 12px;
}

.card h2 {
    font-size: 28px;
    color: #253858;
}

.card p {
    color: #888;
    margin-top: 8px;
    font-size: 13px;
}

/* Content columns */
.content-grid {
    display: grid;
    grid-template-columns: 1.1fr 1fr;
    gap: 20px;
    align-items: start;
}

.section {
    background: white;
    padding: 22px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    margin-bottom: 20px;
}

.section h2 {
    color: #253858;
    font-size: 19px;
    margin-bottom: 20px;
}

/* Calendar */
.calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.calendar-header h3 {
    color: #253858;
}

.calendar {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 8px;
    text-align: center;
}

.calendar div {
    padding: 12px 5px;
    border-radius: 6px;
    font-size: 14px;
}

.calendar .day-name {
    font-weight: bold;
    color: #777;
    background: #f4f6fa;
}

.calendar .date {
    background: #f7f8fb;
}

.calendar .today {
    background: #4169a8;
    color: white;
    font-weight: bold;
}

/* Meeting news */
.meeting-card {
    border-left: 4px solid #4169a8;
    background: #f8faff;
    padding: 16px;
    margin-bottom: 14px;
    border-radius: 6px;
}

.meeting-card h3 {
    font-size: 16px;
    color: #253858;
    margin-bottom: 8px;
}

.meeting-card p {
    font-size: 13px;
    color: #666;
    margin: 5px 0;
}

.meeting-status {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 11px;
    margin-top: 8px;
}

.upcoming {
    background: #e4efff;
    color: #2862aa;
}

.ongoing {
    background: #fff0d8;
    color: #b87512;
}

.completed {
    background: #e1f5e9;
    color: #23834c;
}

/* Activity */
.activity-item {
    padding: 13px 0;
    border-bottom: 1px solid #eee;
}

.activity-item:last-child {
    border-bottom: none;
}

.activity-item h3 {
    font-size: 14px;
    color: #253858;
    margin-bottom: 5px;
}

.activity-item p {
    font-size: 12px;
    color: #888;
}

/* Responsive design */
@media (max-width: 1000px) {
    .cards {
        grid-template-columns: repeat(2, 1fr);
    }

    .content-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 650px) {
    .container {
        display: block;
    }

    .sidebar {
        width: 100%;
    }

    .sidebar ul {
        display: flex;
        flex-wrap: wrap;
    }

    .sidebar ul li {
        margin-right: 5px;
    }

    .main-content {
        padding: 15px;
    }

    .cards {
        grid-template-columns: 1fr;
    }

    .calendar {
        gap: 3px;
    }

    .calendar div {
        padding: 9px 2px;
        font-size: 12px;
    }
}
</style>
</head>

<body>

<div class="container">

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo">EMS Portal</div>

        <ul>
            <li class="active"><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="employee.jsp">Employees</a></li>
            <li><a href="attendance.jsp">Attendance</a></li>
            <li><a href="leave.jsp">Leave Management</a></li>
            <li><a href="meetings.jsp">Meetings</a></li>
            <li><a href="reports.jsp">Reports</a></li>
            <li><a href="settings.jsp">Settings</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </aside>

    <!-- Main content -->
    <main class="main-content">

        <!-- Header -->
        <div class="header">
            <h1>Dashboard</h1>
            <div class="profile">
                Welcome, Admin
            </div>
        </div>

        <!-- Welcome -->
        <div class="welcome">
            <h2>Welcome to Employee Management System!</h2>
            <p>Manage employees, attendance, meetings and daily activities from one place.</p>
        </div>

        <!-- Dashboard cards -->
        <div class="cards">

            <div class="card">
                <h3>Total Employees</h3>
                <h2>120</h2>
                <p>Registered employees</p>
            </div>

            <div class="card">
                <h3>Present Today</h3>
                <h2>105</h2>
                <p>Employees present</p>
            </div>

            <div class="card">
                <h3>On Leave</h3>
                <h2>10</h2>
                <p>Employees on leave</p>
            </div>

            <div class="card">
                <h3>Pending Requests</h3>
                <h2>5</h2>
                <p>Requests awaiting approval</p>
            </div>

        </div>

        <!-- Main grid -->
        <div class="content-grid">

            <!-- Calendar -->
            <div class="section">

                <h2>Monthly Calendar</h2>

                <div class="calendar-header">
                    <h3><%= monthName %></h3>
                    <span>Today's date: <%= today %></span>
                </div>

                <div class="calendar">

                    <% for (String day : weekdays) { %>
                        <div class="day-name"><%= day.substring(0, 3) %></div>
                    <% } %>

                    <% for (int i = 1; i < firstDay; i++) { %>
                        <div></div>
                    <% } %>

                    <% for (int day = 1; day <= daysInMonth; day++) { %>

                        <% if (day == today.getDayOfMonth()) { %>
                            <div class="date today"><%= day %></div>
                        <% } else { %>
                            <div class="date"><%= day %></div>
                        <% } %>

                    <% } %>

                </div>
            </div>

            <!-- Meeting news -->
            <div class="section">

                <h2>📢 Meeting News & Updates</h2>

                <div class="meeting-card">
                    <h3>Project Review Meeting</h3>
                    <p>📅 Date: <%= today %></p>
                    <p>🕙 Time: 10:00 AM - 11:00 AM</p>
                    <p>📍 Location: Conference Room A</p>
                    <span class="meeting-status upcoming">Upcoming</span>
                </div>

                <div class="meeting-card">
                    <h3>Technical Team Meeting</h3>
                    <p>📅 Date: <%= today %></p>
                    <p>🕛 Time: 12:00 PM - 1:00 PM</p>
                    <p>📍 Location: Conference Room B</p>
                    <span class="meeting-status ongoing">Scheduled</span>
                </div>

                <div class="meeting-card">
                    <h3>Monthly Performance Meeting</h3>
                    <p>📅 Date: <%= today %></p>
                    <p>🕒 Time: 3:00 PM - 4:00 PM</p>
                    <p>📍 Location: Main Meeting Hall</p>
                    <span class="meeting-status completed">Completed</span>
                </div>

            </div>

        </div>

        <!-- Recent activity -->
        <div class="section">

            <h2>Recent Activities</h2>

            <div class="activity-item">
                <h3>New Employee Registered</h3>
                <p>A new employee was added to the system.</p>
            </div>

            <div class="activity-item">
                <h3>Attendance Updated</h3>
                <p>Today's employee attendance has been updated.</p>
            </div>

            <div class="activity-item">
                <h3>Leave Request Submitted</h3>
                <p>A new leave request is waiting for approval.</p>
            </div>

            <div class="activity-item">
                <h3>Meeting Scheduled</h3>
                <p>A new team meeting has been scheduled.</p>
            </div>

        </div>

    </main>

</div>

</body>
</html>




--------upadate1.6----------

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.Calendar,java.util.GregorianCalendar,java.text.SimpleDateFormat,java.util.Locale" %>

<%
    // ---- Java 1.6 compatible date handling (no java.time) ----
    Calendar today = Calendar.getInstance();

    Calendar monthCal = new GregorianCalendar(
        today.get(Calendar.YEAR),
        today.get(Calendar.MONTH),
        1
    );

    // Month + Year, e.g. "November 2026"
    SimpleDateFormat monthFmt = new SimpleDateFormat("MMMM yyyy", Locale.ENGLISH);
    String monthName = monthFmt.format(monthCal.getTime());

    int daysInMonth = monthCal.getActualMaximum(Calendar.DAY_OF_MONTH);

    // Calendar.DAY_OF_WEEK is Sunday=1 ... Saturday=7
    // Convert to Monday=1 ... Sunday=7
    int firstDaySundayBased = monthCal.get(Calendar.DAY_OF_WEEK);
    int firstDay = (firstDaySundayBased + 5) % 7 + 1;

    String[] weekdays = {
        "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", "Sunday"
    };

    int todayDate = today.get(Calendar.DAY_OF_MONTH);

    // Pretty date string for display
    SimpleDateFormat displayFmt = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
    String todayStr = displayFmt.format(today.getTime());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Dashboard</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4f6fa;
    color: #333;
}

/* Main layout */
.container {
    display: flex;
    min-height: 100vh;
}

/* Sidebar */
.sidebar {
    width: 230px;
    background: #253858;
    color: white;
    padding: 25px 15px;
}

.logo {
    font-size: 23px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 40px;
}

.sidebar ul {
    list-style: none;
}

.sidebar ul li {
    padding: 15px;
    margin-bottom: 8px;
    border-radius: 6px;
    cursor: pointer;
}

.sidebar ul li:hover,
.sidebar ul li.active {
    background: #3e5b89;
}

.sidebar ul li a {
    color: white;
    text-decoration: none;
    display: block;
}

/* Main content */
.main-content {
    flex: 1;
    padding: 25px;
    min-width: 0;
}

/* Header */
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 15px;
}

.header h1 {
    font-size: 26px;
    color: #253858;
}

.profile {
    background: white;
    padding: 12px 18px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
}

/* Welcome section */
.welcome {
    background: linear-gradient(120deg, #4169a8, #668bd0);
    color: white;
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 25px;
}

.welcome h2 {
    margin-bottom: 10px;
}

/* Dashboard cards */
.cards {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 25px;
}

.card {
    background: white;
    padding: 22px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.card h3 {
    font-size: 15px;
    color: #777;
    margin-bottom: 12px;
}

.card h2 {
    font-size: 28px;
    color: #253858;
}

.card p {
    color: #888;
    margin-top: 8px;
    font-size: 13px;
}

/* Content columns */
.content-grid {
    display: grid;
    grid-template-columns: 1.1fr 1fr;
    gap: 20px;
    align-items: start;
}

.section {
    background: white;
    padding: 22px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    margin-bottom: 20px;
}

.section h2 {
    color: #253858;
    font-size: 19px;
    margin-bottom: 20px;
}

/* Calendar */
.calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 18px;
}

.calendar-header h3 {
    color: #253858;
}

.calendar {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 8px;
    text-align: center;
}

.calendar div {
    padding: 12px 5px;
    border-radius: 6px;
    font-size: 14px;
}

.calendar .day-name {
    font-weight: bold;
    color: #777;
    background: #f4f6fa;
}

.calendar .date {
    background: #f7f8fb;
}

.calendar .today {
    background: #4169a8;
    color: white;
    font-weight: bold;
}

/* Meeting news */
.meeting-card {
    border-left: 4px solid #4169a8;
    background: #f8faff;
    padding: 16px;
    margin-bottom: 14px;
    border-radius: 6px;
}

.meeting-card h3 {
    font-size: 16px;
    color: #253858;
    margin-bottom: 8px;
}

.meeting-card p {
    font-size: 13px;
    color: #666;
    margin: 5px 0;
}

.meeting-status {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 11px;
    margin-top: 8px;
}

.upcoming {
    background: #e4efff;
    color: #2862aa;
}

.ongoing {
    background: #fff0d8;
    color: #b87512;
}

.completed {
    background: #e1f5e9;
    color: #23834c;
}

/* Activity */
.activity-item {
    padding: 13px 0;
    border-bottom: 1px solid #eee;
}

.activity-item:last-child {
    border-bottom: none;
}

.activity-item h3 {
    font-size: 14px;
    color: #253858;
    margin-bottom: 5px;
}

.activity-item p {
    font-size: 12px;
    color: #888;
}

/* Responsive design */
@media (max-width: 1000px) {
    .cards {
        grid-template-columns: repeat(2, 1fr);
    }

    .content-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 650px) {
    .container {
        display: block;
    }

    .sidebar {
        width: 100%;
    }

    .sidebar ul {
        display: flex;
        flex-wrap: wrap;
    }

    .sidebar ul li {
        margin-right: 5px;
    }

    .main-content {
        padding: 15px;
    }

    .cards {
        grid-template-columns: 1fr;
    }

    .calendar {
        gap: 3px;
    }

    .calendar div {
        padding: 9px 2px;
        font-size: 12px;
    }
}
</style>
</head>

<body>

<div class="container">

    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo">EMS Portal</div>

        <ul>
            <li class="active"><a href="dashboard.jsp">Dashboard</a></li>
            <li><a href="employee.jsp">Employees</a></li>
            <li><a href="attendance.jsp">Attendance</a></li>
            <li><a href="leave.jsp">Leave Management</a></li>
            <li><a href="meetings.jsp">Meetings</a></li>
            <li><a href="reports.jsp">Reports</a></li>
            <li><a href="settings.jsp">Settings</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </aside>

    <!-- Main content -->
    <main class="main-content">

        <!-- Header -->
        <div class="header">
            <h1>Dashboard</h1>
            <div class="profile">
                Welcome, Admin
            </div>
        </div>

        <!-- Welcome -->
        <div class="welcome">
            <h2>Welcome to Employee Management System!</h2>
            <p>Manage employees, attendance, meetings and daily activities from one place.</p>
        </div>

        <!-- Dashboard cards -->
        <div class="cards">

            <div class="card">
                <h3>Total Employees</h3>
                <h2>120</h2>
                <p>Registered employees</p>
            </div>

            <div class="card">
                <h3>Present Today</h3>
                <h2>105</h2>
                <p>Employees present</p>
            </div>

            <div class="card">
                <h3>On Leave</h3>
                <h2>10</h2>
                <p>Employees on leave</p>
            </div>

            <div class="card">
                <h3>Pending Requests</h3>
                <h2>5</h2>
                <p>Requests awaiting approval</p>
            </div>

        </div>

        <!-- Main grid -->
        <div class="content-grid">

            <!-- Calendar -->
            <div class="section">

                <h2>Monthly Calendar</h2>

                <div class="calendar-header">
                    <h3><%= monthName %></h3>
                    <span>Today's date: <%= todayStr %></span>
                </div>

                <div class="calendar">

                    <% for (int w = 0; w < weekdays.length; w++) { %>
                        <div class="day-name"><%= weekdays[w].substring(0, 3) %></div>
                    <% } %>

                    <% for (int i = 1; i < firstDay; i++) { %>
                        <div></div>
                    <% } %>

                    <% for (int day = 1; day <= daysInMonth; day++) { %>

                        <% if (day == todayDate) { %>
                            <div class="date today"><%= day %></div>
                        <% } else { %>
                            <div class="date"><%= day %></div>
                        <% } %>

                    <% } %>

                </div>
            </div>

            <!-- Meeting news -->
            <div class="section">

                <h2>&#128226; Meeting News &amp; Updates</h2>

                <div class="meeting-card">
                    <h3>Project Review Meeting</h3>
                    <p>&#128197; Date: <%= todayStr %></p>
                    <p>&#128336; Time: 10:00 AM - 11:00 AM</p>
                    <p>&#128205; Location: Conference Room A</p>
                    <span class="meeting-status upcoming">Upcoming</span>
                </div>

                <div class="meeting-card">
                    <h3>Technical Team Meeting</h3>
                    <p>&#128197; Date: <%= todayStr %></p>
                    <p>&#128336; Time: 12:00 PM - 1:00 PM</p>
                    <p>&#128205; Location: Conference Room B</p>
                    <span class="meeting-status ongoing">Scheduled</span>
                </div>

                <div class="meeting-card">
                    <h3>Monthly Performance Meeting</h3>
                    <p>&#128197; Date: <%= todayStr %></p>
                    <p>&#128336; Time: 3:00 PM - 4:00 PM</p>
                    <p>&#128205; Location: Main Meeting Hall</p>
                    <span class="meeting-status completed">Completed</span>
                </div>

            </div>

        </div>

        <!-- Recent activity -->
        <div class="section">

            <h2>Recent Activities</h2>

            <div class="activity-item">
                <h3>New Employee Registered</h3>
                <p>A new employee was added to the system.</p>
            </div>

            <div class="activity-item">
                <h3>Attendance Updated</h3>
                <p>Today's employee attendance has been updated.</p>
            </div>

            <div class="activity-item">
                <h3>Leave Request Submitted</h3>
                <p>A new leave request is waiting for approval.</p>
            </div>

            <div class="activity-item">
                <h3>Meeting Scheduled</h3>
                <p>A new team meeting has been scheduled.</p>
            </div>

        </div>

    </main>

</div>

</body>
</html>
