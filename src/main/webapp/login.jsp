<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // Retrieve department from session
    String dept = (String) session.getAttribute("facultyDepartment");
    if (dept == null) {
        response.sendRedirect("faculty.jsp"); // If not logged in properly
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Faculty Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f8f9fa;
    }
    .container {
      margin-top: 30px;
    }
    .table {
      margin-top: 20px;
    }
    th, td {
      text-align: left;
      vertical-align: middle;
    }
    th {
      background-color: #0b2545;
      color: white;
      font-size: 16px;
    }
    tr:nth-child(even) {
      background-color: #f2f2f2;
    }
    tr:hover {
      background-color: #ddd;
    }
    .table-container {
      overflow-x: auto;
    }
    .dashboard-header {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>

  <div class="container">
    <div class="dashboard-header">
      <h2>Welcome, Faculty</h2>
      <h4>Students from Department: <%= dept %></h4>
    </div>
    
    <div class="table-container">
      <table class="table table-bordered table-striped table-hover">
        <thead>
          <tr>
            <th>Student ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Course</th>
          </tr>
        </thead>
        <tbody>
          <% 
            try {
              Class.forName("org.postgresql.Driver");
              Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/college", "postgres", "@Pass1234");

              String sql = "SELECT * FROM student WHERE course = ?";
              PreparedStatement ps = conn.prepareStatement(sql);
              ps.setString(1, dept);
              ResultSet rs = ps.executeQuery();

              while (rs.next()) {
          %>
            <tr>
              <td><%= rs.getInt("id") %></td>
              <td><%= rs.getString("full_name") %></td>
              <td><%= rs.getString("email") %></td>
              <td><%= rs.getString("phone") %></td>
              <td><%= rs.getString("course") %></td>
            </tr>
          <%
              }
              rs.close();
              ps.close();
              conn.close();
            } catch (Exception e) {
              out.println("<script>alert('Error fetching student data: " + e.getMessage() + "');</script>");
            }
          %>
        </tbody>
      </table>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
