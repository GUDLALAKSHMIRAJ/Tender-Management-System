<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.utility.DBUtil,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <link rel="shortcut icon" type="image/png" href="images/logo.png">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tender Management System</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link rel="stylesheet" href="css/style2.css">
</head>
<body>

<jsp:include page="loginHeader.jsp"></jsp:include>
<jsp:include page="menu.jsp"></jsp:include>

<div class="clearfix hidden-sm hidden-xs"
     style="color:white;background-color:green;margin-top:-15px;margin-bottom:12px;">
  <marquee>Welcome to Tender Management Site</marquee>
</div>

<!-- ═══════════════════════════════════════════════════════════
     FIX: The original code was missing the closing </div> for
     container-fluid, causing the footer to float beside the
     content instead of appearing below it.
     Structure must be:
       <div class="container-fluid">
         <div class="col-md-3"> sidebar </div>
         <div class="col-md-8"> main content </div>
         <div class="clearfix"></div>   ← REQUIRED to push footer down
       </div>
       <footer>
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
    <div class="marquee" style="border:none; background-color:#26b0b0;">

      <h4 style="background-color:black; margin-top:-1.8px; margin-bottom:1px;
                 padding:5px; text-align:center; color:red; font-weight:bold;">
        &nbsp; <span id="pagetitle">Vendor Registration</span>
      </h4>

      <div class="marquee-content" style="padding-top:5px; min-height:750px;">

        <div style="display:flex; justify-content:center; margin-top:40px;">
          <div class="form-box">

            <h3>Register New Vendor</h3>
            <p class="sub">Create your account to participate in tenders</p>

            <form action="RegisterSrv" method="post">

              <div class="input-group">
                <i class="fa fa-user"></i>
                <input type="text" name="vname" placeholder="Vendor Name" required>
              </div>

              <div class="input-group">
                <i class="fa fa-envelope"></i>
                <input type="email" name="vemail" placeholder="Email ID" required>
              </div>

              <div class="input-group">
                <i class="fa fa-phone"></i>
                <input type="text" name="vmob" placeholder="Mobile Number" required>
              </div>

              <div class="input-group">
                <i class="fa fa-map-marker"></i>
                <input type="text" name="vaddr" placeholder="Address" required>
              </div>

              <div class="input-group">
                <i class="fa fa-building"></i>
                <input type="text" name="cname" placeholder="Company" required>
              </div>

              <div class="input-group">
                <i class="fa fa-lock"></i>
                <input type="password" name="vpass" placeholder="Password" required>
              </div>

              <button type="submit">Register</button>

            </form>

          </div>
        </div>

      </div><!-- end marquee-content -->
    </div><!-- end marquee -->
  </div><!-- end col-md-8 -->

  <!-- ✅ CRITICAL FIX: clearfix pushes footer BELOW the floated columns -->
  <div class="clearfix"></div>

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
