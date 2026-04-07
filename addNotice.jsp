<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.hit.utility.DBUtil, javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <link rel="shortcut icon" type="image/png" href="images/logo.png">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Notice - TMS</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="css/bootstrap-dropdownhover.min.css">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/addNotice.css">
</head>
<body>

  <%
    String user = (String)session.getAttribute("user");
    String uname = (String)session.getAttribute("username");
    String pword = (String)session.getAttribute("password");
    if(!user.equalsIgnoreCase("admin") || uname.equals("") || pword.equals("")){
      response.sendRedirect("loginFailed.jsp");
    }
  %>

  <jsp:include page="header.jsp"></jsp:include>
  <jsp:include page="adminMenu.jsp"></jsp:include>

  <div class="an-welcome-bar">
    <marquee>Welcome to Tender Management Site</marquee>
  </div>

  <div class="container-fluid">
    <div class="notice">
      <div class="col-md-3 an-sidebar">
        <% Connection con = DBUtil.provideConnection(); %>
        <jsp:include page="notice.jsp"></jsp:include><br>
        <jsp:include page="approved.jsp"></jsp:include><br>
      </div>
    </div>

    <div class="col-md-8">

      <!-- Page Header -->
      <div class="an-page-header">
        <div class="an-ph-icon"><i class="fa fa-bullhorn"></i></div>
        <div>
          <div class="an-ph-title">Add New Notice</div>
          <div class="an-ph-sub">Post an announcement to the public notice board</div>
        </div>
      </div>

      <!-- Form Panel -->
      <div class="an-panel">

        <div class="an-panel-header">
          <i class="fa fa-bell"></i>
          <span>Notice Details</span>
        </div>

        <div class="an-panel-body">
          <form action="AddNoticeSrv" method="post">

            <div class="an-field">
              <label class="an-label"><i class="fa fa-header"></i> Notice Title</label>
              <input class="an-input" type="text" name="title" placeholder="e.g. Kolkata-Haldia Bridge Construction Update" required>
              <span class="an-hint">Keep it short and clear — this is the headline everyone sees first</span>
            </div>

            <div class="an-field">
              <label class="an-label"><i class="fa fa-align-left"></i> Description</label>
              <textarea class="an-input an-textarea" name="info" placeholder="Write the full notice details here. Include dates, locations, contact info or any other relevant information..." required></textarea>
            </div>

            <div class="an-preview-strip">
              <i class="fa fa-eye"></i>
              &nbsp; This notice will appear on the <strong>Latest Updates &amp; Notice</strong> board visible to all users.
            </div>

            <button type="submit" class="an-submit-btn" name="user">
             Post to Notice Board
            </button>

          </form>
        </div>
      </div>

    </div>
  </div>

  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
