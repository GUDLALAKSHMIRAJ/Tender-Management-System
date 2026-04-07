package com.hit.srv;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.hit.dao.BidderDao;
import com.hit.dao.BidderDaoImpl;

@WebServlet("/BidTenderSrv")
public class BidTenderSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String user  = (String) session.getAttribute("user");
        String uname = (String) session.getAttribute("username");
        String pword = (String) session.getAttribute("password");

        /* ── FIX 1: null checks + return after redirect ── */
        if (user == null || !user.equalsIgnoreCase("user")
                || uname == null || uname.equals("")
                || pword == null || pword.equals("")) {
            response.sendRedirect("loginFailed.jsp");
            return; // CRITICAL — without this, code keeps running and crashes
        }

        String bidAmount   = request.getParameter("bidamount");
        String bidDeadline = request.getParameter("biddeadline");
        String tenderId    = request.getParameter("tid");
        String vendorId    = request.getParameter("vid");

        /* ── Get vid from session if not in form params ── */
        if (vendorId == null || vendorId.trim().isEmpty()) {
            com.hit.beans.VendorBean vb =
                (com.hit.beans.VendorBean) session.getAttribute("vendordata");
            vendorId = (vb != null && vb.getId() != null) ? vb.getId() : uname;
        }

        /* ── Validate params before calling DAO ── */
        if (tenderId == null || tenderId.trim().isEmpty()
                || vendorId == null || vendorId.trim().isEmpty()
                || bidAmount == null || bidAmount.trim().isEmpty()) {
            response.sendRedirect("loginFailed.jsp");
            return;
        }

        /* ── Call DAO ── */
        String status = "Bid submission failed. Please try again.";
        try {
            BidderDao dao = new BidderDaoImpl();
            status = dao.bidTender(tenderId, vendorId, bidAmount, bidDeadline);
        } catch (Exception e) {
            e.printStackTrace();
            status = "Error: " + e.getMessage();
        }

        /* ── FIX 3: escape the status string so JS does not break ── */
        String safeStatus = status
            .replace("\\", "\\\\")
            .replace("'",  "\\'")
            .replace("\r", "")
            .replace("\n", " ");

        /* ── FIX 4: colour-code the message shown in id="show" ── */
        String lc = safeStatus.toLowerCase();
        String colour, icon;
        if (lc.contains("success") || lc.contains("placed")
                || lc.contains("submitted") || lc.contains("bid added")) {
            colour = "#27ae60";
            icon   = "fa-check-circle";
        } else if (lc.contains("already") || lc.contains("exist")) {
            colour = "#e67e22";
            icon   = "fa-exclamation-triangle";
        } else {
            colour = "#e74c3c";
            icon   = "fa-times-circle";
        }

        String htmlMsg =
            "<span style=\\'color:" + colour + ";font-weight:700;font-size:14px;\\'>" +
            "<i class=\\'fa " + icon + "\\' style=\\'margin-right:6px;\\'></i>" +
            safeStatus + "</span>";

        if (lc.contains("success") || lc.contains("placed")
                || lc.contains("submitted") || lc.contains("bid added")) {
            htmlMsg +=
                " &nbsp;<a href=\\'bidHistory.jsp\\'" +
                " style=\\'color:#1e8449;font-weight:700;text-decoration:underline;\\'>" +
                "<i class=\\'fa fa-history\\'></i> View History</a>";
        }

        /* ── FIX 5: set content type before getting writer ── */
        response.setContentType("text/html; charset=UTF-8");

        PrintWriter pw = response.getWriter();
        RequestDispatcher rd = request.getRequestDispatcher("bidTenderForm.jsp");
        rd.include(request, response);

        /* Inject JS to update id="show" div with coloured message */
        pw.print("<script>" +
                 "var el = document.getElementById('show');" +
                 "if(el){" +
                 "  el.innerHTML='" + htmlMsg + "';" +
                 "  el.style.background='rgba(39,174,96,0.10)';" +
                 "  el.style.border='1px solid rgba(39,174,96,0.35)';" +
                 "  el.style.borderLeft='4px solid " + colour + "';" +
                 "  el.scrollIntoView({behavior:'smooth',block:'center'});" +
                 "}" +
                 "</script>");
        pw.flush();
    }
}
