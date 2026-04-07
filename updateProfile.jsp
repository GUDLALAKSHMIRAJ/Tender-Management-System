<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.utility.DBUtil,javax.servlet.annotation.WebServlet,com.hit.beans.VendorBean" errorPage="errorpage.jsp"%>
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
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style2.css">
</head>
<body>

<%
  String user = (String) session.getAttribute("user");
  String uname = (String) session.getAttribute("username");
  String pword = (String) session.getAttribute("password");
  if (user == null || !user.equalsIgnoreCase("user") || uname.equals("") || pword.equals("")) {
    response.sendRedirect("loginFailed.jsp");
  }
  VendorBean vendor = (VendorBean) session.getAttribute("vendordata");
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="vendorMenu.jsp"></jsp:include>

<div class="tm-welcome-bar">
  <i class="fa fa-user-circle-o"></i> &nbsp; Vendor Account &mdash; Update Profile
</div>

<div class="container-fluid tm-page-wrap">

  <!-- Left Sidebar -->
  <div class="col-md-3 tm-sidebar">
    <% Connection con = DBUtil.provideConnection(); %>
    <jsp:include page="notice.jsp"></jsp:include><br>
    <jsp:include page="approved.jsp"></jsp:include><br>
  </div>

  <!-- Main Content -->
  <div class="col-md-8">

    <!-- Info strip -->
    <div class="vf-info-strip">
      <i class="fa fa-pencil-square-o"></i>
      &nbsp; Edit your details below and click <strong>Update Profile</strong> to save changes.
    </div>

    <div class="vf-card">

      <div class="vf-card-header vf-header-blue">
        <i class="fa fa-id-card-o"></i> &nbsp; Update Profile
      </div>

      <form action="UpdateProfileSrv" method="post" class="vf-form-body">

        <!-- Vendor ID (read-only display) -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-tag"></i> Vendor ID
          </label>
          <div class="vf-readonly-val">
            <input type="hidden" name="vid" value="<%=vendor.getId()%>">
            <%=vendor.getId()%>
          </div>
        </div>

        <!-- Vendor Name -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-user"></i> Vendor Name
          </label>
          <input type="text" name="vname" class="vf-input" required="required"
            value="<%=vendor.getName()%>" placeholder="Enter your full name">
        </div>

        <!-- Mobile -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-phone"></i> Mobile No.
          </label>
          <input type="number" name="vmob" class="vf-input" required="required"
            value="<%=vendor.getMobile()%>" placeholder="Enter mobile number">
        </div>

        <!-- Email -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-envelope-o"></i> Email ID
          </label>
          <input type="email" name="vemail" class="vf-input" required="required"
            value="<%=vendor.getEmail()%>" placeholder="Enter email address">
        </div>

        <!-- Address -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-map-marker"></i> Address
          </label>
          <textarea name="vaddr" class="vf-textarea" rows="3" required="required"
            placeholder="Enter your address"><%=vendor.getAddress()%></textarea>
        </div>

        <!-- Company -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-building-o"></i> Company Name
          </label>
          <input type="text" name="vcompany" class="vf-input" required="required"
            value="<%=vendor.getCompany()%>" placeholder="Enter company name">
        </div>

        <!-- Password verify -->
        <div class="vf-field-group vf-field-group-highlight">
          <label class="vf-field-label">
            <i class="fa fa-lock"></i> Verify Password
          </label>
          <input type="password" name="vpass" class="vf-input" required="required"
            placeholder="Enter current password to confirm">
          <div class="vf-hint"><i class="fa fa-shield"></i> Required for security verification</div>
        </div>

        <!-- Submit -->
        <div class="vf-footer">
          <button type="submit" name="user" class="vf-submit-btn vf-submit-blue">
            <i class="fa fa-floppy-o"></i> &nbsp; Update Profile
          </button>
          <a href="javascript:history.back();" class="vf-back-btn">
            <i class="fa fa-arrow-left"></i> &nbsp; Go Back
          </a>
        </div>

      </form>
    </div><!-- end vf-card -->
  </div><!-- end col-md-8 -->

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
