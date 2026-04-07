<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.lang.Integer,java.lang.String, com.hit.beans.TenderBean,
                com.hit.utility.DBUtil,java.util.List,com.hit.dao.TenderDaoImpl,
                com.hit.dao.TenderDao, javax.servlet.annotation.WebServlet"
    errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <link rel="shortcut icon" type="image/png" href="images/logo.png">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>View Tenders - TMS Vendor</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link href="css/bootstrap-dropdownhover.min.css">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/vendorViewTender.css">
</head>
<body>

  <%
    String user = (String)session.getAttribute("user");
    String uname = (String)session.getAttribute("username");
    String pword = (String)session.getAttribute("password");
    if(!user.equalsIgnoreCase("user") || uname.equals("") || pword.equals("")){
      response.sendRedirect("loginFailed.jsp");
    }
    // Get vendor ID from session for bid links
    com.hit.beans.VendorBean vbean = (com.hit.beans.VendorBean) session.getAttribute("vendordata");
    String sessionVid = (vbean != null) ? vbean.getId() : uname;
  %>

  <jsp:include page="header.jsp"></jsp:include>
  <jsp:include page="vendorMenu.jsp"></jsp:include>

  <div class="vvt-welcome-bar">
    <marquee>Welcome to Tender Management Site</marquee>
  </div>

  <div class="container-fluid">
    <div class="notice">
      <div class="col-md-3 vvt-sidebar">
        <% Connection con = DBUtil.provideConnection(); %>
        <jsp:include page="notice.jsp"></jsp:include><br>
        <jsp:include page="approved.jsp"></jsp:include><br>
      </div>
    </div>

    <div class="col-md-8">

      <%
        TenderDao dao = new TenderDaoImpl();
        List<TenderBean> tenderList = dao.getAllTenders();
        int totalTenders = tenderList.size();
      %>

      <!-- Page Header -->
      <div class="vvt-page-header">
        <div class="vvt-ph-icon"><i class="fa fa-list-alt"></i></div>
        <div>
          <div class="vvt-ph-title">Available Tenders</div>
          <div class="vvt-ph-sub">Browse all open tenders and place your bid</div>
        </div>
        <div class="vvt-ph-badge">
          <i class="fa fa-file"></i> &nbsp;<%= totalTenders %> Tenders
        </div>
      </div>

      <!-- Tender Cards Grid -->
      <div class="vvt-grid">
      <%
        String[] tcolors = {"#27ae60","#2980b9","#8e44ad","#e67e22","#c0392b","#16a085","#2c3e50","#d35400"};
        java.util.Map<String,String> iconMap = new java.util.HashMap<String,String>();
        iconMap.put("construction","fa-building");
        iconMap.put("research","fa-flask");
        iconMap.put("maintainence","fa-wrench");
        iconMap.put("buisness","fa-briefcase");
        iconMap.put("software","fa-code");
        iconMap.put("others","fa-ellipsis-h");

        int ti = 0;
        for(TenderBean tender : tenderList){
          String tid      = tender.getId();
          String tname    = tender.getName();
          String ttype    = tender.getType();
          int    tprice   = tender.getPrice();
          String tloc     = tender.getLocation();
          java.util.Date udeadline = tender.getDeadline();
          java.sql.Date  tdeadline = new java.sql.Date(udeadline.getTime());
          String tdesc    = tender.getDesc();
          String tcolor   = tcolors[ti % tcolors.length];
          String ticon    = iconMap.containsKey(ttype) ? iconMap.get(ttype) : "fa-file";
          ti++;
      %>
        <div class="vvt-card">
          <div class="vvt-card-bar" style="background:<%= tcolor %>"></div>
          <div class="vvt-card-inner">

            <!-- Card Head -->
            <div class="vvt-card-head">
              <div class="vvt-card-icon-box" style="background:<%= tcolor %>">
                <i class="fa <%= ticon %>"></i>
              </div>
              <div class="vvt-card-title-wrap">
                <div class="vvt-card-title"><%= tname %></div>
                <div class="vvt-card-id"><i class="fa fa-hashtag"></i> &nbsp;<%= tid %></div>
              </div>
              <span class="vvt-badge" style="background:rgba(0,0,0,0.07);color:<%= tcolor %>">
                <i class="fa <%= ticon %>"></i> &nbsp;<%= ttype %>
              </span>
            </div>

            <div class="vvt-divider"></div>

            <!-- Stats Row -->
            <div class="vvt-stats-row">
              <div class="vvt-stat">
                <div class="vvt-stat-icon" style="color:<%= tcolor %>"><i class="fa fa-money"></i></div>
                <div>
                  <div class="vvt-stat-label">Base Price</div>
                  <div class="vvt-stat-val vvt-price">&#8377; <%= tprice %></div>
                </div>
              </div>
              <div class="vvt-stat">
                <div class="vvt-stat-icon" style="color:<%= tcolor %>"><i class="fa fa-map-marker"></i></div>
                <div>
                  <div class="vvt-stat-label">Location</div>
                  <div class="vvt-stat-val"><%= tloc %></div>
                </div>
              </div>
              <div class="vvt-stat">
                <div class="vvt-stat-icon" style="color:<%= tcolor %>"><i class="fa fa-calendar"></i></div>
                <div>
                  <div class="vvt-stat-label">Deadline</div>
                  <div class="vvt-stat-val vvt-deadline"><%= tdeadline %></div>
                </div>
              </div>
            </div>

            <!-- Description -->
            <div class="vvt-desc">
              <%= tdesc.length() > 130 ? tdesc.substring(0,130) + "..." : tdesc %>
            </div>

            <!-- Footer: Bid Button -->
            <div class="vvt-card-footer">
              <a href="bidTenderForm.jsp?tid=<%= tid %>&vid=<%= sessionVid %>" class="vvt-bid-btn" style="background:<%= tcolor %>">
                <i class="fa fa-gavel"></i> &nbsp;Place Bid
              </a>
            </div>

          </div>
        </div>
      <% } %>
      </div>

      <% if(totalTenders == 0){ %>
      <div class="vvt-empty">
        <i class="fa fa-folder-open-o"></i>
        <p>No tenders available right now. Check back later.</p>
      </div>
      <% } %>

    </div>
  </div>

  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
