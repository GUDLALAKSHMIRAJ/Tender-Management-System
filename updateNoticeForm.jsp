<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,com.hit.beans.NoticeBean,com.hit.utility.DBUtil,com.hit.dao.NoticeDao,com.hit.dao.NoticeDaoImpl,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  int noticeId = Integer.parseInt(request.getParameter("nid"));
  NoticeDao dao = new NoticeDaoImpl();
  NoticeBean notice = dao.getNoticeById(noticeId);
%>

<jsp:include page="header.jsp"></jsp:include>
<jsp:include page="adminMenu.jsp"></jsp:include>

<div class="tm-welcome-bar">
  <i class="fa fa-pencil-square-o"></i> &nbsp; Notice Management &mdash; Edit Notice
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

    <!-- Info box -->
    <div class="tm-status-box" style="margin-bottom:18px;">
      <i class="fa fa-info-circle"></i>
      Enter updated Notice Details below and click <strong>Update This Notice</strong>
    </div>

    <!-- Form card -->
    <div class="tm-glass-panel tm-form-panel">

      <div class="tm-table-header tm-header-purple">
        <i class="fa fa-bell-o"></i> &nbsp; Update Notice No. <strong><%=noticeId%></strong>
      </div>

      <form action="UpdateNoticeSrv" method="post" class="tm-form-body">
        <input type="hidden" name="nid" value="<%=noticeId%>">

        <!-- Notice Title -->
        <div class="tm-form-group">
          <label class="tm-form-label">
            <i class="fa fa-tag"></i> Notice Title
          </label>
          <input
            type="text"
            name="title"
            class="tm-form-input"
            required="required"
            value="<%=notice.getNoticeTitle()%>"
            placeholder="Enter notice title..."
          >
        </div>

        <!-- Description -->
        <div class="tm-form-group">
          <label class="tm-form-label">
            <i class="fa fa-align-left"></i> Description
          </label>
          <textarea
            name="info"
            class="tm-form-textarea"
            rows="5"
            required="required"
            placeholder="Enter notice description..."
          ><%=notice.getNoticeInfo()%></textarea>
        </div>

        <!-- Submit -->
        <div class="tm-form-footer">
          <button type="submit" class="tm-btn tm-btn-update tm-btn-lg">
            <i class="fa fa-floppy-o"></i> &nbsp; Update This Notice
          </button>
          <a href="updateNotice.jsp" class="tm-btn tm-btn-back">
            <i class="fa fa-arrow-left"></i> &nbsp; Back to List
          </a>
        </div>

      </form>
    </div><!-- end tm-form-panel -->

  </div><!-- end col-md-8 -->

</div><!-- end container-fluid -->

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
