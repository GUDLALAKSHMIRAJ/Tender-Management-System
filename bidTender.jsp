<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.dao.BidderDao,com.hit.dao.BidderDaoImpl,java.lang.Integer,java.lang.String,com.hit.beans.VendorBean,com.hit.beans.TenderBean,com.hit.utility.DBUtil,java.util.List,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao,javax.servlet.annotation.WebServlet"
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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style2.css">
</head>
<body>
 	
<%
  String user = (String)session.getAttribute("user");
  String uname = (String)session.getAttribute("username");
  String pword = (String)session.getAttribute("password");
  if(user==null||!user.equalsIgnoreCase("user")||uname.equals("")||pword.equals("")){
    response.sendRedirect("loginFailed.jsp");
  }
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="vendorMenu.jsp"></jsp:include>

<div class="clearfix hidden-sm hidden-xs"
  style="color:white;background-color:green;margin-top:-15px;margin-bottom:12px">
  <marquee>Welcome to Tender Management Site</marquee>
</div>

<div class="container-fluid">

  <!-- LEFT SIDEBAR -->
  <div class="notice">
    <div class="col-md-3" style="margin-left:1%">
      <% Connection con = DBUtil.provideConnection(); %>
      <jsp:include page="notice.jsp"></jsp:include><br>
      <jsp:include page="approved.jsp"></jsp:include><br>
    </div>
  </div>

  <!-- RIGHT CONTENT -->
  <div class="col-md-8">
    <div class="vbt-page-title">
      <i class="fa fa-gavel"></i> &nbsp; Bid on Tenders
    </div>
    <div class="glass-table-wrapper">
      <table class="glass-table">
        <thead>
          <tr>
            <td>Tender Id</td>
            <td>Tender Name</td>
            <td>Type</td>
            <td>Budget</td>
            <td>Location</td>
            <td>Deadline</td>
            <td>Description</td>
            <td>Status</td>
            <td>Action</td>
          </tr>
        </thead>
        <tbody>
        <%
          TenderDao tdao = new TenderDaoImpl();
          BidderDao bdao = new BidderDaoImpl();
          List<TenderBean> tenderList = tdao.getAllTenders();
          VendorBean vendor = (VendorBean)session.getAttribute("vendordata");
          String vid = vendor.getId();
          for(TenderBean tender : tenderList){
            String tid = tender.getId();
            String tname = tender.getName();
            String ttype = tender.getType();
            int tprice = tender.getPrice();
            String tloc = tender.getLocation();
            java.util.Date udeadline = tender.getDeadline();
            java.sql.Date tdeadline = new java.sql.Date(udeadline.getTime());
            String tdesc = tender.getDesc();
            String assignStatus = tdao.getTenderStatus(tid);
            boolean isAssigned = assignStatus.equalsIgnoreCase("assigned");
        %>
          <tr>
            <td style="font-size:11px; white-space:nowrap;"><%=tid%></td>
            <td><strong><%=tname%></strong></td>
            <td><span class="vvt-type-badge"><%=ttype%></span></td>
            <td><strong>&#8377; <%=tprice%></strong></td>
            <td><i class="fa fa-map-marker" style="color:#e74c3c;"></i> <%=tloc%></td>
            <td style="white-space:nowrap;">
              <i class="fa fa-calendar" style="color:#2980b9;"></i> <%=tdeadline%>
            </td>
            <td>
              <textarea readonly cols="20" rows="2"
                style="background:rgba(255,255,255,0.6);border:1px solid rgba(255,255,255,0.8);
                border-radius:6px;padding:4px;font-size:12px;color:#1a1a3e;resize:none;"><%=tdesc%></textarea>
            </td>
            <td>
              <% if(isAssigned){ %>
                <span class="badge-assigned">Assigned</span>
              <% }else{ %>
                <span class="badge-notassigned">Open</span>
              <% } %>
            </td>
            <td>
              <% if(!isAssigned){ %>
                <a href="bidTenderForm.jsp?tid=<%=tid%>&&vid=<%=vid%>" class="vbt-bid-btn">
                  <i class="fa fa-gavel"></i> BID NOW
                </a>
              <% }else{ %>
                <button class="vbt-expired-btn" disabled>
                  <i class="fa fa-lock"></i> Expired
                </button>
              <% } %>
            </td>
          </tr>
        <%}%>
        </tbody>
      </table>
    </div>
  </div>

</div>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>