package com.hit.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hit.beans.BidderBean;
import com.hit.utility.DBUtil;
import com.hit.utility.IDUtil;

public class BidderDaoImpl implements BidderDao {

    /*
     * ══════════════════════════════════════════════════
     *  DB COLUMN REFERENCE (bidder table):
     *    bid        → application/bid ID  (PRIMARY KEY)
     *    vid        → vendor ID
     *    tid        → tender ID
     *    bidamount  → bid amount (int)
     *    deadline   → deadline (date)
     *    status     → Pending / Accepted / Rejected
     * ══════════════════════════════════════════════════
     */

    /* ── ACCEPT BID ─────────────────────────────────── */
    @Override
    public String acceptBid(String applicationId, String tenderId, String vendorId) {
        String status = "Bid Acceptance Failed";

        Connection con = DBUtil.provideConnection();
        PreparedStatement ps  = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            /* Check if tender is already assigned */
            ps = con.prepareStatement("SELECT * FROM tenderstatus WHERE tid=?");
            ps.setString(1, tenderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                status = "Project Already Assigned";
            } else {
                /* FIX: column is 'bid' not 'bid_id' */
                pst = con.prepareStatement(
                    "UPDATE bidder SET status=? WHERE bid=? AND status=?"
                );
                pst.setString(1, "Accepted");
                pst.setString(2, applicationId);
                pst.setString(3, "Pending");

                int x = pst.executeUpdate();
                if (x > 0) {
                    status = "Bid Has Been Accepted Successfully!";
                    TenderDao dao = new TenderDaoImpl();
                    status = status + "<br>" + dao.assignTender(tenderId, vendorId, applicationId);
                } else {
                    status = "Bid not found or already processed.";
                }
            }

        } catch (SQLException e) {
            status = "Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(rs);
            DBUtil.closeConnection(pst);
            DBUtil.closeConnection(ps);
            DBUtil.closeConnection(con);
        }
        return status;
    }

    /* ── REJECT BID ─────────────────────────────────── */
    @Override
    public String rejectBid(String applicationId) {
        String status = "Bid Rejection Failed";

        Connection con = DBUtil.provideConnection();
        PreparedStatement ps = null;

        try {
            /* FIX: column is 'bid' not 'bid_id' */
            ps = con.prepareStatement(
                "UPDATE bidder SET status=? WHERE bid=? AND status=?"
            );
            ps.setString(1, "Rejected");
            ps.setString(2, applicationId);
            ps.setString(3, "Pending");

            int x = ps.executeUpdate();
            if (x > 0) {
                status = "Bid Has Been Rejected Successfully!";
            } else {
                status = "Bid not found or already processed.";
            }

        } catch (SQLException e) {
            status = "Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(ps);
            DBUtil.closeConnection(con);
        }
        return status;
    }

    /* ── BID FOR TENDER ─────────────────────────────── */
    @Override
    public String bidTender(String tenderId, String vendorId,
                            String bidAmount, String bidDeadline) {
        String status = "Tender Bidding Failed!";

        String bidId     = IDUtil.generateBidderId();
        String bidStatus = "Pending";

        BidderBean bidder = new BidderBean(
            bidId, vendorId, tenderId, bidAmount, bidDeadline, bidStatus
        );

        Connection con = DBUtil.provideConnection();
        PreparedStatement ps = null;

        try {
            /* FIX: check if vendor already bid on this tender */
            PreparedStatement chk = con.prepareStatement(
                "SELECT bid FROM bidder WHERE vid=? AND tid=?"
            );
            chk.setString(1, vendorId);
            chk.setString(2, tenderId);
            ResultSet chkRs = chk.executeQuery();
            if (chkRs.next()) {
                chkRs.close();
                chk.close();
                return "You have already placed a bid for this tender!";
            }
            chkRs.close();
            chk.close();

            ps = con.prepareStatement(
                "INSERT INTO bidder VALUES(?,?,?,?,?,?)"
            );
            ps.setString(1, bidId);
            ps.setString(2, vendorId);
            ps.setString(3, tenderId);
            ps.setInt(4, bidder.getBidAmount());

            java.sql.Date bidDate = new java.sql.Date(
                bidder.getBidDeadline().getTime()
            );
            ps.setDate(5, bidDate);
            ps.setString(6, bidStatus);

            int x = ps.executeUpdate();

            /* FIX: status is now set correctly on both success AND failure */
            if (x > 0) {
                status = "You have successfully Bid for the tender";
            } else {
                status = "Bid insertion failed. Please try again.";
            }

        } catch (SQLException e) {
            /* FIX: was swallowing exception silently — now reports it */
            status = "Database Error: " + e.getMessage();
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(ps);
            DBUtil.closeConnection(con);
        }

        return status;
    }

    /* ── GET ALL BIDS OF A TENDER ───────────────────── */
    @Override
    public List<BidderBean> getAllBidsOfaTender(String tenderId) {
        List<BidderBean> bidderList = new ArrayList<BidderBean>();

        Connection con = DBUtil.provideConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = con.prepareStatement("SELECT * FROM bidder WHERE tid=?");
            ps.setString(1, tenderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                BidderBean bidder = new BidderBean();
                /* FIX: column is 'bid' not 'bid_id' */
                bidder.setBidId(rs.getString("bid"));
                bidder.setVendorId(rs.getString("vid"));
                bidder.setTenderId(rs.getString("tid"));
                bidder.setBidAmount(rs.getInt("bidamount"));
                bidder.setBidDeadline(
                    new java.sql.Date(rs.getDate("deadline").getTime())
                );
                bidder.setBidStatus(rs.getString("status"));
                bidderList.add(bidder);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(rs);
            DBUtil.closeConnection(ps);
            DBUtil.closeConnection(con);
        }

        return bidderList;
    }

    /* ── GET ALL BIDS OF A VENDOR ───────────────────── */
    @Override
    public List<BidderBean> getAllBidsOfaVendor(String vendorId) {
        List<BidderBean> bidderList = new ArrayList<BidderBean>();

        Connection con = DBUtil.provideConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = con.prepareStatement("SELECT * FROM bidder WHERE vid=?");
            ps.setString(1, vendorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                BidderBean bidder = new BidderBean();
                /* FIX: column is 'bid' not 'bid_id' */
                bidder.setBidId(rs.getString("bid"));
                bidder.setVendorId(rs.getString("vid"));
                bidder.setTenderId(rs.getString("tid"));
                bidder.setBidAmount(rs.getInt("bidamount"));
                bidder.setBidDeadline(
                    new java.sql.Date(rs.getDate("deadline").getTime())
                );
                bidder.setBidStatus(rs.getString("status"));
                bidderList.add(bidder);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(rs);
            DBUtil.closeConnection(ps);
            DBUtil.closeConnection(con);
        }

        return bidderList;
    }
}
