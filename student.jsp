<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Apply Now - College Portal</title>
  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f9f9f9;
    }

    .form-container {
      width: 100%;
      max-width: 500px;
      margin: 50px auto;
      background-color: #fff;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .form-container h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    .form-container .form-group {
      margin-bottom: 15px;
    }

    .form-container .form-control {
      height: 40px;
      font-size: 16px;
    }

    .form-container button {
      width: 100%;
      padding: 12px;
      font-size: 16px;
      background-color: #00bcd4;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .form-container button:hover {
      background-color: #0097a7;
    }
  </style>
</head>
<body>

  <div class="form-container">
    <h2>Apply Now</h2>
    <form action="student.jsp" method="POST">
      <!-- Name -->
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your full name" required>
      </div>

      <!-- Email -->
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
      </div>

      <!-- Phone Number -->
      <div class="form-group">
        <label for="phone">Phone Number</label>
        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter your phone number" required>
      </div>

      <!-- Course -->
      <div class="form-group">
        <label for="course">Choose Your Course</label>
        <select class="form-control" id="course" name="course" required>
          <option value="" disabled selected>Choose your course</option>
          <option value="computer Engineering">Computer Engineering</option>
          <option value="Mechanical Engineering">Mechanical Engineering</option>
          <option value="Electronics Engineering">Electronics Engineering</option>
          <option value="Electrical Engineering">Electrical Engineering</option>
        </select>
      </div>

      <!-- Password -->
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="Create a password" required>
      </div>

      <!-- Submit Button -->
      <button type="submit">Apply</button>
    </form>

    <%
      String name = request.getParameter("name");
      String email = request.getParameter("email");
      String phone = request.getParameter("phone");
      String course = request.getParameter("course");
      String password = request.getParameter("password");

      if (name != null && email != null && phone != null && course != null && password != null) {
        try {
          Class.forName("org.postgresql.Driver");
          Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/college", "postgres", "@Pass1234");

          String sql = "INSERT INTO student (full_name, email, phone, course, password) VALUES (?, ?, ?, ?, ?)";
          PreparedStatement ps = conn.prepareStatement(sql);
          ps.setString(1, name);
          ps.setString(2, email);
          ps.setString(3, phone);
          ps.setString(4, course);
          ps.setString(5, password);

          int result = ps.executeUpdate();
          if (result > 0) {
        	  out.println("<script>alert('Registration Completed'); window.location='index.html';</script>");

          } else {
            out.println("<script>alert('Registration Failed');</script>");
          }

          ps.close();
          conn.close();
        } catch (Exception e) {
          out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "');</script>");
        }
      }
    %>
  </div>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
