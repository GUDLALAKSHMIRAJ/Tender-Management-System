<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.sql.*, com.hit.utility.DBUtil, javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<jsp:include page="footer.jsp"></jsp:include>

<script>
  function updateClock(){
    var now = new Date();
    var days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
    var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    var d = days[now.getDay()] + ', ' + now.getDate() + ' ' + months[now.getMonth()] + ' ' + now.getFullYear();
    var h = now.getHours(), m = now.getMinutes(), s = now.getSeconds();
    var ampm = h >= 12 ? 'PM' : 'AM';
    h = h % 12; if(h === 0) h = 12;
    var t = (h < 10 ? '0'+h : h) + ':' + (m < 10 ? '0'+m : m) + ':' + (s < 10 ? '0'+s : s) + ' ' + ampm;
    var el = document.getElementById('adminClock');
    if(el) el.innerHTML = d + '<br>' + t;
  }
  updateClock();
  setInterval(updateClock, 1000);
</script>
</body>
</html>
  <head>
    <link rel="shortcut icon" type="image/png" href="images/logo.png">
    <!--link rel="shortcut icon" type="image/ico" href="images/hit_fevicon.ico"-->
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tender Management System</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/annimate.css">
    <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
    <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
    <!--link rel="stylesheet" href="css/styles.css"-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
    <link href="css/bootstrap-dropdownhover.min.css">
    <link rel="stylesheet" href="css/style2.css">
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


	<!-- Including the header of the page  -->
	
	<jsp:include page="header.jsp"></jsp:include>
	
	<jsp:include page="adminMenu.jsp"></jsp:include>
	
	<div class="clearfix hidden-sm hidden-xs" style="color:white;background-color: green; margin-top:-15px; margin-bottom: 12px"><marquee>Welcome to Tender Management Site</marquee>
 </div> <!--A green color line between header and body part-->
 
     <div class="container-fluid">
     
     	<div class="notice">
        <div class="col-md-3"style="margin-left:2%">
     		<% Connection con = DBUtil.provideConnection(); %>
     		
     		<jsp:include page="notice.jsp"></jsp:include><br>
     		
          <!-- Next marquee starting-->
          <jsp:include page="approved.jsp"></jsp:include><br>
          
        </div>  <!-- End of col-md-3-->
      </div> <!-- End of notice class-->
      
      
      <!-- Next part of same container-fluid in which galary or other information will be shown-->
      
          
