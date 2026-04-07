<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.hit.utility.DBUtil, javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

  <%
    String user = (String)session.getAttribute("user");
    String uname = (String)session.getAttribute("username");
    String pword = (String)session.getAttribute("password");
    if(!user.equalsIgnoreCase("user") || uname.equals("") || pword.equals("")){
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
    <div class="notice">
      <div class="col-md-3" style="margin-left:2%">
        <% Connection con = DBUtil.provideConnection(); %>
        <jsp:include page="notice.jsp"></jsp:include><br>
        <jsp:include page="approved.jsp"></jsp:include><br>
      </div>
    </div>

    <div class="col-md-8">
      <div style="background:transparent;">
        <h4 style="background-color:black;margin-top:-1.8px;margin-bottom:0px;padding:5px;
                   text-align:center;color:red;font-weight:bold;">
          &nbsp;<span>Vendor Account</span>
        </h4>

        <div class="vh-dashboard">

          <!-- Welcome Banner -->
          <div class="adm-banner">
            <div class="adm-avatar"><i class="fa fa-user-circle-o"></i></div>
            <div>
              <div class="adm-title">Welcome, Vendor!</div>
              <div class="adm-subtitle">Tender Management System &#9679; Vendor Portal</div>
            </div>
            <div class="adm-clock" id="vendorClock"></div>
          </div>

          <!-- Quick Actions -->
          <div class="adm-section-title"> Quick Actions</div>
          <div class="adm-actions">
            <!-- FIXED: was viewTender.jsp (admin only) → now vendorViewTender.jsp -->
            <a href="vendorViewTender.jsp" class="adm-btn" style="--c:#27ae60;">
              <i class="fa fa-list-alt"></i><span>View Tenders</span>
            </a>
            <a href="bidTender.jsp" class="adm-btn" style="--c:#2980b9;">
              <i class="fa fa-gavel"></i><span>Bid on Tender</span>
            </a>
            <a href="bidHistory.jsp" class="adm-btn" style="--c:#8e44ad;">
              <i class="fa fa-history"></i><span>Bid History</span>
            </a>
            <a href="viewProfile.jsp" class="adm-btn" style="--c:#e74c3c;">
              <i class="fa fa-user"></i><span>My Profile</span>
            </a>
          </div>

          <!-- How It Works Cards -->
          <div class="adm-section-title"> How It Works</div>
          <div class="adm-stats">
            <div class="adm-card" style="border-top:4px solid #27ae60;">
              <div class="adm-icon" style="background:rgba(39,174,96,0.12);color:#27ae60;">
                <i class="fa fa-search"></i>
              </div>
              <div style="font-weight:700;color:#1a1a3e;font-size:15px;margin-top:8px;">Browse Tenders</div>
              <div style="color:#4a5068;font-size:13px;margin-top:6px;">
                View all available tenders with budget, location and deadline details.
              </div>
            </div>
            <div class="adm-card" style="border-top:4px solid #2980b9;">
              <div class="adm-icon" style="background:rgba(41,128,185,0.12);color:#2980b9;">
                <i class="fa fa-gavel"></i>
              </div>
              <div style="font-weight:700;color:#1a1a3e;font-size:15px;margin-top:8px;">Place Your Bid</div>
              <div style="color:#4a5068;font-size:13px;margin-top:6px;">
                Submit competitive bids on open tenders before the deadline closes.
              </div>
            </div>
            <div class="adm-card" style="border-top:4px solid #8e44ad;">
              <div class="adm-icon" style="background:rgba(142,68,173,0.12);color:#8e44ad;">
                <i class="fa fa-trophy"></i>
              </div>
              <div style="font-weight:700;color:#1a1a3e;font-size:15px;margin-top:8px;">Win the Contract</div>
              <div style="color:#4a5068;font-size:13px;margin-top:6px;">
                Highest bidder gets assigned the tender. Track your bid status anytime.
              </div>
            </div>
          </div>

          <!-- Info Strip -->
          <div class="adm-info-strip">
            <i class="fa fa-info-circle"></i>
            &nbsp; Use <strong>Tenders</strong> menu to view &amp; bid.
            Use <strong>Account</strong> menu to update your profile or change password.
          </div>

        </div>
      </div>
    </div>
  </div>

  <jsp:include page="footer.jsp"></jsp:include>

  <script>
    function updateVendorClock(){
      var now = new Date();
      var days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
      var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      var d = days[now.getDay()] + ', ' + now.getDate() + ' ' + months[now.getMonth()] + ' ' + now.getFullYear();
      var h = now.getHours(), m = now.getMinutes(), s = now.getSeconds();
      var ap = h >= 12 ? 'PM' : 'AM';
      h = h % 12; if(h === 0) h = 12;
      var t = (h<10?'0'+h:h)+':'+(m<10?'0'+m:m)+':'+(s<10?'0'+s:s)+' '+ap;
      var el = document.getElementById('vendorClock');
      if(el) el.innerHTML = d + '<br>' + t;
    }
    updateVendorClock();
    setInterval(updateVendorClock, 1000);
  </script>

</body>
</html>
