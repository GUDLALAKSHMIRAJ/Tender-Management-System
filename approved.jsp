<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.hit.utility.DBUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="marquee"
		style="border: 2px #26b0b0 solid; background-color: white">

		<h4
			style="background-color: #26b0b0; margin-top: -1.8px; padding: 5px;">
			<i class="glyphicon glyphicon-volume-up"></i> &nbsp; Recently
			Approved Tenders
		</h4>
		<div class="marquee-content"
			style="padding: 10px; font-weight: bold; font-size: 1.1em">
			<marquee onmouseover="stop()" onmouseout="start()" direction="up"
				scrollamount="6" height="250">
				<!-- Approved Tenders List -->

				<%
Connection approvedConn = null;
try {
    approvedConn = DBUtil.provideConnection();
    PreparedStatement ps = approvedConn.prepareStatement("select * from tenderstatus limit 6");
    ResultSet rs = ps.executeQuery();
    while (rs.next()) {
        String bid = rs.getString("bid");
        String tid = rs.getString("tid");
%>
        <hr>
        <p style="color: red;">Application Id: &nbsp;<%= bid %></p>
        <p style="color: black">Assigned To: &nbsp;&nbsp;<%= tid %></p>
<%
    }
} catch (SQLException e) {
    e.printStackTrace();
}
%>

			</marquee>
			<!--End of marquee-->
		</div>
		<!--End of marquee content-->
	</div>
	<!--End of marquee class-->
</body>
</html>