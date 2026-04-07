<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.utility.DBUtil,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <link rel="shortcut icon" type="image/png" href="images/logo.png">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tender Management System</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link rel="stylesheet" href="css/style2.css">
</head>

<script>
function togglePass() {
  var input = document.getElementById('passwordInput');
  var btn   = document.getElementById('eyeBtn');
  if (input.type === 'password') {
    input.type = 'text';
    btn.innerHTML = '&#128064;';
  } else {
    input.type = 'password';
    btn.innerHTML = '&#128065;';
  }
}
</script>

<body>

<jsp:include page="loginHeader.jsp"></jsp:include>
<jsp:include page="menu.jsp"></jsp:include>

<div class="clearfix hidden-sm hidden-xs"
     style="color:white;background-color:green;margin-top:-15px;margin-bottom:12px;">
  <marquee>Welcome to Tender Management Site</marquee>
</div>

<!-- ═══════════════════════════════════════════════════════════
     FIX: Same issue as register.jsp — missing closing </div>
     for container-fluid + missing clearfix between the two
     floated Bootstrap columns (col-md-3 and col-md-8).
     Without clearfix the footer floats up beside the columns.
═══════════════════════════════════════════════════════════ -->

<div class="container-fluid">

  <!-- Left sidebar -->
  <div class="col-md-3" style="margin-left:2%;">
    <% Connection con = DBUtil.provideConnection(); %>
    <jsp:include page="notice.jsp"></jsp:include><br>
    <jsp:include page="approved.jsp"></jsp:include><br>
  </div>

  <!-- Main content -->
  <div class="col-md-8">
    <div class="marquee" style="border:2px black hidden; background-color:white; padding-top:0px;">

      <h4 style="background-color:black; margin-top:-1.8px; margin-bottom:1px;
                 padding:5px; text-align:center; color:red; font-weight:bold;">
        &nbsp; <span id="pagetitle">Account Login</span>
      </h4>

      <div class="marquee-content"
           style="padding-top:40px; min-height:750px; background-color:transparent;">

        <%
          /* Show error alert if redirected from a protected page */
          String showAlert = request.getParameter("auth");
          String referer   = request.getHeader("Referer");
          boolean isAuthRedirect = "fail".equals(showAlert)
              || (referer == null)
              || referer.contains("Srv")
              || referer.contains("adminHome")
              || referer.contains("vendorHome")
              || referer.contains("bidHistory")
              || referer.contains("bidTenderForm")
              || referer.contains("acceptBid")
              || referer.contains("createTender")
              || referer.contains("addNotice");
        %>

        <!-- Alert / Info box -->
        <div style="display:flex; justify-content:center; margin-bottom:20px;">
          <% if (isAuthRedirect) { %>
            <div style="background:rgba(231,76,60,0.15); border:2px solid #e74c3c;
                        border-radius:10px; padding:14px 40px;
                        color:#c0392b; font-weight:700; font-size:16px; text-align:center;">
              &#10007; &nbsp; Please Login First to Proceed! &nbsp; &#10007;<br>
              <span style="font-size:13px; font-weight:400; color:#7f8c8d;">
                You need to be logged in to access that page.
              </span>
            </div>
          <% } else { %>
            <div style="background:rgba(41,128,185,0.12); border:2px solid #2980b9;
                        border-radius:10px; padding:14px 40px;
                        color:#1a5276; font-weight:700; font-size:16px; text-align:center;">
              <i class="fa fa-sign-in" style="margin-right:8px;"></i>
              Login to Access Your Account<br>
              <span style="font-size:13px; font-weight:400; color:#5a6080;">
                Enter your credentials below to continue.
              </span>
            </div>
          <% } %>
        </div>

        <!-- Login form -->
        <div style="display:flex; justify-content:center; margin-top:20px;">
          <div class="form-box login-box">

            <h3>User Login</h3>
            <p class="sub">Login to access your dashboard</p>

            <form action="LoginSrv" method="post">

              <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text" name="username"
                       placeholder="Enter Email or VendorId" required>
              </div>

              <div class="input-group" style="position:relative;">
                <i class="fa fa-lock"></i>
                <input type="password" name="password" id="passwordInput"
                       placeholder="Password" required style="padding-right:40px;">
                <span onclick="togglePass()" id="eyeBtn"
                      style="position:absolute; right:12px; top:50%;
                             transform:translateY(-50%); cursor:pointer;
                             font-size:20px; user-select:none;">
                  &#128065;
                </span>
              </div>

              <button type="submit" name="user" value="login as vendor">
                Login As Vendor
              </button>

              <button type="submit" name="user" value="login as admin"
                      style="margin-top:10px; background:#5a3e2b;">
                Login As Admin
              </button>

            </form>
          </div>
        </div>

      </div><!-- end marquee-content -->
    </div><!-- end marquee -->
  </div><!-- end col-md-8 -->

  <!-- ✅ CRITICAL FIX: clearfix forces footer to render BELOW columns -->
  <div class="clearfix"></div>

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
