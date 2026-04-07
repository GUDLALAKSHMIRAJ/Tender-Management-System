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
  <title>View Vendors - TMS</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="css/bootstrap-dropdownhover.min.css" rel="stylesheet">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/adminViewVendor.css">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <script src="js/bootstrap.min.js"></script>
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

  <div class="vv-welcome-bar">
    <marquee>Welcome to Tender Management Site</marquee>
  </div>

  <div class="container-fluid">
    <div class="notice">
      <div class="col-md-3 vv-sidebar">
        <% Connection con = DBUtil.provideConnection(); %>
        <jsp:include page="notice.jsp"></jsp:include><br>
        <jsp:include page="approved.jsp"></jsp:include><br>
      </div>
    </div>

    <div class="col-md-8">

      <%
        Connection con2 = DBUtil.provideConnection();
        PreparedStatement countPs = con2.prepareStatement("SELECT COUNT(*) FROM vendor");
        ResultSet countRs = countPs.executeQuery();
        int vendorCount = 0;
        if(countRs.next()) vendorCount = countRs.getInt(1);
      %>

      <!-- Page Header -->
      <div class="vv-page-header">
        <div class="vv-ph-icon"><i class="fa fa-users"></i></div>
        <div>
          <div class="vv-ph-title">Registered Vendors</div>
          <div class="vv-ph-sub">All vendors currently registered on the platform</div>
        </div>
        <div class="vv-ph-badge">
          <i class="fa fa-user"></i> &nbsp;<%= vendorCount %> Vendors
        </div>
      </div>

      <!-- Vendor Cards Grid -->
      <%
        String[] colors = {"#e74c3c","#2980b9","#27ae60","#8e44ad","#f39c12","#16a085","#c0392b","#2471a3"};
        PreparedStatement ps = con2.prepareStatement("SELECT * FROM vendor");
        ResultSet rs = ps.executeQuery();
        int idx = 0;
      %>

      <div class="vv-grid">
      <%
        while(rs.next()){
          String vid     = rs.getString("vid");
          String vname   = rs.getString("vname");
          String vmob    = rs.getString("vmob");
          String vemail  = rs.getString("vemail");
          String company = rs.getString("company");
          String address = rs.getString("address");
          String color   = colors[idx % colors.length];
          // initials from name
          String[] parts = vname.trim().split(" ");
          String initials = parts.length >= 2
            ? ("" + parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase()
            : vname.substring(0, Math.min(2, vname.length())).toUpperCase();
          idx++;
      %>
        <div class="vv-card" onclick="window.location='adminViewVendorDetail.jsp?vid=<%= vid %>'">
          <div class="vv-card-bar" style="background:<%= color %>"></div>
          <div class="vv-card-inner">

            <!-- Top: avatar + name + id -->
            <div class="vv-card-top">
              <div class="vv-avatar" style="background:<%= color %>"><%= initials %></div>
              <div>
                <div class="vv-card-name"><%= vname %></div>
                <div class="vv-card-id"><i class="fa fa-id-badge"></i> &nbsp;<%= vid %></div>
              </div>
              <div class="vv-card-arrow"><i class="fa fa-chevron-right"></i></div>
            </div>

            <!-- Divider -->
            <div class="vv-divider"></div>

            <!-- Info rows -->
            <div class="vv-info-row">
              <span class="vv-info-icon" style="color:<%= color %>"><i class="fa fa-building"></i></span>
              <span class="vv-info-label">Company</span>
              <span class="vv-info-val"><%= company %></span>
            </div>
            <div class="vv-info-row">
              <span class="vv-info-icon" style="color:<%= color %>"><i class="fa fa-mobile"></i></span>
              <span class="vv-info-label">Mobile</span>
              <span class="vv-info-val"><%= vmob %></span>
            </div>
            <div class="vv-info-row">
            
              <span class="vv-info-icon" style="color:<%= color %>"><i class="fa fa-envelope"></i></span>
              <span class="vv-info-label">Email</span>
              <span class="vv-info-val vv-email"><%= vemail %></span>
            </div>
            <div class="vv-info-row">
              <span class="vv-info-icon" style="color:<%= color %>"><i class="fa fa-map-marker"></i></span>
              <span class="vv-info-label">Address</span>
              <span class="vv-info-val"><%= address %></span>
            </div>

            <!-- Footer -->
            <div class="vv-card-footer">
              <a href="adminViewVendorDetail.jsp?vid=<%= vid %>" class="vv-view-btn" style="border-color:<%= color %>;color:<%= color %>">
                <i class="fa fa-eye"></i> &nbsp;View Details
              </a>
            </div>

          </div>
        </div>
      <% } %>
      </div>

      <% if(vendorCount == 0){ %>
      <div class="vv-empty">
        <i class="fa fa-user-times"></i>
        <p>No vendors registered yet.</p>
      </div>
      <% } %>

    </div>
  </div>

  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
