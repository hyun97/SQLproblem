package unlike;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UnlikeDAO {

    // Add or Remove User into Unlike
    public int handleClickUnlike(String userIP, String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet starResult;
        ResultSet unlikeResult;
        String starSQL;
        String unlikeSQL;

        try {

            DatabaseUtil databaseUtil = DatabaseUtil.getDatabaseUtil();
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

            if (unlikeResult.next()) {
                unlikeSQL = "delete from unlike where userIP = ? and quizID = ?";
                pstmt = conn.prepareStatement(unlikeSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.executeUpdate();
                return -1; // 비추천 취소
            } else if (starResult.next()) {
                starSQL = "delete from star where userIP = ? and quizID = ?";
                pstmt = conn.prepareStatement(starSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.executeUpdate();

                unlikeSQL = "insert into unlike(userIP, quizID) values(?, ?)";
                pstmt = conn.prepareStatement(unlikeSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.executeUpdate();
                return 2; // 추천 취소 후 비추천
            } else {
                unlikeSQL = "insert into unlike(userIP, quizID) values(?, ?)";
                pstmt = conn.prepareStatement(unlikeSQL);
                pstmt.setString(1, userIP);
                pstmt.setInt(2, Integer.parseInt(quizID));
                pstmt.executeUpdate();
                return 1; // 비추천
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

}
