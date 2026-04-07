<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.hit.utility.DBUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <link rel="shortcut icon" type="image/png" href="images/logo.png">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tender Management System</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="css/bootstrap-dropdownhover.min.css">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/galary.css">
</head>
<body>

<%
  /* ══════════════════════════════════════════════════════════
     LIVE DB COUNTS — queried fresh on every page load.
     These replace the old hardcoded animateCount numbers.
     When a vendor registers, bid is placed, or tender created
     the numbers update automatically on the next page load.
  ══════════════════════════════════════════════════════════ */
  int liveTenders  = 0;
  int liveVendors  = 0;
  int liveAssigned = 0;
  int liveBids     = 0;

  Connection glCon = null;
  try {
    glCon = DBUtil.provideConnection();
    Statement glSt = glCon.createStatement();
    ResultSet glRs;

    glRs = glSt.executeQuery("SELECT COUNT(*) FROM tender");
    if (glRs.next()) liveTenders = glRs.getInt(1);

    glRs = glSt.executeQuery("SELECT COUNT(*) FROM vendor");
    if (glRs.next()) liveVendors = glRs.getInt(1);

    glRs = glSt.executeQuery("SELECT COUNT(*) FROM tenderstatus WHERE status='Assigned'");
    if (glRs.next()) liveAssigned = glRs.getInt(1);

    glRs = glSt.executeQuery("SELECT COUNT(*) FROM bidder");
    if (glRs.next()) liveBids = glRs.getInt(1);

    glRs.close();
    glSt.close();
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    DBUtil.closeConnection(glCon);
  }
%>

