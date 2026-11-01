
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*,java.text.*,java.time.*,java.time.format.*" %>

<%
    // Get today's date
    LocalDate today = LocalDate.now();

    int month = today.getMonthValue();
    int year = today.getYear();

    // Read month and year from URL
    try {
        if (request.getParameter("month") != null) {
            month = Integer.parseInt(request.getParameter("month"));
        }

        if (request.getParameter("year") != null) {
            year = Integer.parseInt(request.getParameter("year"));
        }
    } catch (Exception e) {
        month = today.getMonthValue();
        year = today.getYear();
    }

    // Validate month and year
    if (month < 1 || month > 12 || year < 1900 || year > 9999) {
        month = today.getMonthValue();
        year = today.getYear();
    }

    YearMonth currentMonth = YearMonth.of(year, month);

    LocalDate firstDay = currentMonth.atDay(1);

    int daysInMonth = currentMonth.lengthOfMonth();

    int startDay = firstDay.getDayOfWeek().getValue() % 7;

    YearMonth previousMonth = currentMonth.minusMonths(1);
    YearMonth nextMonth = currentMonth.plusMonths(1);

    String monthName = currentMonth.format(
        DateTimeFormatter.ofPattern("MMMM yyyy")
    );

    // Sample holidays
    Set<LocalDate> holidays = new HashSet<LocalDate>();

    holidays.add(LocalDate.of(2025, 3, 8));
    holidays.add(LocalDate.of(2025, 3, 14));
    holidays.add(LocalDate.of(2025, 3, 17));

    int totalCells = ((startDay + daysInMonth + 6) / 7) * 7;
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Dashly - Dashboard</title>

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Arial, sans-serif;
}

body {
    background: #F0F2F5;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
}

.app {
    width: 1400px;
    max-width: 100%;
    background: #FFFFFF;
    border-radius: 32px;
    box-shadow: 0 25px 50px rgba(0,0,0,0.15);
    overflow: hidden;
    display: flex;
    flex-direction: column;
}

/* HEADER */

.header {
    background: #1E3A5F;
    padding: 16px 32px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    color: white;
    height: 80px;
    flex-shrink: 0;
}

.header-left {
    display: flex;
    align-items: center;
    gap: 12px;
}

.logo-mark {
    background: #4F8CFF;
    width: 36px;
    height: 36px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    font-weight: bold;
}

.logo-text {
    font-size: 20px;
    font-weight: bold;
}

.search-bar {
    background: rgba(255,255,255,0.12);
    border-radius: 40px;
    padding: 8px 20px;
    display: flex;
    align-items: center;
    gap: 10px;
    width: 320px;
}

.search-bar i {
    color: #A0B8D9;
}

.search-bar input {
    background: transparent;
    border: none;
    outline: none;
    color: white;
    font-size: 14px;
    width: 100%;
}

.search-bar input::placeholder {
    color: #A0B8D9;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 28px;
}

.notification-bell {
    position: relative;
    font-size: 22px;
    color: #D0E0F0;
}

.badge {
    position: absolute;
    top: -6px;
    right: -6px;
    background: #FF5C5C;
    width: 18px;
    height: 18px;
    border-radius: 50%;
    font-size: 10px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
}

.header-avatar {
    width: 42px;
    height: 42px;
    border-radius: 50%;
    background: linear-gradient(135deg,#6B9EFF,#3B6FD4);
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
}

/* MAIN BODY */

.main-body {
    display: flex;
    flex: 1;
    min-height: 700px;
}

/* SIDEBAR */

.sidebar {
    background: #F4F6F8;
    width: 88px;
    padding: 32px 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 28px;
    border-right: 1px solid #E2E8F0;
    flex-shrink: 0;
}

.nav-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    color: #5A6E8A;
    font-size: 20px;
    width: 56px;
    height: 56px;
    border-radius: 16px;
    cursor: pointer;
    position: relative;
}

.nav-item.active {
    background: #E3EDFF;
    color: #1E3A5F;
}

.nav-item.active:before {
    content: '';
    position: absolute;
    left: -18px;
    top: 50%;
    transform: translateY(-50%);
    width: 4px;
    height: 32px;
    background: #1E3A5F;
}

.nav-label {
    font-size: 9px;
    font-weight: bold;
    margin-top: 3px;
}

/* CONTENT */

.content {
    flex: 1;
    padding: 32px 36px;
    display: flex;
    flex-direction: column;
    gap: 28px;
    background: #FDFDFE;
}

/* USER CARD */

