<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.utility.DBUtil,com.hit.dao.VendorDao,com.hit.dao.VendorDaoImpl,com.hit.beans.VendorBean,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  if (user == null || !user.equalsIgnoreCase("admin") || uname.equals("") || pword.equals("")) {
    response.sendRedirect("loginFailed.jsp");
  }
  String vendorId = request.getParameter("vid");
  VendorDao dao = new VendorDaoImpl();
  VendorBean vendor = dao.getVendorDataById(vendorId);
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="adminMenu.jsp"></jsp:include>

<div class="tm-welcome-bar">
  <i class="fa fa-user-circle-o"></i> &nbsp; Vendor Profile &mdash; Contact Details
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

    <!-- Vendor ID info strip -->
    <div class="avd-info-strip">
      <i class="fa fa-id-card-o"></i>
      &nbsp; Viewing profile for Vendor ID: &nbsp;
      <strong class="avd-vid-highlight"><%=vendorId%></strong>
    </div>

    <!-- Main Profile Card -->
    <div class="avd-card">

      <!-- Gradient header -->
      <div class="avd-card-header">
        <i class="fa fa-address-card-o"></i>
        &nbsp; Vendor Contact Details
      </div>

      <!-- Hero row: big avatar + name + company (TABLE layout for Bootstrap 3 compat) -->
      <div class="avd-hero-wrap">
        <table class="avd-hero-table" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td class="avd-hero-avatar-cell">
              <div class="avd-avatar-circle">
                <i class="fa fa-user-circle-o"></i>
              </div>
            </td>
            <td class="avd-hero-text-cell">
              <div class="avd-hero-name"><%=vendor.getName()%></div>
              <div class="avd-hero-company">
                <i class="fa fa-building-o"></i>&nbsp;<%=vendor.getCompany()%>
              </div>
            </td>
          </tr>
        </table>
      </div>

      <!-- Details section -->
      <div class="avd-details-wrap">

        <!-- Row 1 -->
        <table class="avd-detail-table" cellpadding="0" cellspacing="0" border="0" width="100%">

          <tr class="avd-detail-row">
            <td class="avd-detail-label">
              <i class="fa fa-user" style="color:#8e44ad;margin-right:8px;"></i>
              <strong>Vendor Name</strong>
            </td>
            <td class="avd-detail-colon">:</td>
            <td class="avd-detail-value"><%=vendor.getName()%></td>
          </tr>

          <tr class="avd-detail-row avd-alt">
            <td class="avd-detail-label">
              <i class="fa fa-phone" style="color:#27ae60;margin-right:8px;"></i>
              <strong>Mobile No</strong>
            </td>
            <td class="avd-detail-colon">:</td>
            <td class="avd-detail-value"><%=vendor.getMobile()%></td>
          </tr>

          <tr class="avd-detail-row">
            <td class="avd-detail-label">
              <i class="fa fa-envelope-o" style="color:#2980b9;margin-right:8px;"></i>
              <strong>Email ID</strong>
            </td>
            <td class="avd-detail-colon">:</td>
            <td class="avd-detail-value">
              <a href="mailto:<%=vendor.getEmail()%>" class="avd-email"><%=vendor.getEmail()%></a>
            </td>
          </tr>

          <tr class="avd-detail-row avd-alt">
            <td class="avd-detail-label">
              <i class="fa fa-building-o" style="color:#e67e22;margin-right:8px;"></i>
              <strong>Company Name</strong>
            </td>
            <td class="avd-detail-colon">:</td>
            <td class="avd-detail-value"><%=vendor.getCompany()%></td>
          </tr>

          <tr class="avd-detail-row">
            <td class="avd-detail-label">
              <i class="fa fa-map-marker" style="color:#e74c3c;margin-right:8px;"></i>
              <strong>Address</strong>
            </td>
            <td class="avd-detail-colon">:</td>
            <td class="avd-detail-value"><%=vendor.getAddress()%></td>
          </tr>

        </table>

      </div><!-- end avd-details-wrap -->

      <!-- Footer action buttons -->
      <div class="avd-footer">
        <a href="javascript:history.back();" class="avd-btn avd-btn-back">
          <i class="fa fa-arrow-left"></i> &nbsp; Go Back
        </a>
        &nbsp;&nbsp;
        <a href="adminViewVendor.jsp" class="avd-btn avd-btn-blue">
          <i class="fa fa-users"></i> &nbsp; All Vendors
        </a>
      </div>

    </div><!-- end avd-card -->
  </div><!-- end col-md-8 -->

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
