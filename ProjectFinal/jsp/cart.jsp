<%@ page import="java.sql.*" %>
<%
                String jdbcUrl = "jdbc:mysql://localhost:3306/FinalEndFront?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei";
                String jdbcUser = "root";
                String jdbcPass = "Wayne0331";

                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

                    String sql = "SELECT c.product_id, p.name AS product_name, p.image_url, c.size, c.quantity, p.price, (p.price * c.quantity) AS total_price " +
                                 "FROM cart c JOIN products p ON c.product_id = p.product_id";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while(rs.next()) {
                        String productName = rs.getString("product_name");
                        String productImage = rs.getString("image_url");
                        String size = rs.getString("size");
                        int quantity = rs.getInt("quantity");
                        double price = rs.getDouble("price");
                        double totalPrice = rs.getDouble("total_price");
            %>