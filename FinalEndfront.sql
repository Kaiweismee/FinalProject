-- 刪除並建立新的資料庫 FinalEndFront
DROP DATABASE IF EXISTS FinalEndFront;
CREATE DATABASE FinalEndFront CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE FinalEndFront;
-- 建立 products 表格

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    team VARCHAR(50)
);

-- 插入一筆商品資料
INSERT INTO products (name, description, price, stock, image_url, team)
VALUES 
('中信兄弟球衣','經典黃色球衣，印有隊名與隊徽',1500.00,100,'../assets/images/products/brothers/brothers_image1.jpg','中信兄弟'),
('中信兄弟球帽','中信兄弟經典的黃色作為配色，並且加上代表隊名Brother的縮寫B，簡單又不失流行的設計',500.00,50,'../assets/images/products/brothers/brothers_image2.jpg','中信兄弟'),
('味全龍球衣','味全龍的紅白配色帶點線條，胸前有著Dragons，支持味全龍隊的球迷不要錯過',1500.00,50,'../assets/images/products/dragon/dragon_image1.jpg','味全龍'),
('味全龍球帽','味全龍的鮮豔紅色，帽前有著味全的元老名字W，說明龍魂不滅的精神',500.00,50,'../assets/images/products/dragon/dragon_image2.jpg','味全龍'),
('富邦悍將球衣','富邦悍將的經典深藍配色，胸前搭配著隊名以及小小的隊徽作為點綴，支持富邦悍將的球迷不要錯過',1500.00,50,'../assets/images/products/fubon/fubon_image1.jpg','富邦悍將'),
('富邦悍將加油毛巾','棒球場上辛苦的不只有球員，在場邊賣力加油揮灑汗水的啦啦隊員也是值得敬佩，富邦悍將人氣啦啦隊員的毛巾不要錯過',500.00,50,'../assets/images/products/fubon/fuben_image2.jpg','富邦悍將'),
('統一獅球衣','統一獅的經典橘黑配色，胸前有明顯的隊名，側邊袖子上有代表性的隊徽，支持統一獅的球迷不要錯過',1500.00,50,'../assets/images/products/lion/lion_image1.jpg','統一獅'),
('統一獅球帽','統一獅的經典橘黑作為配色，加上象徵隊徽的獅子，展現統一獅球迷的霸氣',500.00,50,'../assets/images/products/lion/lion_image2.jpg','統一獅'),
('樂天桃猿球衣','樂天桃猿的經典酒紅與白的配色，胸前有明顯的隊名，側邊袖子上有代表性的隊徽，支持樂天桃猿的球迷不要錯過',1500.00,50,'../assets/images/products/rakuten/rakuten_image1.jpg','樂天桃猿'),
('樂天桃猿球帽','樂天桃猿的經典酒紅與白的作為配色，加上代表隊名Rakuten的縮寫R，低調又不失流行的設計',500.00,50,'../assets/images/products/rakuten/rakuten_image2.jpg','樂天桃猿'),
('台鋼雄鷹球衣','台鋼雄鷹綠褐白的搭配，左袖子上有著老鷹的徽章，台鋼為一支新球隊，還請多多支持',1500.00,50,'../assets/images/products/wings/wings_image1.jpg','台鋼雄鷹'),
('台鋼雄鷹球帽','簡單的黑色搭配著大T，展現持續翱翔',500.00,50,'../assets/images/products/wings/wings_image2.jpg','台鋼雄鷹');
CREATE VIEW product_view AS
SELECT 
    product_id AS 商品編號,
    name AS 商品名稱,
    description AS 商品描述,
    price AS 價格,
    stock AS 庫存數量,
    image_url AS 圖片連結,
    team AS 所屬球隊
FROM products;

CREATE TABLE cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(20),
    size VARCHAR(10),
    quantity INT
);
ALTER TABLE cart
ADD COLUMN product_name VARCHAR(100) AFTER product_id,
ADD COLUMN product_image VARCHAR(255) AFTER product_name,
ADD COLUMN total_price DECIMAL(10,2) AFTER quantity;
CREATE VIEW cart_view AS
SELECT 
    c.id AS 購物車編號,
    c.product_id AS 商品編號,
    p.name AS 商品名稱,
    p.price AS 單價,
    c.size AS 尺寸,
    c.quantity AS 數量,
    (p.price * c.quantity) AS 小計
FROM cart c
JOIN products p ON c.product_id = p.product_id;

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    card_number VARCHAR(50),
    expiry_date VARCHAR(10),
    order_date DATETIME NOT NULL
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    size VARCHAR(50),
    quantity INT NOT NULL,
    price DOUBLE NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);


SELECT * FROM cart_view;
