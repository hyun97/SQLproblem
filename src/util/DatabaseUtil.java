package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

    public static Connection getConnection() {
        try {
            String url = "jdbc:mysql://localhost:3306/SQLproblem";
            String id = "root";
            String password = "Nkh23042304!";
            Class.forName("com.mysql.jdbc.Driver");

            return DriverManager.getConnection(url, id, password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
