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
  <title>View Tenders - TMS</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link href="css/bootstrap-dropdownhover.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/viewTender.css">
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

  <div class="vt-welcome-bar">
    <marquee>Welcome to Tender Management Site</marquee>
  </div>

  <div class="container-fluid">
    <div class="notice">
      <div class="col-md-3 vt-sidebar">
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
      <div class="vt-page-header">
        <div class="vt-ph-icon"><i class="fa fa-file-text-o"></i></div>
        <div>
          <div class="vt-ph-title">All Tenders</div>
          <div class="vt-ph-sub">Click a tender card to view and manage its bids</div>
        </div>
        <div class="vt-ph-badge">
          <i class="fa fa-file"></i> &nbsp;<%= totalTenders %> Tenders
        </div>
      </div>

      <!-- Tender Cards -->
      <div class="vt-grid">
      <%
        String[] tcolors   = {"#27ae60","#2980b9","#8e44ad","#e67e22","#c0392b","#16a085","#2c3e50","#d35400"};
        String[] typeIcons = new java.util.HashMap<String,String>(){{
          put("construction","fa-building");
          put("research","fa-flask");
          put("maintainence","fa-wrench");
          put("buisness","fa-briefcase");
          put("software","fa-code");
          put("others","fa-ellipsis-h");
        }}.entrySet().stream().map(e -> e.getKey()+"="+e.getValue()).toArray(String[]::new);

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
        <div class="vt-card" onclick="window.location='viewTenderBidsForm.jsp?tid=<%= tid %>'">
          <div class="vt-card-bar" style="background:<%= tcolor %>"></div>
          <div class="vt-card-inner">

            <!-- Card Header -->
            <div class="vt-card-head">
              <div class="vt-card-icon-box" style="background:<%= tcolor %>">
                <i class="fa <%= ticon %>"></i>
              </div>
              <div class="vt-card-title-wrap">
                <div class="vt-card-title"><%= tname %></div>
                <div class="vt-card-id"><i class="fa fa-hashtag"></i> &nbsp;<%= tid %></div>
              </div>
              <div class="vt-card-chevron"><i class="fa fa-chevron-right"></i></div>
            </div>

            <div class="vt-divider"></div>

            <!-- Stats Row -->
            <div class="vt-stats-row">
              <div class="vt-stat">
                <div class="vt-stat-icon" style="color:<%= tcolor %>"><i class="fa fa-money"></i></div>
                <div>
                  <div class="vt-stat-label">Budget</div>
                  <div class="vt-stat-val vt-price">&#8377; <%= tprice %></div>
                </div>
              </div>
              <div class="vt-stat">
                <div class="vt-stat-icon" style="color:<%= tcolor %>"><i class="fa fa-map-marker"></i></div>
                <div>
                  <div class="vt-stat-label">Location</div>
                  <div class="vt-stat-val"><%= tloc %></div>
                </div>
              </div>
              <div class="vt-stat">
                <div class="vt-stat-icon" style="color:<%= tcolor %>"><i class="fa fa-calendar"></i></div>
                <div>
                  <div class="vt-stat-label">Deadline</div>
                  <div class="vt-stat-val vt-deadline"><%= tdeadline %></div>
                </div>
              </div>
            </div>

            <!-- Type Badge + Desc -->
            <div class="vt-type-row">
              <span class="vt-badge" style="background:rgba(0,0,0,0.07);color:<%= tcolor %>">
                <i class="fa <%= ticon %>"></i> &nbsp;<%= ttype %>
              </span>
            </div>

            <div class="vt-desc"><%= tdesc.length() > 120 ? tdesc.substring(0,120) + "..." : tdesc %></div>

            <!-- Footer -->
            <div class="vt-card-footer">
              <a href="viewTenderBidsForm.jsp?tid=<%= tid %>" class="vt-view-btn"
                 style="border-color:<%= tcolor %>;color:<%= tcolor %>">
                <i class="fa fa-gavel"></i> &nbsp;View Bids
              </a>
            </div>

          </div>
        </div>
      <% } %>
      </div>

      <% if(totalTenders == 0){ %>
      <div class="vt-empty">
        <i class="fa fa-folder-open-o"></i>
        <p>No tenders found. Create one from the Tender menu above.</p>
      </div>
      <% } %>

    </div>
  </div>

  <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
