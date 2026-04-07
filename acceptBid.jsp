<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.utility.DBUtil,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
  <link rel="shortcut icon" type="image/png" href="images/logo.png">
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Accept a Bid - Tender Management System</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/annimate.css">
  <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css?family=Black+Ops+One|Poppins:300,400,600,700" rel="stylesheet">
  <link rel="stylesheet" href="css/style2.css">
  <style>
    /* ══════════════════════════════════════
       ACCEPT BID PAGE — ab- prefix
       ══════════════════════════════════════ */

    .ab-welcome-bar {
      color: white;
      background: linear-gradient(90deg, #1a1a3e, #2c3e7a);
      text-align: center;
      padding: 8px 20px;
      font-size: 15px;
      font-weight: 600;
      margin-top: -15px;
      margin-bottom: 0;
      border-bottom: 2px solid rgba(243,156,18,0.45);
    }
    .ab-welcome-bar .fa { color: #f39c12; margin-right: 6px; }

    .ab-page-wrap { padding: 20px 12px 36px; }

    /* ── Page header banner ── */
    .ab-page-header {
      display: -webkit-flex;
      display: flex;
      -webkit-align-items: center;
      align-items: center;
      gap: 16px;
      background: rgba(255,255,255,0.50);
      border: 1px solid rgba(255,255,255,0.75);
      border-radius: 16px;
      padding: 18px 24px;
      margin-bottom: 22px;
      box-shadow: 0 4px 20px rgba(31,38,135,0.10);
      animation: abSlideDown 0.45s ease both;
    }
    .ab-ph-icon {
      width: 54px; height: 54px;
      border-radius: 14px;
      background: linear-gradient(135deg, #7b4a00, #f39c12);
      display: -webkit-flex;
      display: flex;
      -webkit-align-items: center;
      align-items: center;
      -webkit-justify-content: center;
      justify-content: center;
      font-size: 24px;
      color: #fff;
      -webkit-flex-shrink: 0;
      flex-shrink: 0;
      box-shadow: 0 4px 14px rgba(243,156,18,0.38);
    }
    .ab-ph-title {
      font-size: 22px;
      font-weight: 800;
      color: #1a1a3e;
      font-family: 'Black Ops One', cursive;
    }
    .ab-ph-sub { font-size: 13px; color: #5a6080; margin-top: 3px; }

    /* ── Info strip ── */
    .ab-info-strip {
      background: rgba(243,156,18,0.10);
      border: 1px solid rgba(243,156,18,0.32);
      border-left: 4px solid #f39c12;
      border-radius: 10px;
      padding: 12px 18px;
      margin-bottom: 20px;
      font-size: 14px;
      font-weight: 600;
      color: #1a1a3e;
    }
    .ab-info-strip .fa { color: #f39c12; margin-right: 6px; }

    /* ── Step indicator ── */
    .ab-steps {
      display: -webkit-flex;
      display: flex;
      -webkit-align-items: center;
      align-items: center;
      gap: 0;
      margin-bottom: 26px;
      background: rgba(255,255,255,0.55);
      border: 1px solid rgba(255,255,255,0.80);
      border-radius: 12px;
      padding: 16px 24px;
      box-shadow: 0 3px 14px rgba(44,62,122,0.10);
      animation: abFadeUp 0.5s ease both;
      -webkit-flex-wrap: wrap;
      flex-wrap: wrap;
      gap: 8px;
    }
    .ab-step {
      display: -webkit-flex;
      display: flex;
      -webkit-align-items: center;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      font-weight: 700;
      color: #7f8c8d;
    }
    .ab-step.ab-active { color: #f39c12; }
    .ab-step.ab-done   { color: #27ae60; }
    .ab-step-num {
      width: 28px; height: 28px;
      border-radius: 50%;
      display: -webkit-inline-flex;
      display: inline-flex;
      -webkit-align-items: center;
      align-items: center;
      -webkit-justify-content: center;
      justify-content: center;
      font-size: 13px;
      font-weight: 800;
      background: rgba(172,182,229,0.30);
      color: #7f8c8d;
      -webkit-flex-shrink: 0;
      flex-shrink: 0;
    }
    .ab-step.ab-active .ab-step-num {
      background: linear-gradient(135deg, #7b4a00, #f39c12);
      color: #fff;
      box-shadow: 0 3px 10px rgba(243,156,18,0.38);
    }
    .ab-step.ab-done .ab-step-num {
      background: linear-gradient(135deg, #1e8449, #27ae60);
      color: #fff;
    }
    .ab-step-arrow {
      color: rgba(172,182,229,0.70);
      font-size: 12px;
      margin: 0 6px;
    }

    /* ── Glass panel ── */
    .ab-glass-panel {
      background: rgba(255,255,255,0.60);
      border: 1px solid rgba(255,255,255,0.80);
      border-radius: 14px;
      box-shadow: 0 8px 32px rgba(44,62,122,0.13);
      overflow: hidden;
      margin-bottom: 20px;
      animation: abFadeUp 0.5s ease both;
    }

    /* ── Table header ── */
    .ab-table-header {
      background: linear-gradient(90deg, #7b4a00 0%, #f39c12 100%);
      color: #ffffff;
      font-size: 16px;
      font-weight: 700;
      padding: 13px 22px;
      font-family: 'Black Ops One', cursive;
      letter-spacing: 1px;
    }
    .ab-table-header .fa { opacity: 0.85; margin-right: 6px; }

    /* ── Tender select area ── */
    .ab-select-wrap {
      padding: 24px 24px 20px;
    }
    .ab-select-label {
      display: block;
      font-size: 13px;
      font-weight: 700;
      color: #1a1a3e;
      margin-bottom: 8px;
      letter-spacing: 0.3px;
    }
    .ab-select-label .fa { color: #f39c12; margin-right: 6px; }

    .ab-select-row {
      display: -webkit-flex;
      display: flex;
      gap: 12px;
      -webkit-align-items: flex-end;
      align-items: flex-end;
      -webkit-flex-wrap: wrap;
      flex-wrap: wrap;
    }
    .ab-select {
      -webkit-flex: 1 1 280px;
      flex: 1 1 280px;
      padding: 11px 14px;
      font-size: 14px;
      border: 1.5px solid rgba(243,156,18,0.40);
      border-radius: 10px;
      background: rgba(255,255,255,0.82);
      color: #1a1a3e;
      outline: none;
      font-family: inherit;
      -webkit-transition: border-color 0.2s, box-shadow 0.2s;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .ab-select:focus {
      border-color: #f39c12;
      box-shadow: 0 0 0 3px rgba(243,156,18,0.14);
      background: #fff;
    }
    .ab-load-btn {
      padding: 11px 22px;
      border-radius: 10px;
      background: linear-gradient(135deg, #7b4a00, #f39c12);
      color: #fff;
      font-size: 14px;
      font-weight: 700;
      border: none;
      cursor: pointer;
      font-family: 'Black Ops One', cursive;
      letter-spacing: 0.5px;
      box-shadow: 0 3px 12px rgba(243,156,18,0.32);
      -webkit-transition: opacity 0.2s, transform 0.18s;
      transition: opacity 0.2s, transform 0.18s;
      white-space: nowrap;
    }
    .ab-load-btn:hover { opacity: 0.88; transform: translateY(-1px); }
    .ab-load-btn .fa { margin-right: 5px; }

    /* ── Bids table ── */
    .ab-table-wrap {
      overflow-x: auto;
      padding: 0 18px 18px;
    }
    .ab-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      font-size: 14px;
      color: #1a1a3e;
      background: transparent;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 2px 12px rgba(41,128,185,0.10);
    }
    .ab-table thead tr {
      background: linear-gradient(90deg, #1a1a3e 0%, #2c3e7a 100%);
    }
    .ab-table thead th {
      color: #ffffff;
      font-size: 13px;
      font-weight: 700;
      padding: 13px 14px;
      text-align: center;
      border: none;
      white-space: nowrap;
      letter-spacing: 0.3px;
    }
    .ab-table tbody tr {
      background: rgba(255,255,255,0.78);
      -webkit-transition: background 0.2s;
      transition: background 0.2s;
    }
    .ab-table tbody tr:nth-child(even) {
      background: rgba(172,182,229,0.22);
    }
    .ab-table tbody tr:hover {
      background: rgba(243,156,18,0.12) !important;
    }
    .ab-table td {
      padding: 11px 14px;
      text-align: center;
      vertical-align: middle;
      border-bottom: 1px solid rgba(172,182,229,0.30);
      color: #1a1a3e;
    }

    /* ── Bid amount ── */
    .ab-amount {
      color: #e67e22;
      font-weight: 800;
      font-size: 15px;
    }

    /* ── Bidder ID ── */
    .ab-bid-id {
      font-family: monospace;
      font-size: 12px;
      color: #2980b9;
      font-weight: 700;
    }

    /* ── Status badges ── */
    .ab-badge {
      display: inline-block;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 700;
      white-space: nowrap;
    }
    .ab-badge-pending  { background:rgba(243,156,18,0.15);  color:#e67e22; border:1px solid rgba(243,156,18,0.40); }
    .ab-badge-accepted { background:rgba(39,174,96,0.15);   color:#27ae60; border:1px solid rgba(39,174,96,0.40); }
    .ab-badge-rejected { background:rgba(231,76,60,0.12);   color:#e74c3c; border:1px solid rgba(231,76,60,0.30); }

    /* ── Remark textarea ── */
    .ab-remark {
      width: 140px;
      min-height: 48px;
      resize: vertical;
      background: rgba(255,255,255,0.72);
      border: 1px solid rgba(172,182,229,0.50);
      border-radius: 7px;
      padding: 5px 8px;
      font-size: 12px;
      color: #1a1a3e;
      font-family: inherit;
      -webkit-transition: border-color 0.2s;
      transition: border-color 0.2s;
    }
    .ab-remark:focus {
      border-color: #f39c12;
      outline: none;
      background: #fff;
    }

    /* ── Accept / Reject buttons ── */
    .ab-btn-accept {
      display: inline-block;
      padding: 7px 14px;
      border-radius: 8px;
      background: linear-gradient(135deg, #27ae60, #1e8449);
      color: #fff !important;
      font-size: 12px;
      font-weight: 700;
      border: none;
      cursor: pointer;
      text-decoration: none !important;
      box-shadow: 0 2px 8px rgba(39,174,96,0.32);
      -webkit-transition: all 0.2s;
      transition: all 0.2s;
      white-space: nowrap;
      margin-bottom: 4px;
    }
    .ab-btn-accept:hover {
      background: linear-gradient(135deg, #1e8449, #27ae60);
      color: #fff !important;
      box-shadow: 0 4px 14px rgba(39,174,96,0.50);
      transform: translateY(-1px);
    }
    .ab-btn-reject {
      display: inline-block;
      padding: 7px 14px;
      border-radius: 8px;
      background: linear-gradient(135deg, #e74c3c, #922b21);
      color: #fff !important;
      font-size: 12px;
      font-weight: 700;
      border: none;
      cursor: pointer;
      text-decoration: none !important;
      box-shadow: 0 2px 8px rgba(231,76,60,0.32);
      -webkit-transition: all 0.2s;
      transition: all 0.2s;
      white-space: nowrap;
    }
    .ab-btn-reject:hover {
      background: linear-gradient(135deg, #922b21, #e74c3c);
      color: #fff !important;
      box-shadow: 0 4px 14px rgba(231,76,60,0.50);
      transform: translateY(-1px);
    }
    .ab-btn-disabled {
      display: inline-block;
      padding: 7px 14px;
      border-radius: 8px;
      background: rgba(172,182,229,0.28);
      color: #7f8c8d;
      font-size: 12px;
      font-weight: 700;
      cursor: not-allowed;
      border: none;
      white-space: nowrap;
    }

    /* ── Empty / no tender selected ── */
    .ab-empty-state {
      padding: 48px 20px;
      text-align: center;
      color: #5a6080;
    }
    .ab-empty-state .fa {
      font-size: 50px;
      color: #c0cbe0;
      display: block;
      margin-bottom: 14px;
    }
    .ab-empty-state p { font-size: 15px; }

    /* ── Summary strip ── */
    .ab-summary {
      display: -webkit-flex;
      display: flex;
      -webkit-flex-wrap: wrap;
      flex-wrap: wrap;
      gap: 10px;
      padding: 14px 24px;
      background: rgba(243,156,18,0.07);
      border-bottom: 1px solid rgba(243,156,18,0.18);
    }
    .ab-sum-item {
      font-size: 13px;
      font-weight: 700;
      color: #1a1a3e;
    }
    .ab-sum-item span { color: #e67e22; }
    .ab-sum-divider { color: rgba(172,182,229,0.70); }

    /* ── Animations ── */
    @keyframes abSlideDown {
      from { opacity: 0; transform: translateY(-16px); }
      to   { opacity: 1; transform: translateY(0); }
    }
    @keyframes abFadeUp {
      from { opacity: 0; transform: translateY(18px); }
      to   { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

<%
  String user  = (String) session.getAttribute("user");
  String uname = (String) session.getAttribute("username");
  String pword = (String) session.getAttribute("password");
  if (user == null || !user.equalsIgnoreCase("admin") || uname == null || uname.equals("") || pword == null || pword.equals("")) {
    response.sendRedirect("loginFailed.jsp");
    return;
  }
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="adminMenu.jsp"></jsp:include>

<!-- Welcome bar -->
<div class="ab-welcome-bar">
  <i class="fa fa-gavel"></i> Accept a Bid &mdash; Review &amp; Award Tenders
</div>

<div class="container-fluid ab-page-wrap">

  <!-- Page header -->
  <div class="ab-page-header">
    <div class="ab-ph-icon"><i class="fa fa-gavel"></i></div>
    <div>
      <div class="ab-ph-title">Accept a Bid</div>
      <div class="ab-ph-sub">Select a tender, review all submitted bids and accept the best one</div>
    </div>
  </div>

  <!-- Info strip -->
  <div class="ab-info-strip">
    <i class="fa fa-info-circle"></i>
    Choose a tender from the dropdown below to load its bids. Only <strong>Pending</strong> bids can be accepted or rejected. Once a bid is accepted the tender is marked as <strong>Assigned</strong>.
  </div>

  <%
    String actionResult = (String) session.getAttribute("acceptBidResult");
    String actionType   = (String) session.getAttribute("acceptBidAction");
    if (actionResult != null) {
      session.removeAttribute("acceptBidResult");
      session.removeAttribute("acceptBidAction");
      boolean isSuccess = actionResult.toLowerCase().contains("success");
      String bgColor  = isSuccess ? "rgba(39,174,96,0.12)"  : "rgba(231,76,60,0.10)";
      String border   = isSuccess ? "#27ae60" : "#e74c3c";
      String txtColor = isSuccess ? "#1e8449" : "#c0392b";
      String faIcon   = isSuccess ? "fa-check-circle" : "fa-exclamation-circle";
  %>
  <div style="background:<%=bgColor%>;border:1px solid <%=border%>;border-left:4px solid <%=border%>;border-radius:10px;padding:13px 20px;margin-bottom:18px;font-size:14px;font-weight:600;color:<%=txtColor%>;">
    <i class="fa <%=faIcon%>" style="margin-right:7px;"></i><%=actionResult%>
  </div>
  <% } %>

  <!-- Step indicator -->
  <div class="ab-steps">
    <div class="ab-step ab-done">
      <div class="ab-step-num"><i class="fa fa-check"></i></div> Tenders Created
    </div>
    <div class="ab-step-arrow"><i class="fa fa-chevron-right"></i></div>
    <div class="ab-step ab-done">
      <div class="ab-step-num"><i class="fa fa-check"></i></div> Vendors Bid
    </div>
    <div class="ab-step-arrow"><i class="fa fa-chevron-right"></i></div>
    <div class="ab-step ab-active">
      <div class="ab-step-num">3</div> Admin Accepts Bid
    </div>
    <div class="ab-step-arrow"><i class="fa fa-chevron-right"></i></div>
    <div class="ab-step">
      <div class="ab-step-num">4</div> Tender Assigned
    </div>
  </div>

  <%
    Connection con = DBUtil.provideConnection();

    /* ── Load tender dropdown ── */
    String selectedTid = request.getParameter("tid");
    String tenderName = "";
    int tenderPrice = 0;
    String tenderLoc = "";
  %>

  <!-- Glass panel: Select Tender -->
  <div class="ab-glass-panel">
    <div class="ab-table-header"><i class="fa fa-list-alt"></i> Step 1 — Select a Tender</div>
    <div class="ab-select-wrap">
      <label class="ab-select-label"><i class="fa fa-tag"></i> Choose Tender</label>
      <form method="get" action="acceptBid.jsp">
        <div class="ab-select-row">
          <select name="tid" class="ab-select" required>
            <option value="">-- Select Tender --</option>
            <%
              try {
                ResultSet rs = con.prepareStatement("SELECT id, name FROM tender ORDER BY name").executeQuery();
                while (rs.next()) {
                  String tid  = rs.getString("id");
                  String tname = rs.getString("name");
                  String sel = (tid.equals(selectedTid)) ? "selected" : "";
            %>
            <option value="<%=tid%>" <%=sel%>><%=tid%> &mdash; <%=tname%></option>
            <%    }
                  rs.close();
              } catch (Exception ex) { ex.printStackTrace(); }
            %>
          </select>
          <button type="submit" class="ab-load-btn"><i class="fa fa-search"></i> Load Bids</button>
        </div>
      </form>
    </div>
  </div>

  <%
    if (selectedTid != null && !selectedTid.trim().isEmpty()) {
      /* ── Fetch tender info ── */
      try {
        PreparedStatement ps = con.prepareStatement("SELECT name, price, location FROM tender WHERE id=?");
        ps.setString(1, selectedTid);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
          tenderName  = rs.getString("name");
          tenderPrice = rs.getInt("price");
          tenderLoc   = rs.getString("location");
        }
        rs.close();
      } catch (Exception ex) { ex.printStackTrace(); }

      /* ── Count bids ── */
      int totalBids = 0, pendingBids = 0, acceptedBids = 0;
      try {
        ResultSet r = con.prepareStatement("SELECT COUNT(*) FROM bidder WHERE tid='" + selectedTid + "'").executeQuery();
        if (r.next()) totalBids = r.getInt(1);
        r.close();
        r = con.prepareStatement("SELECT COUNT(*) FROM bidder WHERE tid='" + selectedTid + "' AND status='Pending'").executeQuery();
        if (r.next()) pendingBids = r.getInt(1);
        r.close();
        r = con.prepareStatement("SELECT COUNT(*) FROM bidder WHERE tid='" + selectedTid + "' AND status='Accepted'").executeQuery();
        if (r.next()) acceptedBids = r.getInt(1);
        r.close();
      } catch (Exception ex) { ex.printStackTrace(); }
  %>

  <!-- Glass panel: Bids table -->
  <div class="ab-glass-panel">
    <div class="ab-table-header"><i class="fa fa-gavel"></i> Step 2 — Review Bids for: <%=tenderName%></div>

    <!-- Summary -->
    <div class="ab-summary">
      <div class="ab-sum-item">Tender ID: <span><%=selectedTid%></span></div>
      <div class="ab-sum-divider">|</div>
      <div class="ab-sum-item">Base Price: <span>&#8377; <%=tenderPrice%></span></div>
      <div class="ab-sum-divider">|</div>
      <div class="ab-sum-item">Location: <span><%=tenderLoc%></span></div>
      <div class="ab-sum-divider">|</div>
      <div class="ab-sum-item">Total Bids: <span><%=totalBids%></span></div>
      <div class="ab-sum-divider">|</div>
      <div class="ab-sum-item">Pending: <span><%=pendingBids%></span></div>
      <div class="ab-sum-divider">|</div>
      <div class="ab-sum-item">Accepted: <span style="color:#27ae60"><%=acceptedBids%></span></div>
    </div>

    <div class="ab-table-wrap">
      <%
        boolean hasBids = false;
        try {
          PreparedStatement ps2 = con.prepareStatement(
            "SELECT b.bid, b.vid, b.bidamount, b.status, v.name " +
            "FROM bidder b LEFT JOIN vendor v ON b.vid=v.vid " +
            "WHERE b.tid=? ORDER BY b.bidamount DESC"
          );
          ps2.setString(1, selectedTid);
          ResultSet brs = ps2.executeQuery();
          hasBids = brs.isBeforeFirst();

          if (hasBids) {
      %>
      <table class="ab-table">
        <thead>
          <tr>
            <th>#</th>
            <th>Bid ID</th>
            <th>Vendor ID</th>
            <th>Vendor Name</th>
            <th>Bid Amount (&#8377;)</th>
            <th>Status</th>
            <th>Remark</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <%
            int rowN = 0;
            while (brs.next()) {
              rowN++;
              String bidId   = brs.getString("bid");
              String vid     = brs.getString("vid");
              String vname   = brs.getString("name");
              int    amount  = brs.getInt("bidamount");
              String status  = brs.getString("status");
              
              if (vname == null) vname = "Unknown";
              

              String badgeClass = "ab-badge-pending";
              if ("Accepted".equalsIgnoreCase(status)) badgeClass = "ab-badge-accepted";
              else if ("Rejected".equalsIgnoreCase(status)) badgeClass = "ab-badge-rejected";
          %>
          <tr>
            <td><%=rowN%></td>
            <td><span class="ab-bid-id"><%=bidId%></span></td>
            <td><span class="ab-bid-id"><%=vid%></span></td>
            <td><strong><%=vname%></strong></td>
            <td><span class="ab-amount">&#8377; <%=amount%></span></td>
            <td><span class="ab-badge <%=badgeClass%>"><%=status%></span></td>
            <td><span style="color:#aaa;font-style:italic">—</span></td>
            <td>
              <%
                if ("Pending".equalsIgnoreCase(status)) {
              %>
              <a href="acceptBidAction.jsp?bid=<%=bidId%>&tid=<%=selectedTid%>&action=accept"
                 class="ab-btn-accept"
                 onclick="return confirm('Accept this bid from <%=vname%> for &#8377;<%=amount%>?');">
                <i class="fa fa-check"></i> Accept
              </a>
              <a href="acceptBidAction.jsp?bid=<%=bidId%>&tid=<%=selectedTid%>&action=reject"
                 class="ab-btn-reject"
                 onclick="return confirm('Reject this bid from <%=vname%>?');">
                <i class="fa fa-times"></i> Reject
              </a>
              <% } else { %>
              <span class="ab-btn-disabled"><i class="fa fa-lock"></i> <%=status%></span>
              <% } %>
            </td>
          </tr>
          <% } brs.close(); %>
        </tbody>
      </table>

      <% } else { %>
      <div class="ab-empty-state">
        <i class="fa fa-inbox"></i>
        <p>No bids have been submitted for this tender yet.</p>
      </div>
      <% } %>

      <%  } catch (Exception ex) { ex.printStackTrace(); } %>

    </div><!-- end ab-table-wrap -->
  </div><!-- end ab-glass-panel -->

  <% } else { %>

  <!-- No tender selected yet -->
  <div class="ab-glass-panel">
    <div class="ab-table-header"><i class="fa fa-gavel"></i> Step 2 — Bids</div>
    <div class="ab-empty-state">
      <i class="fa fa-hand-o-up"></i>
      <p>Please select a tender above and click <strong>Load Bids</strong> to view submitted bids.</p>
    </div>
  </div>

  <% } %>

  <!-- Back / navigation -->
  <div style="margin-top:6px">
    <a href="adminHome.jsp" class="vf-back-btn"><i class="fa fa-home"></i> Admin Home</a>
    &nbsp;
    <a href="viewTenderBids.jsp" class="vf-back-btn"><i class="fa fa-eye"></i> View All Bids</a>
  </div>

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>