package sqlBank;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class SqlBankDAO {
    DatabaseUtil databaseUtil = DatabaseUtil.getDatabaseUtil();

    // Get Question
    public ArrayList<SqlBankDTO> getQuestion(String quizID) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        String SQL = "select * from sqlBank where quizID = ?";
        ArrayList<SqlBankDTO> questionList = new ArrayList<>();

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            pstmt = conn.prepareStatement(SQL);

            pstmt.setInt(1, Integer.parseInt(quizID));
            rs = pstmt.executeQuery();

            while (rs.next()) {
                SqlBankDTO sqlBankDTO = new SqlBankDTO(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9),
                        rs.getString(10),
                        rs.getString(11)
                );
                questionList.add(sqlBankDTO);
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
        return questionList;
    }

    // Get QuizID For Add Question
    public int getQuizID(String title) {
        Connection conn = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        String SQL = "select quizID from sqlBank where title = ?";

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, title);
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

    // Verify Full Answer
    public int verifyAll(String quizID, String fullAnswer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;
        String dbSolution = null;
        String dbSolution2 = null;
        String dbSolution3 = null;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "SELECT Replace(solution, ' ', ''), Replace(solution2, ' ', ''), Replace(solution3, ' ', '') FROM " +
                    "sqlBank WHERE quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dbSolution = rs.getString(1);
                dbSolution2 = rs.getString(2);
                dbSolution3 = rs.getString(3);
            }

            // 줄바꿈, 앞뒤, 띄어쓰기 공백 제거
            fullAnswer = fullAnswer.replaceAll("(\\r\\n|\\r|\\n|\\n\\r|\\p{Z}|^\\p{Z}+|\\p{Z}+$)", "");

            if (fullAnswer.equalsIgnoreCase(dbSolution) ||
                    fullAnswer.equalsIgnoreCase(dbSolution2) ||
                    fullAnswer.equalsIgnoreCase(dbSolution3)) {
                return 1;
            } else {
                return -1;
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

    // Get QuizID for Next Quiz
    public int getQuizId(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        String SQL;
        int currentColumn;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "select part from sqlBank where quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, quizID);
            rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                if (rs1.getString(1).equals("dml")) {
                    SQL = "select quizID from sqlBank where part = 'dml' order by star desc, quizID asc";
                } else if (rs1.getString(1).equals("ddl")) {
                    SQL = "select quizID from sqlBank where part = 'ddl' order by star desc, quizID asc";
                } else if (rs1.getString(1).equals("dcl")) {
                    SQL = "select quizID from sqlBank where part = 'dcl' order by star desc, quizID asc";
                } else if (rs1.getString(1).equals("etc")) {
                    SQL = "select quizID from sqlBank where part = 'etc' order by star desc, quizID asc";
                }
            }
            pstmt = conn.prepareStatement(SQL);
            rs2 = pstmt.executeQuery();

            // 현재 행을 가져와 그 다음 행 return
            while (rs2.next()) {
                currentColumn = rs2.getInt(1);
                if (currentColumn == Integer.parseInt(quizID)) {
                    rs2.next();
                    return rs2.getInt(1); // 다음 문제
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (pstmt != null) pstmt.close();
                if (rs1 != null) rs1.close();
                if (rs2 != null) rs2.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -2; // 마지막 문제
    }

    // Print All SqlBank List
    public ArrayList<SqlBankDTO> getSqlBankList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;
        ArrayList<SqlBankDTO> sqlBankList = new ArrayList<>();

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "select quizID, star, user, part, title from sqlBank order by star desc";
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                SqlBankDTO sqlBankDTO = new SqlBankDTO(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5)
                );
                sqlBankList.add(sqlBankDTO);
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
        return sqlBankList;
    }

    // Print My Sql List
    public ArrayList<SqlBankDTO> getMySqlList(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;
        ArrayList<SqlBankDTO> mySqlList = new ArrayList<>();

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "select quizID, star, user, part, title from sqlBank where user = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                SqlBankDTO sqlBankDTO = new SqlBankDTO(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5)
                );
                mySqlList.add(sqlBankDTO);
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
        return mySqlList;
    }

    // Print Star Sql List
    public ArrayList<SqlBankDTO> getStarSqlList(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        String getIdSQL;
        String getStarSQL;
        ArrayList<SqlBankDTO> starSqlList = new ArrayList<>();

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            getIdSQL = "select quizID from star where user = ?";
            pstmt = conn.prepareStatement(getIdSQL);
            pstmt.setString(1, name);
            rs1 = pstmt.executeQuery();

            while (rs1.next()) {
                getStarSQL =
                        "select quizID, star, user, part, title " +
                                "from sqlBank " +
                                "where quizID = '" + rs1.getString(1) + "'";
                pstmt = conn.prepareStatement(getStarSQL);
                rs2 = pstmt.executeQuery();
                if (rs2.next()) {
                    SqlBankDTO sqlBankDTO = new SqlBankDTO(
                            rs2.getInt(1),
                            rs2.getInt(2),
                            rs2.getString(3),
                            rs2.getString(4),
                            rs2.getString(5)
                    );
                    starSqlList.add(sqlBankDTO);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
                if (pstmt != null) pstmt.close();
                if (rs1 != null) rs1.close();
                if (rs2 != null) rs2.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return starSqlList;
    }

    // Add Question
    public int addQuestion(String user, String part, String title, String question, String solution, String solution2,
                           String solution3) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "insert into sqlBank(user, part, title, question, solution, solution2, solution3) values(?,?,?," +
                    "?,?,?,?)";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user);
            pstmt.setString(2, part);
            pstmt.setString(3, title);
            pstmt.setString(4, question);
            pstmt.setString(5, solution);
            pstmt.setString(6, solution2);
            pstmt.setString(7, solution3);

            return pstmt.executeUpdate();
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
        return -2; // db 오류 or title 중복
    }

    // Edit Question
    public int editQuestion(String userName, String quizID, String part, String title, String question, String solution,
                            String solution2,
                            String solution3) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs;
        String SQL;
        String getCreatorSQL;
        String getSolutionSQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            getSolutionSQL = "select solution, solution2, solution3 from sqlBank where quizID = ?";
            pstmt = conn.prepareStatement(getSolutionSQL);
            pstmt.setString(1, quizID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                // Solution 이 수정되지 않았을경우
                if (String.valueOf(solution).equals(String.valueOf(rs.getString(1))) &&
                        String.valueOf(solution2).equals(String.valueOf(rs.getString(2))) &&
                        String.valueOf(solution3).equals(String.valueOf(rs.getString(3)))) {
                    SQL = "update sqlBank set part = ?, title = ?, question = ?, solution  = ?, " +
                            "solution2 = " +
                            "?, solution3 " +
                            "= ? where quizID = ?";
                    pstmt = conn.prepareStatement(SQL);
                    pstmt.setString(1, part);
                    pstmt.setString(2, title);
                    pstmt.setString(3, question);
                    pstmt.setString(4, solution);
                    pstmt.setString(5, solution2);
                    pstmt.setString(6, solution3);
                    pstmt.setInt(7, Integer.parseInt(quizID));

                    return pstmt.executeUpdate();
                }
            }
            getCreatorSQL = "select * from sqlBank where user = ? and quizID = ?";
            pstmt = conn.prepareStatement(getCreatorSQL);
            pstmt.setString(1, userName);
            pstmt.setInt(2, Integer.parseInt(quizID));
            rs = pstmt.executeQuery();
            if (rs.next()) {
                // 작성자 본인일경우
                SQL = "update sqlBank set part = ?, title = ?, question = ?, solution  = ?, " +
                        "solution2 = " +
                        "?, solution3 " +
                        "= ? where quizID = ?";
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, part);
                pstmt.setString(2, title);
                pstmt.setString(3, question);
                pstmt.setString(4, solution);
                pstmt.setString(5, solution2);
                pstmt.setString(6, solution3);
                pstmt.setInt(7, Integer.parseInt(quizID));

                return pstmt.executeUpdate();
            } else {
                // Solution 이 수정됐을경우
                SQL = "update sqlBank set edit = edit + 1, part = ?, title = ?, question = ?, solution  = ?, " +
                        "solution2 = " +
                        "?, solution3 " +
                        "= ? where quizID = ?";
                pstmt = conn.prepareStatement(SQL);
                pstmt.setString(1, part);
                pstmt.setString(2, title);
                pstmt.setString(3, question);
                pstmt.setString(4, solution);
                pstmt.setString(5, solution2);
                pstmt.setString(6, solution3);
                pstmt.setInt(7, Integer.parseInt(quizID));

                return pstmt.executeUpdate();
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
        return -2; // db 오류 or title 중복
    }

    // Star + 1
    public void increaseStar(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "update sqlBank set star = star + 1 where quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();
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
    }

    // Star - 1
    public void decreaseStar(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "update sqlBank set star = star - 1 where quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();
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
    }

    // Unlike + 1
    public void increaseUnlike(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "update sqlBank set unlike = unlike + 1 where quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();
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
    }

    // Unlike - 1
    public void decreaseUnlike(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;
            SQL = "update sqlBank set unlike = unlike - 1 where quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();
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
    }

    // Delete Question & Star & Unlike
    public int deleteQuestion(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String sqlBankSQL = "delete from sqlBank where quizID = ?";
        String starSQL = "delete from star where quizID = ?";
        String unlikeSQL = "delete from unlike where quizID = ?";

        try {
            conn = databaseUtil.getConnection();
            assert conn != null;

            pstmt = conn.prepareStatement(sqlBankSQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement(starSQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement(unlikeSQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            pstmt.executeUpdate();

            return 1;
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
        return -1; // db 오류
    }

    // 등록자를 가져옴
    public String getUser(String quizID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = databaseUtil.getConnection();
            SQL = "select user from sqlBank where quizID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(quizID));
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
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
        return null; // db 오류
    }

}

















