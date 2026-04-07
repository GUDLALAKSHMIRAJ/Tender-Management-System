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
  <i class="fa fa-lock"></i> &nbsp; Vendor Account &mdash; Change Password
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
    <div class="vf-info-strip vf-info-strip-red">
      <i class="fa fa-shield"></i>
      &nbsp; For security, enter your <strong>current password</strong> and set a new one below.
    </div>

    <div class="vf-card">

      <div class="vf-card-header vf-header-red">
        <i class="fa fa-key"></i> &nbsp; Change Password
      </div>

      <form action="ChangePasswordSrv" method="post" class="vf-form-body">
        <input type="hidden" name="vid" value="<%=vendor.getId()%>">

        <!-- Old Password -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-lock"></i> Enter Old Password
          </label>
          <div class="vf-pw-wrap">
            <input type="password" name="oldpassword" id="oldpass"
              class="vf-input vf-pw-input" required="required"
              placeholder="Enter your current password">
            <span class="vf-eye-toggle" onclick="vfToggle('oldpass',this)">
              <i class="fa fa-eye"></i>
            </span>
          </div>
        </div>

        <!-- New Password -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-unlock-alt"></i> Enter New Password
          </label>
          <div class="vf-pw-wrap">
            <input type="password" name="newpassword" id="newpass"
              class="vf-input vf-pw-input" required="required"
              placeholder="Enter new password">
            <span class="vf-eye-toggle" onclick="vfToggle('newpass',this)">
              <i class="fa fa-eye"></i>
            </span>
          </div>
        </div>

        <!-- Re-Enter New Password -->
        <div class="vf-field-group">
          <label class="vf-field-label">
            <i class="fa fa-check-circle-o"></i> Re-Enter New Password
          </label>
          <div class="vf-pw-wrap">
            <input type="password" name="verifynewpassword" id="confirmpass"
              class="vf-input vf-pw-input" required="required"
              placeholder="Confirm new password">
            <span class="vf-eye-toggle" onclick="vfToggle('confirmpass',this)">
              <i class="fa fa-eye"></i>
            </span>
          </div>
          <div class="vf-hint">
            <i class="fa fa-info-circle"></i> Both new password fields must match
          </div>
        </div>

        <!-- Submit -->
        <div class="vf-footer">
          <button type="submit" class="vf-submit-btn vf-submit-red">
            <i class="fa fa-key"></i> &nbsp; Change Password
          </button>
          <a href="javascript:history.back();" class="vf-back-btn">
            <i class="fa fa-arrow-left"></i> &nbsp; Go Back
          </a>
        </div>

      </form>
    </div><!-- end vf-card -->
  </div><!-- end col-md-8 -->

</div><!-- end container-fluid -->

<script>
function vfToggle(fieldId, iconSpan) {
  var field = document.getElementById(fieldId);
  var icon  = iconSpan.querySelector('i');
  if (field.type === 'password') {
    field.type = 'text';
    icon.className = 'fa fa-eye-slash';
  } else {
    field.type = 'password';
    icon.className = 'fa fa-eye';
  }
}
</script>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