<div class="col-md-8 gl-outer">

  <!-- ══ HERO CAROUSEL ══ -->
  <div class="gl-carousel-wrap">
    <div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3000">

      <!-- Indicators -->
      <ol class="carousel-indicators gl-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
        <li data-target="#myCarousel" data-slide-to="3"></li>
        <li data-target="#myCarousel" data-slide-to="4"></li>
        <li data-target="#myCarousel" data-slide-to="5"></li>
      </ol>

      <div class="carousel-inner gl-carousel-inner">

        <div class="item active gl-slide">
          <img src="images/home1.jpg" class="gl-slide-img" alt="Tender Site">
          <div class="gl-slide-caption">
            <div class="gl-caption-title"><i class="fa fa-building"></i> &nbsp;Infrastructure Excellence</div>
            <div class="gl-caption-sub">Building the future, one tender at a time</div>
          </div>
        </div>

        <div class="item gl-slide">
          <img src="images/library1.png" class="gl-slide-img" alt="Projects">
          <div class="gl-slide-caption">
            <div class="gl-caption-title"><i class="fa fa-file-text-o"></i> &nbsp;Project Management</div>
            <div class="gl-caption-sub">Transparent and efficient tender handling</div>
          </div>
        </div>

        <div class="item gl-slide">
          <img src="images/cap.jpg" class="gl-slide-img" alt="Achievement">
          <div class="gl-slide-caption">
            <div class="gl-caption-title"><i class="fa fa-trophy"></i> &nbsp;Award-Winning Contracts</div>
            <div class="gl-caption-sub">Connecting vendors with the best opportunities</div>
          </div>
        </div>

        <div class="item gl-slide">
          <img src="images/onwork.jpg" class="gl-slide-img" alt="On Work">
          <div class="gl-slide-caption">
            <div class="gl-caption-title"><i class="fa fa-wrench"></i> &nbsp;Active Development</div>
            <div class="gl-caption-sub">Real projects, real impact across the nation</div>
          </div>
        </div>

        <div class="item gl-slide">
          <img src="images/building.jpg" class="gl-slide-img" alt="Building">
          <div class="gl-slide-caption">
            <div class="gl-caption-title"><i class="fa fa-home"></i> &nbsp;Construction &amp; Design</div>
            <div class="gl-caption-sub">Modern infrastructure for a growing India</div>
          </div>
        </div>

        <div class="item gl-slide">
          <img src="images/building2.jpg" class="gl-slide-img" alt="Building 2">
          <div class="gl-slide-caption">
            <div class="gl-caption-title"><i class="fa fa-line-chart"></i> &nbsp;Growing Partnerships</div>
            <div class="gl-caption-sub">Join thousands of registered vendors today</div>
          </div>
        </div>

      </div>

      <!-- Controls -->
      <a class="left carousel-control gl-ctrl-left" href="#myCarousel" data-slide="prev">
        <i class="fa fa-chevron-left"></i>
      </a>
      <a class="right carousel-control gl-ctrl-right" href="#myCarousel" data-slide="next">
        <i class="fa fa-chevron-right"></i>
      </a>

    </div>
  </div>
  <!-- ══ END CAROUSEL ══ -->


  <!-- ══ STATS STRIP ══ -->
  <div class="gl-stats-strip">
    <div class="gl-stat">
      <div class="gl-stat-num" id="cntTenders">0</div>
      <div class="gl-stat-lbl"><i class="fa fa-file-text-o"></i> &nbsp;Active Tenders</div>
    </div>
    <div class="gl-stat-divider"></div>
    <div class="gl-stat">
      <div class="gl-stat-num" id="cntVendors">0</div>
      <div class="gl-stat-lbl"><i class="fa fa-users"></i> &nbsp;Registered Vendors</div>
    </div>
    <div class="gl-stat-divider"></div>
    <div class="gl-stat">
      <div class="gl-stat-num" id="cntAssigned">0</div>
      <div class="gl-stat-lbl"><i class="fa fa-check-circle"></i> &nbsp;Assigned Tenders</div>
    </div>
    <div class="gl-stat-divider"></div>
    <div class="gl-stat">
      <div class="gl-stat-num" id="cntBids">0</div>
      <div class="gl-stat-lbl"><i class="fa fa-gavel"></i> &nbsp;Total Bids</div>
    </div>
  </div>
  <!-- ══ END STATS ══ -->


  <!-- ══ SECTION TITLE ══ -->
  <div class="gl-section-title">
    <span class="gl-section-line"></span>
    <span class="gl-section-text"> &nbsp;What We Offer</span>
    <span class="gl-section-line"></span>
  </div>


  <!-- ══ FEATURE CARDS ══ -->
  <div class="gl-features">

    <div class="gl-feat-card" style="--accent:#27ae60;">
      <div class="gl-feat-icon-wrap" style="background:rgba(39,174,96,0.12);">
        <i class="fa fa-file-text-o" style="color:#27ae60;"></i>
      </div>
      <div class="gl-feat-title">View Tenders</div>
      <div class="gl-feat-desc">Browse all available tenders with full details — budget, location, deadline and type — all in one place.</div>
      <div class="gl-feat-bar" style="background:#27ae60;"></div>
    </div>

    <div class="gl-feat-card" style="--accent:#2980b9;">
      <div class="gl-feat-icon-wrap" style="background:rgba(41,128,185,0.12);">
        <i class="fa fa-gavel" style="color:#2980b9;"></i>
      </div>
      <div class="gl-feat-title">Place Bids</div>
      <div class="gl-feat-desc">Submit competitive bids on open tenders quickly and efficiently before the deadline closes.</div>
      <div class="gl-feat-bar" style="background:#2980b9;"></div>
    </div>

    <div class="gl-feat-card" style="--accent:#8e44ad;">
      <div class="gl-feat-icon-wrap" style="background:rgba(142,68,173,0.12);">
        <i class="fa fa-line-chart" style="color:#8e44ad;"></i>
      </div>
      <div class="gl-feat-title">Track Status</div>
      <div class="gl-feat-desc">Monitor your bid status and tender results in real-time. Know instantly if you've won.</div>
      <div class="gl-feat-bar" style="background:#8e44ad;"></div>
    </div>

    <div class="gl-feat-card" style="--accent:#e67e22;">
      <div class="gl-feat-icon-wrap" style="background:rgba(230,126,34,0.12);">
        <i class="fa fa-shield" style="color:#e67e22;"></i>
      </div>
      <div class="gl-feat-title">Secure Platform</div>
      <div class="gl-feat-desc">All transactions and vendor registrations are handled securely with role-based access control.</div>
      <div class="gl-feat-bar" style="background:#e67e22;"></div>
    </div>

    <div class="gl-feat-card" style="--accent:#c0392b;">
      <div class="gl-feat-icon-wrap" style="background:rgba(192,57,43,0.12);">
        <i class="fa fa-bell" style="color:#c0392b;"></i>
      </div>
      <div class="gl-feat-title">Live Notices</div>
      <div class="gl-feat-desc">Stay updated with real-time notices posted by administrators directly to the notice board.</div>
      <div class="gl-feat-bar" style="background:#c0392b;"></div>
    </div>

    <div class="gl-feat-card" style="--accent:#16a085;">
      <div class="gl-feat-icon-wrap" style="background:rgba(22,160,133,0.12);">
        <i class="fa fa-handshake-o" style="color:#16a085;"></i>
      </div>
      <div class="gl-feat-title">Vendor Network</div>
      <div class="gl-feat-desc">Connect with a growing network of verified vendors and contractors across multiple sectors.</div>
      <div class="gl-feat-bar" style="background:#16a085;"></div>
    </div>

  </div>
  <!-- ══ END FEATURES ══ -->


  <!-- ══ HOW IT WORKS ══ -->
  <div class="gl-section-title">
    <span class="gl-section-line"></span>
    <span class="gl-section-text"><i class="fa fa-cogs"></i> &nbsp;How It Works</span>
    <span class="gl-section-line"></span>
  </div>

  <div class="gl-steps">
    <div class="gl-step">
      <div class="gl-step-num" style="background:linear-gradient(135deg,#1a6b4a,#27ae60);">1</div>
      <div class="gl-step-connector"></div>
      <div class="gl-step-title">Register as Vendor</div>
      <div class="gl-step-desc">Create your vendor account with company details to get started.</div>
    </div>
    <div class="gl-step">
      <div class="gl-step-num" style="background:linear-gradient(135deg,#1a3a6b,#2980b9);">2</div>
      <div class="gl-step-connector"></div>
      <div class="gl-step-title">Browse Tenders</div>
      <div class="gl-step-desc">Explore all open tenders and find the ones that match your expertise.</div>
    </div>
    <div class="gl-step">
      <div class="gl-step-num" style="background:linear-gradient(135deg,#4a0060,#8e44ad);">3</div>
      <div class="gl-step-connector"></div>
      <div class="gl-step-title">Submit Your Bid</div>
      <div class="gl-step-desc">Place a competitive bid before the deadline with your proposed amount.</div>
    </div>
    <div class="gl-step">
      <div class="gl-step-num" style="background:linear-gradient(135deg,#7b4f00,#e67e22);">4</div>
      <div class="gl-step-connector-last"></div>
      <div class="gl-step-title">Win the Contract</div>
      <div class="gl-step-desc">The admin reviews bids and assigns the tender to the best vendor.</div>
    </div>
  </div>
  <!-- ══ END HOW IT WORKS ══ -->


  <!-- ══ CTA BANNER ══ -->
  <div class="gl-cta">
    <div class="gl-cta-icon"><i class="fa fa-rocket"></i></div>
    <div class="gl-cta-title">Start Exploring Tenders Today</div>
    <div class="gl-cta-sub">Find the best opportunities and grow your business. Register now and join our growing vendor community.</div>
    <div class="gl-cta-btns">
      <a href="register.jsp" class="gl-cta-btn-primary">
        <i class="fa fa-user-plus"></i> &nbsp;Register Now
      </a>
      <a href="login.jsp" class="gl-cta-btn-outline">
        <i class="fa fa-sign-in"></i> &nbsp;Login
      </a>
    </div>
  </div>
  <!-- ══ END CTA ══ -->

