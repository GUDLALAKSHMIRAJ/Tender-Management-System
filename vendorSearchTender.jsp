<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.lang.Integer,java.lang.String,com.hit.beans.TenderBean,com.hit.utility.DBUtil,java.util.List,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  String searchTid = request.getParameter("tid");
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="vendorMenu.jsp"></jsp:include>

<div class="tm-welcome-bar">
  <i class="fa fa-search"></i> &nbsp; Tender Search Results
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
    <div class="tm-glass-panel">

      <!-- Search result header -->
      <div class="tm-table-header" style="background:linear-gradient(90deg,#1a3e1a 0%,#27ae60 100%);">
        <i class="fa fa-search"></i> &nbsp;
        Search Results for: &nbsp;
        <span style="color:#74ebd5;font-weight:800;">
          &ldquo;<%=searchTid != null ? searchTid : ""%>&rdquo;
        </span>
      </div>

      <div class="tm-table-responsive">
        <%
          TenderDao dao = new TenderDaoImpl();
          List<TenderBean> tenderList = dao.getTenderDetails(searchTid);
          int rowNum = 0;
        %>

        <% if (tenderList == null || tenderList.isEmpty()) { %>
          <div class="tm-search-empty">
            <i class="fa fa-search" style="font-size:40px;opacity:0.3;display:block;margin-bottom:12px;"></i>
            No tender found matching <strong>&ldquo;<%=searchTid%>&rdquo;</strong>.<br>
            <small>Try searching by Tender ID or Tender Name.</small>
          </div>
        <% } else { %>

        <table class="tm-table">
          <thead>
            <tr>
              <th><i class="fa fa-tag"></i> Tender ID</th>
              <th><i class="fa fa-file-text-o"></i> Name</th>
              <th><i class="fa fa-th-list"></i> Type</th>
              <th><i class="fa fa-inr"></i> Price</th>
              <th><i class="fa fa-map-marker"></i> Location</th>
              <th><i class="fa fa-calendar"></i> Deadline</th>
              <th><i class="fa fa-align-left"></i> Description</th>
            </tr>
          </thead>
          <tbody>
            <%
              for (TenderBean tender : tenderList) {
                rowNum++;
                String tid   = tender.getId();
                String tname = tender.getName();
                String ttype = tender.getType();
                int  tprice  = tender.getPrice();
                String tloc  = tender.getLocation();
                java.sql.Date tdeadline = new java.sql.Date(tender.getDeadline().getTime());
                String tdesc = tender.getDesc();
            %>
            <tr class="tm-row <%= (rowNum % 2 == 0) ? "tm-row-alt" : "" %>">
              <td class="tm-id-cell"><%=tid%></td>
              <td><strong><%=tname%></strong></td>
              <td><span class="tm-badge tm-badge-type"><%=ttype%></span></td>
              <td class="tm-price">&#8377; <%=tprice%></td>
              <td><i class="fa fa-map-marker" style="color:#e74c3c;margin-right:3px;"></i><%=tloc%></td>
              <td><span class="tm-date"><i class="fa fa-calendar-o"></i> <%=tdeadline%></span></td>
              <td class="tm-desc-cell"><%=tdesc%></td>
            </tr>
            <% } %>
          </tbody>
        </table>

        <% } %>
      </div><!-- end tm-table-responsive -->

      <!-- Go Back -->
      <div style="padding:14px 18px;">
        <a href="javascript:history.back();" class="tm-btn tm-btn-back">
          <i class="fa fa-arrow-left"></i> &nbsp; Go Back
        </a>
      </div>

    </div><!-- end tm-glass-panel -->
  </div><!-- end col-md-8 -->

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
