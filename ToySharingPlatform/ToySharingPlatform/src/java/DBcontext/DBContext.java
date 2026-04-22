package DBcontext; // Khớp với cấu hình package mới của bạn

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    private final String serverName = "localhost";
    private final String dbName = "ToySharingDB";
    private final String portNumber = "1433";
    private final String userID = "sa";
    private final String password = "123";

    public Connection getConnection() throws Exception {
        // Chuỗi kết nối chuẩn cho SQL Server
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            DBContext db = new DBContext();
            if (db.getConnection() != null) {
                System.out.println("Chúc mừng! Kết nối SQL Server thành công.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