</div>
<!-- End col-md-8 -->

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/ajax-utils.js"></script>
<script src="js/script.js"></script>
<script src="js/bootstrap-dropdownhover.min.js"></script>

<script>
/* ══════════════════════════════════════════════════════════
   ANIMATED COUNTER — counts up from 0 to the real DB value.
   The target numbers are written by JSP at page-load time,
   so they are ALWAYS accurate: no hardcoding, no guessing.

   How it works:
     JSP queries DB → writes real numbers into JS variables
     → animateCount runs from 0 up to that real number.

   Every time the page loads the DB is queried fresh, so
   new vendors, tenders, bids etc. show immediately.
══════════════════════════════════════════════════════════ */

/* Real counts from DB — written by JSP */
var DB_TENDERS  = <%= liveTenders %>;
var DB_VENDORS  = <%= liveVendors %>;
var DB_ASSIGNED = <%= liveAssigned %>;
var DB_BIDS     = <%= liveBids %>;

function animateCount(id, target, duration) {
  var el = document.getElementById(id);
  if (!el || target === 0) {
    if (el) el.textContent = '0';
    return;
  }
  var start = 0;
  var step = Math.ceil(target / (duration / 30));
  var timer = setInterval(function() {
    start += step;
    if (start >= target) {
      start = target;
      clearInterval(timer);
    }
    el.textContent = start + '+';
  }, 30);
}

window.onload = function() {
  animateCount('cntTenders',  DB_TENDERS,  800);
  animateCount('cntVendors',  DB_VENDORS,  900);
  animateCount('cntAssigned', DB_ASSIGNED, 700);
  animateCount('cntBids',     DB_BIDS,     1000);
};
</script>

</body>
</html>
