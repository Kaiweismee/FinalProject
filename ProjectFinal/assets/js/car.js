// 計算總計與每項小計
function updateTotal() {
    const rows = document.querySelectorAll("tbody tr");
    let total = 0;

    rows.forEach(row => {
        const quantityInput = row.querySelector("input[type='number']");
        const priceText = row.querySelector("td:nth-child(2)").textContent.replace("NT$", "");
        const subtotalCell = row.querySelector("td:nth-child(4)");

        const quantity = parseInt(quantityInput.value);
        const price = parseInt(priceText);
        const subtotal = quantity * price;

        subtotalCell.textContent = "NT$" + subtotal;
        total += subtotal;
    });

    document.getElementById("totalPrice").textContent = "NT$" + total;
}

// 刪除該列商品
function removeProduct(button) {
    const row = button.closest("tr");
    if (row) {
        row.remove();
        updateTotal();
    }
}

// 顯示付款表單
function showPaymentForm() {
    var method = document.querySelector('input[name="paymentMethod"]:checked').value;
    document.getElementById("paymentForm").style.display = 'block';
    document.getElementById("creditCardDetails").style.display = (method === "creditCard") ? 'block' : 'none';
}

// 結帳處理
function checkout() {
    var total = document.getElementById("totalPrice").textContent.replace("NT$", "");
    var name = document.getElementById("name").value.trim();
    var address = document.getElementById("address").value.trim();
    var email = document.getElementById("email").value.trim();

    if (!name || !address || !email) {
        alert("請填寫所有必填欄位！");
        return;
    }

    var paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
    if (!paymentMethod) {
        alert("請選擇付款方式！");
        return;
    }

    var paymentText = paymentMethod.value === "cash" ? "貨到付款" : "線上付款";

    var details = `您選擇的商品總計為 NT$${total}。\n付款方式: ${paymentText}\n姓名: ${name}\n地址: ${address}\n信箱: ${email}\n`;

    if (paymentMethod.value === "creditCard") {
        var cardNumber = document.getElementById("cardNumber").value.trim();
        var expiryDate = document.getElementById("expiryDate").value.trim();
        if (!cardNumber || !expiryDate) {
            alert("請填寫完整的信用卡資訊！");
            return;
        }
        details += `信用卡號: ${cardNumber}\n到期: ${expiryDate}\n`;
    }

    alert(details);

    // 成功訊息
    var msg = document.getElementById("successMessage");
    if (msg) {
        msg.style.display = 'block';
        msg.scrollIntoView({ behavior: "smooth" });
    }
}