<div class="col-md-8">
 <div class="marquee" style="border:2px black hidden; background:transparent">
  <h4 style="background-color:black; margin-top:-1.8px; margin-bottom:0px; padding:5px; text-align:center; color:red; font-weight:bold">
   &nbsp;<span id="pagetitle">Admin Account</span>
  </h4>

  <%
    /* ── DB counts using the existing 'con' connection ── */
    int totalTenders = 0, totalVendors = 0, assignedTenders = 0, totalNotices = 0, pendingBids = 0;
    try {
      ResultSet r1 = con.prepareStatement("SELECT COUNT(*) FROM tender").executeQuery();
      if(r1.next()) totalTenders = r1.getInt(1);

      ResultSet r2 = con.prepareStatement("SELECT COUNT(*) FROM vendor").executeQuery();
      if(r2.next()) totalVendors = r2.getInt(1);

      ResultSet r3 = con.prepareStatement("SELECT COUNT(*) FROM tenderstatus WHERE status='Assigned'").executeQuery();
      if(r3.next()) assignedTenders = r3.getInt(1);

      ResultSet r4 = con.prepareStatement("SELECT COUNT(*) FROM notice").executeQuery();
      if(r4.next()) totalNotices = r4.getInt(1);

      ResultSet r5 = con.prepareStatement("SELECT COUNT(*) FROM bidder WHERE status='Pending'").executeQuery();
      if(r5.next()) pendingBids = r5.getInt(1);
    } catch(Exception ex) { ex.printStackTrace(); }
  %>

  <!-- ════ DASHBOARD PANEL ════ -->
  <div id="adminDashboard">

   <!-- Welcome Banner -->
   <div class="adm-banner">
    <div class="adm-avatar"><i class="fa fa-user-circle-o"></i></div>
    <div class="adm-welcome-text">
     <div class="adm-title">Welcome Back, Admin!</div>
     <div class="adm-subtitle">Tender Management System &nbsp;&#9679;&nbsp; Full Access</div>
    </div>
    <div class="adm-clock" id="adminClock"></div>
   </div>

   <!-- Stats Row -->
   <div class="adm-stats">
    <div class="adm-card" style="border-top:4px solid #e74c3c">
     <div class="adm-icon" style="background:rgba(231,76,60,0.12); color:#e74c3c"><i class="fa fa-file-text-o"></i></div>
     <div class="adm-num" style="color:#e74c3c"><%= totalTenders %></div>
     <div class="adm-lbl">Total Tenders</div>
    </div>
    <div class="adm-card" style="border-top:4px solid #27ae60">
     <div class="adm-icon" style="background:rgba(39,174,96,0.12); color:#27ae60"><i class="fa fa-users"></i></div>
     <div class="adm-num" style="color:#27ae60"><%= totalVendors %></div>
     <div class="adm-lbl">Registered Vendors</div>
    </div>
    <div class="adm-card" style="border-top:4px solid #2980b9">
     <div class="adm-icon" style="background:rgba(41,128,185,0.12); color:#2980b9"><i class="fa fa-check-square-o"></i></div>
     <div class="adm-num" style="color:#2980b9"><%= assignedTenders %></div>
     <div class="adm-lbl">Assigned Tenders</div>
    </div>
    <div class="adm-card" style="border-top:4px solid #f39c12">
     <div class="adm-icon" style="background:rgba(243,156,18,0.12); color:#f39c12"><i class="fa fa-clock-o"></i></div>
     <div class="adm-num" style="color:#f39c12"><%= pendingBids %></div>
     <div class="adm-lbl">Pending Bids</div>
    </div>
    <div class="adm-card" style="border-top:4px solid #8e44ad">
     <div class="adm-icon" style="background:rgba(142,68,173,0.12); color:#8e44ad"><i class="fa fa-bullhorn"></i></div>
     <div class="adm-num" style="color:#8e44ad"><%= totalNotices %></div>
     <div class="adm-lbl">Active Notices</div>
    </div>
   </div>

   <!-- Quick Actions -->
   <div class="adm-section-title">&#9889; Quick Actions</div>
   <div class="adm-actions">
    <a href="createTender.jsp" class="adm-btn" style="--c:#e74c3c">
     <i class="fa fa-plus-circle"></i><span>Create Tender</span>
    </a>
    <a href="adminViewVendor.jsp" class="adm-btn" style="--c:#27ae60">
     <i class="fa fa-users"></i><span>View Vendors</span>
    </a>
    <a href="addNotice.jsp" class="adm-btn" style="--c:#8e44ad">
     <i class="fa fa-bullhorn"></i><span>Add Notice</span>
    </a>
    <a href="bidTender.jsp" class="adm-btn" style="--c:#2980b9">
     <i class="fa fa-gavel"></i><span>Manage Bids</span>
    </a>
   </div>

   <!-- Info strip -->
   <div class="adm-info-strip">
    <i class="fa fa-info-circle"></i>
    &nbsp; Use <strong>Tender</strong> menu to create &amp; assign tenders. Use <strong>Vendors</strong> to manage registrations. Use <strong>Notice</strong> to post updates.
   </div>

  </div><!-- end adminDashboard -->
 </div>
</div>
      
      
      
      
     <a><h1></h1></a>
      
    </div> <!-- End of container-fluid-->
	
	
	<!-- <div class="container" style="height:300px">
	ucomment this if you want to add some space in the lower part of page
	</div> -->



<!-- Now from here the footer section starts-->
                      
<!-- Including the footer of the page -->
    
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
