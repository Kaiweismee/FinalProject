<%@ page import="java.sql.*" %>
<%
    // 取得網址參數 id (或用 request.getAttribute 也可以)
    String productId = request.getParameter("id");
    if (productId == null || productId.trim().isEmpty()) {
        out.println("未指定產品ID");
        return;
    }

    // 資料庫連線設定
    String jdbcUrl = "jdbc:mysql://localhost:3306/FinalEndFront?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei";
    String jdbcUser = "root";
    String jdbcPass = "Wayne0331";

    String productName = "";
    String productDesc = "";
    double productPrice = 0.0;
    String productImage = "";
    String productTeam = "";
    int productStock = 0;

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

        String sql = "SELECT name, description, price, image_url, team, stock FROM products WHERE product_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, productId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            productName = rs.getString("name");
            productDesc = rs.getString("description");
            productPrice = rs.getDouble("price");
            productImage = rs.getString("image_url");
            productTeam = rs.getString("team");
            productStock = rs.getInt("stock");
        } else {
            out.println("找不到此產品");
            return;
        }
    } catch (Exception e) {
        out.println("資料庫錯誤：" + e.getMessage());
        return;
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
