CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name        VARCHAR(100),
    city        VARCHAR(100)
);

CREATE TABLE Products (
    product_id  INT PRIMARY KEY,
    name        VARCHAR(100),
    category    VARCHAR(100),
    price       DECIMAL(10, 2)
);

CREATE TABLE Orders (
    order_id    INT PRIMARY KEY,
    customer_id INT,
    order_date  DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    item_id    INT PRIMARY KEY,
    order_id   INT,
    product_id INT,
    quantity   INT,
    FOREIGN KEY (order_id)   REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1, 'Ali',  'Cairo'),
(2, 'Sara', 'Giza'),
(3, 'Omar', 'Alex');

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 15000),
(2, 'Phone',  'Electronics',  8000),
(3, 'Shoes',  'Fashion',      1200),
(4, 'Bag',    'Fashion',       700);

INSERT INTO Orders VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-02-15'),
(3, 3, '2024-03-01');

INSERT INTO Order_Items VALUES
(1, 1, 1, 1),  
(2, 1, 4, 2),  
(3, 2, 2, 1),   
(4, 3, 3, 3),   
(5, 3, 4, 1);   


SELECT * FROM Customers;

SELECT * FROM Products;

SELECT o.order_id, c.name AS customer_name, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

SELECT oi.item_id, o.order_id, p.name AS product_name, oi.quantity
FROM Order_Items oi
JOIN Orders o   ON oi.order_id   = o.order_id
JOIN Products p ON oi.product_id = p.product_id;

SELECT c.name AS customer_name, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o       ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id    = oi.order_id
JOIN Products p     ON oi.product_id = p.product_id
GROUP BY c.name;

SELECT DISTINCT city FROM Customers;

SELECT p.name
FROM Products p
LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

UPDATE Products
SET price = 8500
WHERE name = 'Phone';