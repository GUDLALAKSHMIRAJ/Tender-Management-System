<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,java.lang.Integer,com.hit.beans.NoticeBean,com.hit.utility.DBUtil,java.util.List,java.util.ArrayList,com.hit.dao.NoticeDaoImpl,com.hit.dao.NoticeDao,javax.servlet.annotation.WebServlet" errorPage="errorpage.jsp"%>
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
  <i class="fa fa-bell-slash-o"></i> &nbsp; Notice Management &mdash; Remove Notices
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

      <div class="tm-table-header tm-header-danger">
        <i class="fa fa-trash"></i> &nbsp; Delete Notices
      </div>

      <div class="tm-table-responsive">
        <table class="tm-table">
          <thead>
            <tr>
              <th><i class="fa fa-hashtag"></i> Notice ID</th>
              <th><i class="fa fa-bookmark"></i> Title</th>
              <th><i class="fa fa-align-left"></i> Description</th>
              <th><i class="fa fa-trash"></i> Remove?</th>
            </tr>
          </thead>
          <tbody>
            <%
              NoticeDao dao = new NoticeDaoImpl();
              List<NoticeBean> noticeList = dao.viewAllNotice();
              int rowNum = 0;
              for (NoticeBean notice : noticeList) {
                rowNum++;
                int noticeId = notice.getNoticeId();
                String noticeTitle = notice.getNoticeTitle();
                String noticeDesc = notice.getNoticeInfo();
            %>
            <tr class="tm-row <%= (rowNum % 2 == 0) ? "tm-row-alt" : "" %>">
              <td class="tm-notice-id"><%=noticeId%></td>
              <td class="tm-notice-title"><strong><%=noticeTitle%></strong></td>
              <td class="tm-notice-desc"><%=noticeDesc%></td>
              <td>
                <a href="RemoveNoticeSrv?noticeid=<%=noticeId%>"
                   onclick="return confirm('Are you sure you want to remove this notice?');">
                  <button class="tm-btn tm-btn-reject">
                    <i class="fa fa-trash-o"></i> Remove
                  </button>
                </a>
              </td>
            </tr>
            <% } %>

            <% if (noticeList == null || noticeList.isEmpty()) { %>
            <tr>
              <td colspan="4" class="tm-empty-row">
                <i class="fa fa-inbox"></i> No notices available.
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
