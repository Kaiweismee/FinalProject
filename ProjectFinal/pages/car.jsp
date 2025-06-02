<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物車範例</title>
    <link rel="stylesheet" href="../assets/css/car.css">
</head>
<body>
    <header class="header">
        <a href="../index.html"><img src="../assets/images/title-image.svg" alt="中職商品" class="title-image"></a>
        <nav class="navbar">
            <a href="aboutus.html" class="about-link">關於我們</a>
            <ul class="nav-list">
                <li class="dropdown"><a href="sectionHTML/brothers_section.html">中信兄弟系列</a></li>
                <li class="dropdown"><a href="sectionHTML/rakuten_section.html">樂天桃猿系列</a></li>
                <li class="dropdown"><a href="sectionHTML/lion_section.html">統一獅系列</a></li>
                <li class="dropdown"><a href="sectionHTML/fuben_section.html">富邦悍將系列</a></li>
                <li class="dropdown"><a href="sectionHTML/dragon_section.html">味全龍系列</a></li>
                <li class="dropdown"><a href="sectionHTML/wings_section.html">台鋼雄鷹系列</a></li>
            </ul>
            <div class="nav-icons">
                <a href="member.html" class="icon">會員登入</a>
                <a href="memberdata.html" class="icon">會員資料</a>
                <a href="car.html" class="icon">購物車</a>
            </div>
        </nav>
    </header>

    <div class="cart-section">
        <h1>購物車</h1>

        <table border="1">
            <thead>
                <tr>
                    <th>商品名稱</th>
                    <th>商品圖片</th>
                    <th>尺寸</th>
                    <th>數量</th>
                    <th>單價</th>
                    <th>小計</th>
                </tr>
            </thead>
            <tbody>
                <%@ include file="../jsp/cart.jsp"%>
                <tr>
                    <td><%= productName %></td>
                    <td><img src="<%=request.getContextPath() + productImage %>" alt="<%= productName %>" width="80"></td>
                    <td><%= size %></td>
                    <td><%= quantity %></td>
                    <td>NT$<%= String.format("%.2f", price) %></td>
                    <td>NT$<%= String.format("%.2f", totalPrice) %></td>
                </tr>
            <%
                    }
                } catch(Exception e) {
            %>
                <tr><td colspan="6">資料庫錯誤：<%= e.getMessage() %></td></tr>
            <%
                } finally {
                    try { if(rs != null) rs.close(); } catch(Exception e) {}
                    try { if(ps != null) ps.close(); } catch(Exception e) {}
                    try { if(conn != null) conn.close(); } catch(Exception e) {}
                }
            %>
            </tbody>
        </table>

        <div class="payment-options">
            <h3>付款方式</h3>
            <label>
                <input type="radio" name="paymentMethod" value="cash" onclick="showPaymentForm()"> 貨到付款
            </label><br>
            <label>
                <input type="radio" name="paymentMethod" value="creditCard" onclick="showPaymentForm()"> 線上付款
            </label>
        </div>

        <div id="paymentForm" style="display:none;">
            <h3>填寫您的資料</h3>
            <form id="checkoutForm">
                <label for="name">姓名:</label>
                <input type="text" id="name" name="name" ><br>

                <label for="address">地址:</label>
                <input type="text" id="address" name="address" required><br>

                <label for="email">信箱:</label>
                <input type="email" id="email" name="email" required><br>

                <div id="creditCardDetails" style="display:none;">
                    <label for="cardNumber">信用卡號:</label>
                    <input type="text" id="cardNumber" name="cardNumber" required><br>
                    <label for="expiryDate">信用卡到期月/年:</label>
                    <input type="text" id="expiryDate" name="expiryDate" required><br>
                </div>

                <button type="button" class="checkout-btn" onclick="checkout()">結帳</button>
            </form>
        </div>

        <div class="success-message" id="successMessage" style="display:none;">
            結帳成功！感謝您的購買，您的訂單已完成處理。
        </div>
    </div>

    <footer class="footer">
        <div class="footer-container">
            <div class="feedback-section">
                <h3>顧客回饋</h3>
                <form id="feedbackForm" action="#" method="POST">
                    <textarea name="feedback" rows="4" placeholder="請留下您的建議或意見"></textarea>
                    <button type="submit">提交回饋</button>
                </form>
                <p id="feedbackMessage" style="display: none; color: #4CAF50; margin-top: 10px;">
                    感謝您的回饋！
                </p>
            </div>
            <div class="contact-section">
                <h3>聯絡方式</h3>
                <p>地址：中原資管樓</p>
                <p>電話：123 456 789</p>
                <p>電子郵件：cyim@gmail.com</p>
            </div>
        </div>
    </footer>

    <script src="<%=request.getContextPath()%>/assets/js/feedback.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/car.js"></script>

    <script>
    function showPaymentForm() {
        var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
        var form = document.getElementById('paymentForm');
        var creditCardDetails = document.getElementById('creditCardDetails');
        if(paymentMethod === 'creditCard') {
            form.style.display = 'block';
            creditCardDetails.style.display = 'block';
        } else {
            form.style.display = 'block';
            creditCardDetails.style.display = 'none';
        }
    }

    function checkout() {
        alert("結帳功能尚未實作！");
        // 這裡可以加入你的結帳程式碼
        document.getElementById('successMessage').style.display = 'block';
    }
    </script>

</body>
</html>
