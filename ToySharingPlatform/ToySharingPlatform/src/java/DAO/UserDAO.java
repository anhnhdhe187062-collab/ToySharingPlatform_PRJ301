package DAO;

import DBcontext.DBContext;
import Model.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    // Hàm kiểm tra đăng nhập
    public UserDTO checkLogin(String user, String pass) {
        String sql = "SELECT userID, password, fullName, email, roleID FROM Users WHERE userID=? AND password=?";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.setString(2, pass);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserDTO(rs.getString("userID"), rs.getString("fullName"), rs.getString("email"), rs.getInt("roleID"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Hàm đăng ký người dùng mới
    public boolean registerUser(String id, String pass, String name, String email) {
        String sql = "INSERT INTO Users(userID, password, fullName, email, roleID) VALUES(?,?,?,?,2)";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.setString(2, pass);
            ps.setString(3, name);
            ps.setString(4, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String userID, String email, String newPassword) {
        // Bước 1: Kiểm tra xem cặp userID và email có tồn tại trong hệ thống không
        String checkSql = "SELECT userID FROM Users WHERE userID = ? AND email = ?";
        String updateSql = "UPDATE Users SET password = ? WHERE userID = ? AND email = ?";

        try (Connection conn = new DBContext().getConnection()) {
            // Kiểm tra sự tồn tại
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setString(1, userID);
                psCheck.setString(2, email);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        // Bước 2: Nếu tồn tại, tiến hành update
                        try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                            psUpdate.setString(1, newPassword);
                            psUpdate.setString(2, userID);
                            psUpdate.setString(3, email);
                            return psUpdate.executeUpdate() > 0;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
