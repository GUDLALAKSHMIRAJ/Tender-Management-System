<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.utility.DBUtil,javax.servlet.annotation.WebServlet,com.hit.beans.VendorBean"
    errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<link rel="shortcut icon" type="image/png" href="images/logo.png">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tender Management System</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<%
  String user = (String)session.getAttribute("user");
  String uname = (String)session.getAttribute("username");
  String pword = (String)session.getAttribute("password");
  if(!user.equalsIgnoreCase("user")||uname.equals("")||pword.equals("")){
    response.sendRedirect("loginFailed.jsp");
  }
  VendorBean vendor = (VendorBean)session.getAttribute("vendordata");
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="vendorMenu.jsp"></jsp:include>

<div class="clearfix hidden-sm hidden-xs" style="color:white;background-color:green;margin-top:-15px;margin-bottom:12px">
  <marquee>Welcome to Tender Management Site</marquee>
</div>

<div class="container-fluid">
  <div class="notice">
    <div class="col-md-3" style="margin-left:2%">
      <% Connection con = DBUtil.provideConnection(); %>
      <jsp:include page="notice.jsp"></jsp:include><br>
      <jsp:include page="approved.jsp"></jsp:include><br>
    </div>
  </div>

  <div class="col-md-8">
    <div class="vp-wrapper">

      <!-- Profile Header -->
      <div class="vp-header">
        <div class="vp-avatar"><i class="fa fa-user-circle-o"></i></div>
        <div>
          <div class="vp-name"><%= vendor.getName() %></div>
          <div class="vp-company"><i class="fa fa-building-o"></i> &nbsp;<%= vendor.getCompany() %></div>
        </div>
      </div>

      <!-- Profile Details -->
      <div class="vp-body">

        <div class="vp-row">
          <div class="vp-label"><i class="fa fa-id-badge" style="color:#e74c3c;"></i> &nbsp; Vendor Id</div>
          <div class="vp-value"><%= vendor.getId() %></div>
        </div>

        <div class="vp-row">
          <div class="vp-label"><i class="fa fa-user" style="color:#2980b9;"></i> &nbsp; Vendor Name</div>
          <div class="vp-value"><%= vendor.getName() %></div>
        </div>

        <div class="vp-row">
          <div class="vp-label"><i class="fa fa-phone" style="color:#27ae60;"></i> &nbsp; Mobile No.</div>
          <div class="vp-value"><%= vendor.getMobile() %></div>
        </div>

        <div class="vp-row">
          <div class="vp-label"><i class="fa fa-envelope" style="color:#8e44ad;"></i> &nbsp; Email Id</div>
          <div class="vp-value"><%= vendor.getEmail() %></div>
        </div>

        <div class="vp-row">
          <div class="vp-label"><i class="fa fa-map-marker" style="color:#e67e22;"></i> &nbsp; Address</div>
          <div class="vp-value">
            <textarea rows="2" class="vp-textarea" readonly><%= vendor.getAddress() %></textarea>
          </div>
        </div>

        <div class="vp-row">
          <div class="vp-label"><i class="fa fa-building-o" style="color:#1a1a3e;"></i> &nbsp; Company Name</div>
          <div class="vp-value"><%= vendor.getCompany() %></div>
        </div>

        <div class="vp-update-row">
          <a href="updateProfile.jsp" class="vp-update-btn">
            <i class="fa fa-edit"></i> &nbsp; Click Here To Update Profile
          </a>
        </div>

      </div>
    </div>
  </div>
</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>