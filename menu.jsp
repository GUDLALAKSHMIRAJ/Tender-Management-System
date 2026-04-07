<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class="menubar secondnav" style="background-color:white;">
    <div id="menucontent" class="container secondnav">
      <div id="collapsable-nav" class="collapse navbar-collapse hidden-lg hidden-md">
        <ul id="nav-list" class="nav navbar-nav navbar-left pull-left">

            <li id="navHomeButton">
              <a href="index.jsp"><span class="glyphicon glyphicon-home"></span> Home</a>
            </li>

            <li>
              <a href="aboutUs.jsp">About Us</a>
            </li>

            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                 data-animations="fadeIn fadeInLeft fadeInUp fadeInRight">
                Tenders <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li><a href="vendorViewTender.jsp">View all Tenders</a></li>
                <li><a href="loginFailed.jsp">Apply for a Tender</a></li>
                <li><a href="loginFailed.jsp">Bid Approval Status</a></li>
              </ul>
            </li>

            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                 data-animations="fadeIn fadeInLeft fadeInUp fadeInRight">
                Vendors <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li><a href="loginFailed.jsp">List of vendors</a></li>
                <li><a href="loginFailed.jsp">Approval Status</a></li>
                <li><a href="loginFailed.jsp">Search Vendor</a></li>
              </ul>
            </li>

            <li><a href="register.jsp">Register</a></li>

            <li>
              <form class="navbar-form hidden-xs" action="vendorSearchTender.jsp">
                <div class="form-group">
                  <input type="text" name="tid" class="form-control"
                         placeholder="Find Tenders by name"
                         style="margin-left:10px;" required>
                </div>
                <button type="submit" class="btn btn-primary">Search</button>
              </form>
            </li>

        </ul>
      </div>
    </div>
  </div>
</body>
</html>
