package product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository {

    private final String url = "jdbc:h2:C:\\Users\\214\\Desktop\\shoppingmall-backoffice\\db\\shopingmall";
    private final String user = "sa";
    private final String password = "";



    public List<ProductDto> findAll() {
        List<ProductDto> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, price, stock_qty, reg_dt FROM product";

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ProductDto dto = new ProductDto();
                dto.setProductId(rs.getInt("product_id"));
                dto.setProductName(rs.getString("product_name"));
                dto.setPrice(rs.getInt("price"));
                dto.setStockQty(rs.getInt("stock_qty"));
                Timestamp ts = rs.getTimestamp("reg_dt");
                if (ts != null) dto.setRegDt(ts.toLocalDateTime());
                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ insert
    public boolean insert(ProductDto dto) {
        String sql = "INSERT INTO product (product_name, price, stock_qty, reg_dt) VALUES (?, ?, ?, NOW())";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getProductName());
            pstmt.setInt(2, dto.getPrice());
            pstmt.setInt(3, dto.getStockQty());

            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public boolean delete(int productId) {
        String sql = "DELETE FROM product WHERE product_id = ?";
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);
            int affected = pstmt.executeUpdate();
            return affected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}