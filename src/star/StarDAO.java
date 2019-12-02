package star;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StarDAO {
    DatabaseUtil databaseUtil = DatabaseUtil.getDatabaseUtil();

    // Add or Remove User into Star
    public int handleClickStar(String userIP, String quizID, String userName) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet starResult;
        ResultSet unlikeResult;
        String starSQL;
        String unlikeSQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;

            starSQL = "select * from star where userIP = ? and quizID = ?";
            pstmt = conn.prepareStatement(starSQL);
            pstmt.setString(1, userIP);
            pstmt.setInt(2, Integer.parseInt(quizID));
            starResult = pstmt.executeQuery();

            unlikeSQL = "select * from unlike where userIP = ? and quizID = ?";
            pstmt = conn.prepareStatement(unlikeSQL);
            pstmt.setString(1, userIP);
            pstmt.setInt(2, Integer.parseInt(quizID));
            unlikeResult = pstmt.executeQuery();

            if (starResult.next()) {
                starSQL = "delete from star where userIP = ? and quizID = ?";
                pstmt = conn.prepareStatement(starSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.executeUpdate();
                return -1; // 추천 취소
            } else if (unlikeResult.next()) {
                unlikeSQL = "delete from unlike where userIP = ? and quizID = ?";
                pstmt = conn.prepareStatement(unlikeSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.executeUpdate();

                starSQL = "insert into star(userIP, quizID, user) values(?, ?, ?)";
                pstmt = conn.prepareStatement(starSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.setString(3, userName);
                pstmt.executeUpdate();
                return 2; // 비추천 취소 후 추천
            } else {
                starSQL = "insert into star(userIP, quizID, user) values(?, ?, ?)";
                pstmt = conn.prepareStatement(starSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.setString(3, userName);
                pstmt.executeUpdate();
                return 1; // 추천
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (pstmt != null) pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2; // db 오류
    }

    // Get First QuizID
    public int getFavoriteID(String userName) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "select quizID from star where user = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (pstmt != null) pstmt.close();
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2; // db 오류
    }

    // Get QuizID for Next Favorite List
    public int nextFavoriteSQL(String userName, String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;
        int currentColumn;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "select quizID from star where user = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                currentColumn = rs.getInt(1);
                if (currentColumn == Integer.parseInt(quizID)) {
                    rs.next();
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (pstmt != null) pstmt.close();
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2; // db 오류
    }

}



















