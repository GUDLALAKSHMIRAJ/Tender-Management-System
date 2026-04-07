<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.dao.BidderDao,com.hit.dao.BidderDaoImpl,java.lang.Integer,com.hit.beans.BidderBean,com.hit.utility.DBUtil,java.util.List,java.util.ArrayList,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  String currentTid = request.getParameter("tid");
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="adminMenu.jsp"></jsp:include>

<div class="tm-welcome-bar">
  <i class="fa fa-gavel"></i> &nbsp; Manage Bids &mdash; Accept or Reject
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

      <!-- Status message box (updated by servlet via JS) -->
      <div id="show" class="tm-status-box">
        <i class="fa fa-info-circle"></i>
        Bids for Tender ID: <strong><%=currentTid != null ? currentTid : ""%></strong>
      </div>

      <div class="tm-table-header">
        <i class="fa fa-users"></i> &nbsp; Vendor Bid Applications
      </div>

      <div class="tm-table-responsive">
        <table class="tm-table">
          <thead>
            <tr>
              <th><i class="fa fa-id-badge"></i> Bidder ID</th>
              <th><i class="fa fa-user"></i> Vendor ID</th>
              <th><i class="fa fa-inr"></i> Bid Amount</th>
              <th><i class="fa fa-calendar"></i> Deadline</th>
              <th><i class="fa fa-info-circle"></i> Status</th>
              <th><i class="fa fa-check-circle"></i> Accept</th>
              <th><i class="fa fa-times-circle"></i> Reject</th>
            </tr>
          </thead>
          <tbody>
            <%
              BidderDao dao = new BidderDaoImpl();
              List<BidderBean> bidderList = dao.getAllBidsOfaTender(currentTid);
              int rowNum = 0;
              for (BidderBean bidder : bidderList) {
                rowNum++;
                boolean isPending = bidder.getBidStatus().equalsIgnoreCase("pending");
                String statusClass = "tm-status-pending";
                if (bidder.getBidStatus().equalsIgnoreCase("Accepted")) statusClass = "tm-status-accepted";
                if (bidder.getBidStatus().equalsIgnoreCase("Rejected")) statusClass = "tm-status-rejected";
                java.sql.Date sqlDeadline = new java.sql.Date(bidder.getBidDeadline().getTime());
            %>
            <tr class="tm-row <%= (rowNum % 2 == 0) ? "tm-row-alt" : "" %>">
              <td class="tm-id-cell"><%=bidder.getBidId()%></td>
              <td>
                <a href="adminViewVendorDetail.jsp?vid=<%=bidder.getVendorId()%>" class="tm-id-link">
                  <i class="fa fa-user-circle-o"></i> <%=bidder.getVendorId()%>
                </a>
              </td>
              <td class="tm-price">&#8377; <%=bidder.getBidAmount()%></td>
              <td><i class="fa fa-calendar-o"></i> <%=sqlDeadline%></td>
              <td><span class="tm-status-badge <%=statusClass%>"><%=bidder.getBidStatus()%></span></td>

              <%-- Accept button --%>
              <td>
                <% if (isPending) { %>
                  <a href="AcceptBidSrv?bid=<%=bidder.getBidId()%>&tid=<%=bidder.getTenderId()%>&vid=<%=bidder.getVendorId()%>">
                    <button class="tm-btn tm-btn-accept">
                      <i class="fa fa-check"></i> Accept
                    </button>
                  </a>
                <% } else { %>
                  <button class="tm-btn tm-btn-disabled" disabled>
                    <i class="fa fa-check"></i> <%=bidder.getBidStatus()%>
                  </button>
                <% } %>
              </td>

              <%-- Reject button --%>
              <td>
                <% if (isPending) { %>
                  <a href="RejectBidSrv?bid=<%=bidder.getBidId()%>&tid=<%=bidder.getTenderId()%>&vid=<%=bidder.getVendorId()%>">
                    <button class="tm-btn tm-btn-reject">
                      <i class="fa fa-times"></i> Reject
                    </button>
                  </a>
                <% } else { %>
                  <button class="tm-btn tm-btn-disabled" disabled>
                    <i class="fa fa-times"></i> <%=bidder.getBidStatus()%>
                  </button>
                <% } %>
              </td>
            </tr>
            <% } %>

            <% if (bidderList == null || bidderList.isEmpty()) { %>
            <tr>
              <td colspan="7" class="tm-empty-row">
                <i class="fa fa-inbox"></i> No bids found for this tender.
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div><!-- end tm-table-responsive -->

    </div><!-- end tm-glass-panel -->
  </div><!-- end col-md-8 -->

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