.user-info-card {
    background: white;
    border-radius: 24px;
    padding: 20px 28px;
    display: flex;
    align-items: center;
    gap: 20px;
    margin-left: auto;
    box-shadow: 0 8px 20px rgba(0,0,0,0.08);
    border: 1px solid #EBEEF2;
    min-width: 300px;
}

.user-avatar-large {
    width: 64px;
    height: 64px;
    border-radius: 50%;
    background: linear-gradient(145deg,#6B9EFF,#2D5BB9);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    font-weight: bold;
    color: white;
    flex-shrink: 0;
}

.user-details {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.user-name {
    font-size: 18px;
    font-weight: bold;
    color: #0B1E33;
}

.user-designation {
    font-size: 14px;
    color: #5A6E8A;
}

.status-badge {
    background: #E3F5E9;
    color: #0E7B3E;
    font-size: 11px;
    font-weight: bold;
    padding: 4px 10px;
    border-radius: 30px;
    width: fit-content;
    margin-top: 2px;
}

/* CALENDAR */

.spacer {
    flex: 1;
}

.calendar-card {
    background: white;
    border-radius: 28px;
    padding: 28px;
    box-shadow: 0 12px 30px rgba(0,0,0,0.08);
    border: 1px solid #EBEEF2;
    width: 100%;
    max-width: 720px;
    margin-left: auto;
}

.calendar-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 22px;
}

.calendar-month {
    font-size: 22px;
    font-weight: bold;
    color: #0B1E33;
}

.calendar-nav {
    display: flex;
    gap: 12px;
}

.calendar-nav a {
    background: #F4F6F8;
    border: none;
    width: 38px;
    height: 38px;
    border-radius: 12px;
    color: #1E3A5F;
    font-size: 16px;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
}

.calendar-nav a:hover {
    background: #E3EDFF;
}

.weekdays {
    display: grid;
    grid-template-columns: repeat(7,1fr);
    margin-bottom: 8px;
    text-align: center;
    font-weight: bold;
    font-size: 13px;
    color: #6F7F94;
    padding: 0 2px;
}

.calendar-grid {
    display: grid;
    grid-template-columns: repeat(7,1fr);
    gap: 4px;
    text-align: center;
    padding: 2px;
}

.calendar-day {
    padding: 12px 0;
    font-size: 15px;
    font-weight: 500;
    color: #1F2A3E;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    aspect-ratio: 1/1;
    max-height: 56px;
    position: relative;
}

.calendar-day.other-month {
    color: #B0C0D0;
}

.calendar-day.holiday {
    background: #FFEEE8;
    color: #C43E2B;
    font-weight: bold;
    box-shadow: inset 0 0 0 1px #FFB8A8;
}

.calendar-day.today {
    background: #1E3A5F;
    color: white;
    font-weight: bold;
    box-shadow: 0 6px 12px rgba(30,58,95,0.25);
}

.holiday-dot {
    position: absolute;
    bottom: 5px;
    left: 50%;
    transform: translateX(-50%);
    width: 5px;
    height: 5px;
    border-radius: 50%;
    background: #E05A3A;
}

/* LEGEND */

.calendar-legend {
    display: flex;
    gap: 28px;
    margin-top: 20px;
    padding-top: 18px;
    border-top: 1px solid #EFF2F6;
    font-size: 13px;
    color: #455A73;
    align-items: center;
    flex-wrap: wrap;
}

.legend-item {
    display: flex;
    align-items: center;
    gap: 8px;
}

.legend-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
}

.legend-dot.holiday {
    background: #E05A3A;
}

.legend-dot.today {
    background: #1E3A5F;
}

.legend-dot.other {
    background: #D8E0E8;
}

/* RESPONSIVE */

@media(max-width:1000px) {

    .sidebar {
        width: 70px;
        gap: 18px;
    }

    .nav-label {
        display: none;
    }

    .content {
        padding: 24px;
    }

    .search-bar {
        width: 200px;
    }
}

@media(max-width:600px) {

    body {
        padding: 5px;
    }

    .header {
        padding: 12px;
    }

    .search-bar {
        display: none;
    }

    .sidebar {
        width: 55px;
        gap: 15px;
    }

    .nav-item {
        width: 42px;
        height: 42px;
    }

    .content {
        padding: 12px;
    }

    .user-info-card {
        min-width: 0;
        width: 100%;
        padding: 12px;
    }

    .calendar-card {
        padding: 12px;
    }

    .calendar-day {
        font-size: 12px;
    }
}

</style>

</head>

<body>

