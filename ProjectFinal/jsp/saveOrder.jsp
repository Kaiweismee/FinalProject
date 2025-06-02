<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String email = request.getParameter("email");
    String paymentMethod = request.getParameter("paymentMethod");
    String cardNumber = request.getParameter("cardNumber");
    String expiryDate = request.getParameter("expiryDate");

    String jdbcUrl = "jdbc:mysql://localhost:3306/FinalEndFront?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Taipei";
    String jdbcUser = "root";
    String jdbcPass = "Wayne0331";

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPass);

        // 假設你有一張 orders 資料表，欄位有 name, address, email, payment_method, card_number, expiry_date, order_date
        String sql = "INSERT INTO orders (name, address, email, payment_method, card_number, expiry_date, order_date) VALUES (?, ?, ?, ?, ?, ?, NOW())";
        ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, address);
        ps.setString(3, email);
        ps.setString(4, paymentMethod);
        ps.setString(5, cardNumber != null ? cardNumber : "");
        ps.setString(6, expiryDate != null ? expiryDate : "");

        int rows = ps.executeUpdate();

        if(rows > 0){
            out.print("訂單已成功儲存，感謝您的購買！");
        } else {
            out.print("儲存訂單失敗，請稍後再試。");
        }
    } catch(Exception e) {
        out.print("資料庫錯誤：" + e.getMessage());
    } finally {
        try { if(ps != null) ps.close(); } catch(Exception e) {}
        try { if(conn != null) conn.close(); } catch(Exception e) {}
    }
%>
