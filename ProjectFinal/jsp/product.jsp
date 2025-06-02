<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, org.json.JSONObject" %>

<%
    String productId = request.getParameter("id");
    if (productId == null || productId.trim().isEmpty()) {
        JSONObject errorJson = new JSONObject();
        errorJson.put("error", "未指定產品ID");
        out.print(errorJson.toString());
        return;
    }

    String jdbcUrl = "jdbc:mysql://localhost:3306/FinalEndFront?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei";
    String jdbcUser = "root";
    String jdbcPass = "Wayne0331";

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
            JSONObject productJson = new JSONObject();
            productJson.put("name", rs.getString("name"));
            productJson.put("description", rs.getString("description"));
            productJson.put("price", rs.getDouble("price"));
            productJson.put("image_url", rs.getString("image_url"));
            productJson.put("team", rs.getString("team"));
            productJson.put("stock", rs.getInt("stock"));

            out.print(productJson.toString());
        } else {
            JSONObject errorJson = new JSONObject();
            errorJson.put("error", "找不到此產品");
            out.print(errorJson.toString());
        }
    } catch (Exception e) {
        JSONObject errorJson = new JSONObject();
        errorJson.put("error", "資料庫錯誤：" + e.getMessage());
        out.print(errorJson.toString());
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (stmt != null) try { stmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
