<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>

/* ══════════════════════════════════════════════════════════════
   ROOT CAUSE OF LEFT-SHIFT:
   Bootstrap col-md-3 uses float:left + margin-left (percentage).
   When the footer renders inside or after a container that has
   floated children, Bootstrap can assign the footer a col-width
   causing it to act like a narrow column pushed to one side.

   THE FIX — Three layers of defense:
   1. A full-width clearfix block before the footer
   2. .tms-footer-outer uses position:relative + left:0 + width:100vw
      with a negative margin trick to break out of any Bootstrap column
   3. The bottom bar uses text-align:center AND flexbox center
══════════════════════════════════════════════════════════════ */

/* Layer 1 — clearfix helper */
.tms-clear {
  clear: both !important;
  float: none !important;
  width: 100% !important;
  display: block !important;
  height: 1px;
  margin: 0;
  padding: 0;
}

/* Layer 2 — outer wrapper breaks out of Bootstrap columns */
.tms-footer-outer {
  clear: both !important;
  float: none !important;
  width: 100% !important;
  display: block !important;
  margin-left: 0 !important;
  margin-right: 0 !important;
  padding-left: 0 !important;
  padding-right: 0 !important;
  position: relative;
  left: 0;
  box-sizing: border-box;
}

/* Layer 3 — footer itself */
.tms-footer {
  background: linear-gradient(135deg, #0d1b2a, #1a3a5c);
  color: rgba(255,255,255,0.75);
  padding: 40px 0 0 0;
  margin-top: 30px;
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  width: 100% !important;
  display: block !important;
  float: none !important;
  clear: both !important;
  box-sizing: border-box;
  margin-left: 0 !important;
}

/* 4-column flex grid */
.tms-footer-grid {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-wrap: wrap;
      flex-wrap: wrap;
  gap: 30px;
  padding: 0 60px 30px 60px;
  box-sizing: border-box;
  width: 100%;
}
.tms-footer-col {
  -webkit-box-flex: 1;
      -ms-flex: 1 1 180px;
          flex: 1 1 180px;
  min-width: 0;
}

/* Brand */
.tms-footer-brand {
  font-family: 'Black Ops One', cursive;
  font-size: 20px;
  color: #74ebd5;
  margin-bottom: 8px;
}
.tms-footer-brand-sub {
  font-size: 12px;
  color: rgba(255,255,255,0.45);
  margin-bottom: 12px;
}
.tms-footer-tagline {
  font-size: 13px;
  color: rgba(255,255,255,0.58);
  line-height: 1.7;
}

/* Heading */
.tms-footer-heading {
  font-size: 12px;
  font-weight: 700;
  color: #fff;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  margin-bottom: 14px;
  padding-bottom: 8px;
  border-bottom: 1px solid rgba(255,255,255,0.10);
}

/* Links */
.tms-footer-links { list-style: none; padding: 0; margin: 0; }
.tms-footer-links li { margin-bottom: 8px; }
.tms-footer-links a {
  color: rgba(255,255,255,0.58);
  text-decoration: none;
  font-size: 13px;
  -webkit-transition: color 0.2s;
          transition: color 0.2s;
}
.tms-footer-links a:hover { color: #74ebd5; }
.tms-footer-links .fa { margin-right: 7px; font-size: 11px; color: #74ebd5; }

/* Contact */
.tms-footer-contact-item {
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-align: flex-start;
      -ms-flex-align: flex-start;
          align-items: flex-start;
  gap: 10px;
  margin-bottom: 10px;
  font-size: 13px;
  color: rgba(255,255,255,0.60);
}
.tms-footer-contact-item .fa {
  color: #74ebd5;
  margin-top: 2px;
  -ms-flex-negative: 0;
      flex-shrink: 0;
}

/* Divider */
.tms-footer-divider {
  height: 1px;
  background: rgba(255,255,255,0.08);
  margin: 0;
  width: 100%;
  display: block;
  clear: both;
}

/* ══════════════════════════════════
   BOTTOM BAR — perfectly centred
   Uses BOTH text-align AND flexbox
   justify-content to guarantee it
══════════════════════════════════ */
.tms-footer-bottom {
  width: 100% !important;
  display: -webkit-box !important;
  display: -ms-flexbox !important;
  display: flex !important;
  -webkit-box-pack: center !important;
      -ms-flex-pack: center !important;
          justify-content: center !important;
  -webkit-box-align: center !important;
      -ms-flex-align: center !important;
          align-items: center !important;
  text-align: center !important;
  padding: 16px 20px !important;
  box-sizing: border-box;
  margin: 0 !important;
  float: none !important;
  clear: both !important;
}

.tms-footer-copy {
  font-size: 12px;
  color: rgba(255,255,255,0.40);
  text-align: center !important;
  width: 100%;
  display: block;
}
.tms-footer-copy span { color: #74ebd5; }

/* Responsive */
@media (max-width: 768px) {
  .tms-footer-grid { padding: 0 20px 20px; gap: 20px; }
}
</style>

<%-- Triple-layer clearfix — kills any Bootstrap float bleed --%>
<div class="tms-clear"></div>
<div style="clear:both;float:none;width:100%;display:block;height:0;overflow:hidden;"></div>

<div class="tms-footer-outer">
<div class="tms-footer">

  <div class="tms-footer-grid">

    <!-- Brand -->
    <div class="tms-footer-col">
      <div class="tms-footer-brand"><i class="fa fa-gavel"></i> TenderMS</div>
      <div class="tms-footer-brand-sub">Lakshmi Raj's Project</div>
      <div class="tms-footer-tagline">
        A modern, transparent and efficient tender management platform
        connecting administrators and vendors seamlessly.
      </div>
    </div>

    <!-- Quick Links -->
    <div class="tms-footer-col">
      <div class="tms-footer-heading">Quick Links</div>
      <ul class="tms-footer-links">
        <li><a href="index.jsp"><i class="fa fa-home"></i>Home</a></li>
        <li><a href="aboutUs.jsp"><i class="fa fa-info-circle"></i>About Us</a></li>
        <li><a href="vendorViewTender.jsp"><i class="fa fa-list-alt"></i>View Tenders</a></li>
        <li><a href="register.jsp"><i class="fa fa-user-plus"></i>Register</a></li>
        <li><a href="login.jsp"><i class="fa fa-sign-in"></i>Login</a></li>
      </ul>
    </div>

    <!-- For Vendors -->
    <div class="tms-footer-col">
      <div class="tms-footer-heading">For Vendors</div>
      <ul class="tms-footer-links">
        <li><a href="vendorViewTender.jsp"><i class="fa fa-search"></i>Browse Tenders</a></li>
        <li><a href="loginFailed.jsp"><i class="fa fa-gavel"></i>Place a Bid</a></li>
        <li><a href="loginFailed.jsp"><i class="fa fa-history"></i>Bid History</a></li>
        <li><a href="loginFailed.jsp"><i class="fa fa-user"></i>My Profile</a></li>
      </ul>
    </div>

    <!-- Contact -->
    <div class="tms-footer-col">
      <div class="tms-footer-heading">Contact</div>
      <div class="tms-footer-contact-item">
        <i class="fa fa-envelope"></i>
        <span>lakshmirajgudla@gmail.com</span>
      </div>
      <div class="tms-footer-contact-item">
        <i class="fa fa-phone"></i>
        <span>+91 9030794981</span>
      </div>
    </div>

  </div><!-- end tms-footer-grid -->

  <div class="tms-footer-divider"></div>

  <!-- ✅ Bottom bar — centred with 3 methods combined -->
  <div class="tms-footer-bottom">
    <div class="tms-footer-copy">
      &copy; 2026 &nbsp;<span>Tender Management System</span>&nbsp;
      &mdash; All rights reserved.
    </div>
  </div>

</div><!-- end tms-footer -->
</div><!-- end tms-footer-outer -->

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap-dropdownhover.min.js"></script>
