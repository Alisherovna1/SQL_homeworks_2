-- Dars 2: DDL va DML buyruqlari

------------------------------
-- Boshlang‘ich darajadagi topshiriqlar
------------------------------

-- 1. Employees jadvalini yaratish
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. 3 ta yozuv qo‘shish (har xil usulda)
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'John Doe', 6000);
INSERT INTO Employees VALUES (2, 'Jane Smith', 5500);
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
    (3, 'Robert Brown', 5000);

-- 3. EmpID = 1 bo‘lgan xodimning ish haqini 7000 ga o‘zgartirish
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 4. EmpID = 2 bo‘lgan xodimni o‘chirish
DELETE FROM Employees
WHERE EmpID = 2;

-- 5. DELETE, TRUNCATE va DROP farqi
/*
DELETE: Shart asosida ma'lumotlarni o‘chiradi, ORQAGA QAYTARISH (ROLLBACK) mumkin.
TRUNCATE: Barcha ma'lumotlarni tezda o‘chiradi, identity ni qayta boshlaydi, WHERE ishlatib bo‘lmaydi.
DROP: Jadvalning ma’lumotlari va tuzilmasini butunlay o‘chiradi.
*/

-- 6. Name ustunini VARCHAR(100) ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 7. Department nomli ustun qo‘shish
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Salary ustunining turini FLOAT ga o‘zgartirish
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 9. Departments jadvalini yaratish
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Employees jadvalidagi barcha ma’lumotlarni o‘chirib, tuzilmani saqlab qolish
TRUNCATE TABLE Employees;


------------------------------
-- O‘rta darajadagi topshiriqlar
------------------------------

-- 1. INSERT INTO SELECT yordamida 5 ta yozuv qo‘shish
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'Finance' UNION ALL
SELECT 3, 'IT' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'Sales';

-- 2. Ish haqi > 5000 bo‘lgan xodimlarning Department ustunini 'Management' ga o‘zgartirish
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 3. Employees jadvalidagi barcha yozuvlarni o‘chirib, tuzilmani saqlash
TRUNCATE TABLE Employees;

-- 4. Employees jadvalidan Department ustunini o‘chirish
ALTER TABLE Employees
DROP COLUMN Department;

-- 5. Employees jadvalini StaffMembers nomiga o‘zgartirish
EXEC sp_rename 'Employees', 'StaffMembers';

-- 6. Departments jadvalini butunlay o‘chirish
DROP TABLE Departments;


------------------------------
-- Yuqori darajadagi topshiriqlar
------------------------------

-- 1. Products jadvalini yaratish
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(255)
);

-- 2. Price > 0 bo‘lishi uchun CHECK cheklov qo‘shish
ALTER TABLE Products
ADD CONSTRAINT chk_price CHECK (Price > 0);

-- 3. StockQuantity ustunini qo‘shish (DEFAULT = 50)
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 4. Category ustunini ProductCategory nomiga o‘zgartirish
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 5. Products jadvaliga 5 ta yozuv qo‘shish
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'Yuqori unumli laptop'),
(2, 'Chair', 'Furniture', 150.00, 'Ergonomik ofis stuli'),
(3, 'Book', 'Stationery', 20.00, 'O‘quv qo‘llanmasi'),
(4, 'Smartphone', 'Electronics', 800.00, 'Oxirgi model smartfon'),
(5, 'Headphones', 'Electronics', 100.00, 'Shovqinni bekor qiluvchi quloqchinlar');

-- 6. SELECT INTO yordamida Products_Backup jadvalini yaratish
SELECT * INTO Products_Backup
FROM Products;

-- 7. Products jadvalini Inventory nomiga o‘zgartirish
EXEC sp_rename 'Products', 'Inventory';

-- 8. Price ustunini FLOAT turiga o‘zgartirish
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 9. ProductCode nomli IDENTITY ustun qo‘shish (1000 dan boshlanadi, 5 qadam bilan oshadi)
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);
