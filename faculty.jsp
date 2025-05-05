<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Faculty Login / Registration</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding: 0;
    }

    .form-container {
      max-width: 400px;
      margin: 50px auto;
      padding: 20px;
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
      display: none;
      opacity: 0;
      transition: opacity 0.5s ease;
    }

    .form-container.show {
      display: block;
      opacity: 1;
    }

    .form-container h2 {
      text-align: center;
      color: #0b2545;
      margin-bottom: 20px;
      font-size: 24px;
    }

    .btn-submit {
      background-color: #00bcd4;
      color: white;
      border-radius: 999px;
      font-size: 14px;
      padding: 8px 25px;
      font-weight: 600;
      transition: all 0.3s ease;
    }

    .btn-submit:hover {
      background-color: #0097a7;
      transform: scale(1.05);
    }

    .form-label {
      font-size: 14px;
    }

    .form-control {
      font-size: 14px;
    }

    .form-select {
      font-size: 14px;
    }

    .form-toggle {
      text-align: center;
      margin-top: 15px;
    }

    .form-toggle a {
      color: #00bcd4;
      text-decoration: none;
    }

    .form-toggle a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

  <!-- Login Form -->
  <div class="form-container show" id="form-container">
    <h2 id="form-title">Faculty Login</h2>

    <form action="faculty.jsp" method="POST">
      <div class="mb-3">
        <label for="loginEmail" class="form-label">Email</label>
        <input type="email" class="form-control" id="loginEmail" name="loginEmail" required>
      </div>
      <div class="mb-3">
        <label for="loginPassword" class="form-label">Password</label>
        <input type="password" class="form-control" id="loginPassword" name="loginPassword" required>
      </div>
      <button type="submit" class="btn btn-submit">Login</button>
    </form>

    <div class="form-toggle">
      <a href="javascript:void(0);" id="switch-to-register">Don't have an account? Register here</a>
    </div>
  </div>

  <!-- Registration Form -->
  <div class="form-container" id="register-container">
    <h2 id="register-title">Faculty Registration</h2>

    <form action="faculty.jsp" method="POST">
      <div class="mb-3">
        <label for="registerName" class="form-label">Name</label>
        <input type="text" class="form-control" id="registerName" name="name" required>
      </div>
      <div class="mb-3">
        <label for="registerEmail" class="form-label">Email</label>
        <input type="email" class="form-control" id="registerEmail" name="email" required>
      </div>
      <div class="mb-3">
        <label for="registerPassword" class="form-label">Password</label>
        <input type="password" class="form-control" id="registerPassword" name="password" required>
      </div>
      <div class="mb-3">
        <label for="confirmPassword" class="form-label">Confirm Password</label>
        <input type="password" class="form-control" id="confirmPassword" name="confirm_password" required>
      </div>
      <div class="mb-3">
        <label for="facultyDept" class="form-label">Department</label>
        <select class="form-select" id="facultyDept" name="department" required>
          <option value="" disabled selected>Choose your department</option>
          <option value="computer Engineering">Computer Engineering</option>
          <option value="Mechanical Engineering">Mechanical Engineering</option>
          <option value="Electronics Engineering">Electronics Engineering</option>
          <option value="Electrical Engineering">Electrical Engineering</option>
        </select>
      </div>
      <button type="submit" class="btn btn-submit">Register</button>
    </form>

    <div class="form-toggle">
      <a href="javascript:void(0);" id="switch-to-login">Already have an account? Login here</a>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    // Switch to registration form
    document.getElementById('switch-to-register').addEventListener('click', function() {
      document.getElementById('form-container').classList.remove('show');
      document.getElementById('register-container').classList.add('show');
      document.getElementById('form-title').innerText = 'Faculty Registration';
      document.getElementById('switch-to-register').style.display = 'none';
    });

    // Switch to login form
    document.getElementById('switch-to-login').addEventListener('click', function() {
      document.getElementById('register-container').classList.remove('show');
      document.getElementById('form-container').classList.add('show');
      document.getElementById('form-title').innerText = 'Faculty Login';
      document.getElementById('switch-to-register').style.display = 'block';
    });
  </script>

  <% 
    // Handle Faculty Login
    String loginEmail = request.getParameter("loginEmail");
    String loginPassword = request.getParameter("loginPassword");
    if (loginEmail != null && loginPassword != null) {
      try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/college", "postgres", "@Pass1234");

        // Check if faculty exists in the database
        String loginQuery = "SELECT * FROM faculty WHERE email = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(loginQuery);
        ps.setString(1, loginEmail);
        ps.setString(2, loginPassword);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
          // Faculty login successful, set session and redirect
          HttpSession session1 = request.getSession();
          session1.setAttribute("facultyEmail", loginEmail);
          session1.setAttribute("facultyDepartment", rs.getString("department"));
          response.sendRedirect("login.jsp"); // Redirect to dashboard
        } else {
          out.println("<script>alert('Invalid login credentials');</script>");
        }
      } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
      }
    }

    // Handle Faculty Registration
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirm_password");
    String department = request.getParameter("department");

    if (name != null && email != null && password != null && confirmPassword != null && department != null) {
      if (password.equals(confirmPassword)) {
        try {
          Class.forName("org.postgresql.Driver");
          Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/college", "postgres", "@Pass1234");

          // Insert faculty details into the database
          String sql = "INSERT INTO faculty (name, email, password, confirm_password ,department) VALUES (?, ?, ?, ?, ?)";
          PreparedStatement ps = conn.prepareStatement(sql);
          ps.setString(1, name);
          ps.setString(2, email);
          ps.setString(3, password);
          ps.setString(4, confirmPassword);
          ps.setString(5, department);

          int result = ps.executeUpdate();
          if (result > 0) {
            out.println("<script>alert('Registration Successful!'); window.location.href = 'index.html';</script>");
          } else {
            out.println("<script>alert('Error in Registration. Please try again.');</script>");
          }

        } catch (Exception e) {
          e.printStackTrace();
          out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
      } else {
        out.println("<script>alert('Passwords do not match. Please try again.');</script>");
      }
    }
  %>

</body>
</html>
