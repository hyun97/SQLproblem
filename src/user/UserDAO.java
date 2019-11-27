package user;

import util.DatabaseUtil;
import util.SHA256;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

public class UserDAO {

    // 일반 회원가입
    public int signUp(UserDTO user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            SQL = "insert into user (name, password, email, email_verify) values (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getEmail());
            pstmt.setInt(4, user.getEmail_verify());
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
        return -2; // db 오류 or 이메일 중복
    }

    // 네이버로 회원가입
    public int naverLogin(String name, String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;
        Random random = new Random();

        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            SQL = "insert into user (name, email, email_verify) values (?, ?, 1)";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name + random.nextInt(100));
            pstmt.setString(2, email);
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
        return -2; // db 오류 or 이메일 중복
    }

    // 로그인
    public int login(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            SQL = "select password from user where email = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(SHA256.getSHA256(password))) {
                    return 1; // 성공
                } else {
                    return 0; // 비번 다름
                }
            } else {
                return -1; // 아이디 없음
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

    // 이름을 가져옴
    public String getName(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            SQL = "select name from user where email = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, email);
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

    // 이메일을 가져옴
    public String getEmail(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            SQL = "select email from user where name = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
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

    // 비밀번호를 가져옴
    public String getPassword(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            SQL = "select password from user where name = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
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

    // 이메일 인증 확인
    public String getEmailVerify(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            SQL = "select email_verify from user where name = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
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

    // 이메일 인증 변경
    public int setEmailVerify(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL;

        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            SQL = "update user set email_verify = 1 where name = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, name);
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
        return -2; // db 오류
    }

    // 회원 정보 수정
    public int editProfile(String name, String newName, String newEmail, String currentPassword, String newPassword) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs;
        String nameSQL1 = "update user set name = '" + newName + "' where name = '" + name + "'";
        String nameSQL2 = "update star set user = '" + newName + "' where user = '" + name + "'";
        String nameSQL3 = "update sqlBank set user = '" + newName + "' where user = '" + name + "'";
        String emailSQL = "update user set email = '" + newEmail + "' where name = ?";
        String confirmEmailSQL = "update user set email_verify = 0 where name = ?";
        String newPasswordSQL = "update user set password = '" + SHA256.getSHA256(newPassword) + "' where name = ?";
        String currentPasswordSQL = "select password from user where name = ?";
        String currentEmailSQL = "select email from user where name = ?";

        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            try {
                if (!newName.equals("")) {
                    pstmt = conn.prepareStatement(nameSQL1);
                    pstmt.executeUpdate();
                    pstmt = conn.prepareStatement(nameSQL2);
                    pstmt.executeUpdate();
                    pstmt = conn.prepareStatement(nameSQL3);
                    pstmt.executeUpdate();
                }
            } catch (Exception e) {
                e.printStackTrace();
                return 2; // 이름 중복
            }
            // 이메일이 변경 되었을 경우에만 재인증
            try {
                pstmt = conn.prepareStatement(currentEmailSQL);
                pstmt.setString(1, name);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    if (!newEmail.equals(rs.getString(1))) {
                        pstmt = conn.prepareStatement(emailSQL);
                        pstmt.setString(1, name);
                        pstmt.executeUpdate();
                        pstmt = conn.prepareStatement(confirmEmailSQL);
                        pstmt.setString(1, name);
                        pstmt.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                return 3; // 이메일 중복
            }
            if (!newPassword.equals("")) {
                pstmt = conn.prepareStatement(currentPasswordSQL);
                pstmt.setString(1, name);
                rs = pstmt.executeQuery();

                if (rs.next() && rs.getString(1).equals(SHA256.getSHA256(currentPassword))) {
                    // 비밀번호 인증 성공
                    pstmt = conn.prepareStatement(newPasswordSQL);
                    pstmt.setString(1, name);
                    pstmt.executeUpdate();
                } else {
                    // 비밀번호 인증 실패
                    return 0;
                }
            }
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
        return -2; // db 오류
    }

}