<div class="app">

    <!-- HEADER -->

    <header class="header">

        <div class="header-left">
            <div class="logo-mark">D</div>
            <span class="logo-text">Dashly</span>
        </div>

        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Search anything...">
        </div>

        <div class="header-right">

            <div class="notification-bell">
                <i class="far fa-bell"></i>
                <span class="badge">3</span>
            </div>

            <div class="header-avatar">SJ</div>

        </div>

    </header>


    <!-- MAIN BODY -->

    <div class="main-body">


        <!-- SIDEBAR -->

        <nav class="sidebar">

            <div class="nav-item active">
                <i class="fas fa-home"></i>
                <span class="nav-label">Home</span>
            </div>

            <div class="nav-item">
                <i class="fas fa-chart-pie"></i>
                <span class="nav-label">Dash</span>
            </div>

            <div class="nav-item">
                <i class="fas fa-calendar-alt"></i>
                <span class="nav-label">Cal</span>
            </div>

            <div class="nav-item">
                <i class="fas fa-file-alt"></i>
                <span class="nav-label">Docs</span>
            </div>

            <div class="nav-item">
                <i class="fas fa-cog"></i>
                <span class="nav-label">Set</span>
            </div>

            <div class="nav-item" style="margin-top:auto;">
                <i class="fas fa-sign-out-alt"></i>
                <span class="nav-label">Out</span>
            </div>

        </nav>


        <!-- CONTENT -->

        <main class="content">


            <!-- USER INFORMATION -->

            <div class="user-info-card">

                <div class="user-avatar-large">SJ</div>

                <div class="user-details">

                    <div class="user-name">
                        Sarah Johnson
                    </div>

                    <div class="user-designation">
                        Senior Project Manager
                    </div>

                    <div class="status-badge">
                        ● Online
                    </div>

                </div>

            </div>


            <div class="spacer"></div>


            <!-- CALENDAR -->

            <div class="calendar-card">

                <div class="calendar-header">

                    <div class="calendar-month">
                        <%= monthName %>
                    </div>

                    <div class="calendar-nav">

                        <a href="dashboard.jsp?month=<%= previousMonth.getMonthValue() %>&year=<%= previousMonth.getYear() %>">
                            <i class="fas fa-chevron-left"></i>
                        </a>

                        <a href="dashboard.jsp?month=<%= nextMonth.getMonthValue() %>&year=<%= nextMonth.getYear() %>">
                            <i class="fas fa-chevron-right"></i>
                        </a>

                    </div>

                </div>


                <!-- WEEKDAYS -->

                <div class="weekdays">
                    <div>Sun</div>
                    <div>Mon</div>
                    <div>Tue</div>
                    <div>Wed</div>
                    <div>Thu</div>
                    <div>Fri</div>
                    <div>Sat</div>
                </div>


                <!-- DYNAMIC CALENDAR GRID -->

                <div class="calendar-grid">

                    <%
                        for (int i = 0; i < totalCells; i++) {

                            int dayNumber = i - startDay + 1;

                            LocalDate calendarDate;

                            boolean otherMonth = false;

                            if (dayNumber < 1) {

                                calendarDate = previousMonth.atDay(
                                    previousMonth.lengthOfMonth() + dayNumber
                                );

                                otherMonth = true;

                            } else if (dayNumber > daysInMonth) {

                                calendarDate = nextMonth.atDay(
                                    dayNumber - daysInMonth
                                );

                                otherMonth = true;

                            } else {

                                calendarDate = currentMonth.atDay(dayNumber);

                            }

                            boolean isToday = calendarDate.equals(today);

                            boolean isHoliday = holidays.contains(calendarDate);

                            String cssClass = "calendar-day";

                            if (otherMonth) {
                                cssClass += " other-month";
                            }

                            if (isHoliday) {
                                cssClass += " holiday";
                            }

                            if (isToday) {
                                cssClass += " today";
                            }
                    %>

                    <div class="<%= cssClass %>">

                        <%= calendarDate.getDayOfMonth() %>

                        <% if (isHoliday) { %>
                            <span class="holiday-dot"></span>
                        <% } %>

                    </div>

                    <%
                        }
                    %>

                </div>


                <!-- LEGEND -->

                <div class="calendar-legend">

                    <div class="legend-item">
                        <span class="legend-dot holiday"></span>
                        <span>Holiday</span>
                    </div>

                    <div class="legend-item">
                        <span class="legend-dot today"></span>
                        <span>Today</span>
                    </div>

                    <div class="legend-item">
                        <span class="legend-dot other"></span>
                        <span>Weekend / Other Month</span>
                    </div>

                </div>

            </div>

        </main>

    </div>

</div>

</body>
</html>
