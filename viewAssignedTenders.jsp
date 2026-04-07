<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.lang.Integer,java.lang.String,com.hit.beans.TenderStatusBean,com.hit.utility.DBUtil,java.util.List,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  <i class="fa fa-check-square-o"></i> &nbsp; Assigned Tenders Overview
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

      <div class="tm-table-header">
        <i class="fa fa-check-circle"></i> &nbsp; All Assigned Tenders
      </div>

      <div class="tm-table-responsive">
        <table class="tm-table">
          <thead>
            <tr>
              <th><i class="fa fa-tag"></i> Tender ID</th>
              <th><i class="fa fa-user"></i> Vendor ID</th>
              <th><i class="fa fa-id-card"></i> Application ID</th>
              <th><i class="fa fa-info-circle"></i> Status</th>
            </tr>
          </thead>
          <tbody>
            <%
              TenderDao dao = new TenderDaoImpl();
              List<TenderStatusBean> statusList = dao.getAllAssignedTenders();
              int rowNum = 0;
              for (TenderStatusBean status : statusList) {
                rowNum++;
            %>
            <tr class="tm-row <%= (rowNum % 2 == 0) ? "tm-row-alt" : "" %>">
              <td>
                <a href="viewTenderBidsForm.jsp?tid=<%=status.getTendorId()%>" class="tm-id-link">
                  <i class="fa fa-tag"></i> <%=status.getTendorId()%>
                </a>
              </td>
              <td>
                <a href="adminViewVendorDetail.jsp?vid=<%=status.getVendorId()%>" class="tm-id-link">
                  <i class="fa fa-user-circle-o"></i> <%=status.getVendorId()%>
                </a>
              </td>
              <td>
                <a href="viewTenderBidsForm.jsp?tid=<%=status.getTendorId()%>" class="tm-id-link">
                  <i class="fa fa-id-badge"></i> <%=status.getBidderId()%>
                </a>
              </td>
              <td>
                <span class="tm-status-badge tm-status-assigned">
                  <i class="fa fa-check-circle"></i> <%=status.getStatus()%>
                </span>
              </td>
            </tr>
            <% } %>

            <% if (statusList == null || statusList.isEmpty()) { %>
            <tr>
              <td colspan="4" class="tm-empty-row">
                <i class="fa fa-inbox"></i> No assigned tenders found.
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
