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
  if (user == null || !user.equalsIgnoreCase("admin") || uname.equals("") || pword.equals("")) {
    response.sendRedirect("loginFailed.jsp");
  }
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="adminMenu.jsp"></jsp:include>

<div class="tm-welcome-bar">
  <i class="fa fa-gavel"></i> &nbsp; Tender Management &mdash; All Tenders
</div>

<div class="container-fluid tm-page-wrap">
  <div class="tm-glass-panel">

    <!-- Page Title -->
    <div class="tm-table-header">
      <i class="fa fa-list-alt"></i> &nbsp; All Tenders &mdash; View Bids
    </div>

    <!-- Responsive table wrapper -->
    <div class="tm-table-responsive">
      <table class="tm-table">
        <thead>
          <tr>
            <th>Tender ID</th>
            <th>Tender Name</th>
            <th>Type</th>
            <th>Price (&#8377;)</th>
            <th>Location</th>
            <th>Deadline</th>
            <th>Description</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <%
            TenderDao dao = new TenderDaoImpl();
            List<TenderBean> tenderList = dao.getAllTenders();
            int rowNum = 0;
            for (TenderBean tender : tenderList) {
              rowNum++;
              String tid = tender.getId();
              String tname = tender.getName();
              String ttype = tender.getType();
              int tprice = tender.getPrice();
              String tloc = tender.getLocation();
              java.util.Date udeadline = tender.getDeadline();
              java.sql.Date tdeadline = new java.sql.Date(udeadline.getTime());
              String tdesc = tender.getDesc();
          %>
          <tr class="tm-row <%= (rowNum % 2 == 0) ? "tm-row-alt" : "" %>">
            <td>
              <a href="viewTenderBidsForm.jsp?tid=<%=tid%>" class="tm-id-link">
                <i class="fa fa-tag"></i> <%=tid%>
              </a>
            </td>
            <td><strong><%=tname%></strong></td>
            <td><span class="tm-badge tm-badge-type"><%=ttype%></span></td>
            <td class="tm-price">&#8377; <%=tprice%></td>
            <td><i class="fa fa-map-marker"></i> <%=tloc%></td>
            <td><span class="tm-date"><i class="fa fa-calendar"></i> <%=tdeadline%></span></td>
            <td class="tm-desc-cell"><%=tdesc%></td>
            <td>
              <a href="viewTenderBidsForm.jsp?tid=<%=tid%>">
                <button class="tm-btn tm-btn-view">
                  <i class="fa fa-eye"></i> View Bids
                </button>
              </a>
            </td>
          </tr>
          <% } %>
        </tbody>
      </table>
    </div><!-- end tm-table-responsive -->

  </div><!-- end tm-glass-panel -->
</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
