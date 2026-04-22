package DAO;

import DBcontext.DBContext;
import Model.ToyDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ToyDAO {

    // Hàm dùng chung để map ResultSet thành ToyDTO
    private ToyDTO mapResultSet(ResultSet rs) throws Exception {
        ToyDTO toy = new ToyDTO();
        toy.setToyID(rs.getInt("toyID"));
        toy.setToyName(rs.getString("toyName"));
        toy.setDescription(rs.getString("description"));
        toy.setImageURL(rs.getString("imageURL"));
        toy.setCondition(rs.getString("condition"));
        toy.setPostDate(rs.getTimestamp("postDate"));
        toy.setStatus(rs.getString("status"));
        toy.setOwnerID(rs.getString("ownerID"));
        toy.setCategoryID(rs.getInt("categoryID"));
        // Các trường JOIN (có thể null nếu query không JOIN)
        try {
            toy.setOwnerName(rs.getString("ownerName"));
        } catch (Exception e) {
        }
        try {
            toy.setCategoryName(rs.getString("categoryName"));
        } catch (Exception e) {
        }
        return toy;
    }

    // SQL cơ bản JOIN với Users và Categories để lấy tên hiển thị
    private static final String BASE_SELECT
            = "SELECT t.toyID, t.toyName, t.description, t.imageURL, t.condition, "
            + "t.postDate, t.status, t.ownerID, t.categoryID, "
            + "u.fullName AS ownerName, c.categoryName "
            + "FROM Toys t "
            + "LEFT JOIN Users u ON t.ownerID = u.userID "
            + "LEFT JOIN Categories c ON t.categoryID = c.categoryID ";

    // 1. Lấy tất cả đồ chơi (chỉ lấy Available)
    public List<ToyDTO> getAllToys() {
        List<ToyDTO> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE t.status = 'Available' ORDER BY t.postDate DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Lấy đồ chơi theo danh mục
    public List<ToyDTO> getToysByCategory(int categoryID) {
        List<ToyDTO> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE t.status = 'Available' AND t.categoryID = ? ORDER BY t.postDate DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Tìm kiếm đồ chơi theo tên
    public List<ToyDTO> searchToysByName(String keyword) {
        List<ToyDTO> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE t.status = 'Available' AND t.toyName LIKE ? ORDER BY t.postDate DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Lấy chi tiết một đồ chơi theo ID
    public ToyDTO getToyDetail(int toyID) {
        String sql = BASE_SELECT + "WHERE t.toyID = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, toyID);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
