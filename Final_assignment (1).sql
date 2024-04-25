CREATE DATABASE VanCorp_DB;

DROP DATABASE VanCorp_DB;


use VanCorp_DB;

-- Create Manufacturer table
CREATE TABLE Manufacturer (
    manufacturer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create MinivanModel table
CREATE TABLE MinivanModel (
    model_id INT PRIMARY KEY,
    manufacturer_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES Manufacturer(manufacturer_id)
);

-- Create Equipment table
CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create Minivan table
CREATE TABLE Minivan (
    minivan_id INT PRIMARY KEY,
    model_id INT NOT NULL,
    FOREIGN KEY (model_id) REFERENCES MinivanModel(model_id)
);

-- Create MinivanEquipment table (for many-to-many relationship)
CREATE TABLE MinivanEquipment (
    minivan_id INT NOT NULL,
    equipment_id INT NOT NULL,
    FOREIGN KEY (minivan_id) REFERENCES Minivan(minivan_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id),
    PRIMARY KEY (minivan_id, equipment_id)
);

-- Create Package table
CREATE TABLE Package (
    package_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create PackageEquipment table (for many-to-many relationship)
CREATE TABLE PackageEquipment (
    package_id INT NOT NULL,
    equipment_id INT NOT NULL,
    FOREIGN KEY (package_id) REFERENCES Package(package_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id),
    PRIMARY KEY (package_id, equipment_id)
);

-- Insert dummy data for Manufacturer table
INSERT INTO Manufacturer (manufacturer_id, name) VALUES 
(1, 'Acme'), 
(2, 'XYZ Motors');

-- Insert dummy data for MinivanModel table
INSERT INTO MinivanModel (model_id, manufacturer_id, name) VALUES 
(1, 1, 'SE'), 
(2, 1, 'LE'), 
(3, 1, 'GT'), 
(4, 2, 'Model A'), 
(5, 2, 'Model B');

-- Insert dummy data for Equipment table
INSERT INTO Equipment (equipment_id, name) VALUES 
(1, 'Wheels'), 
(2, 'Seats'), 
(3, 'Engine'), 
(4, 'Radio'), 
(5, 'Air Conditioning'), 
(6, 'Automatic Transmission'), 
(7, 'Airbag');

-- Insert dummy data for Minivan table
INSERT INTO Minivan (minivan_id, model_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5);

-- Insert dummy data for MinivanEquipment table
INSERT INTO MinivanEquipment (minivan_id, equipment_id) VALUES 
(1, 1), (1, 2), (1, 3), 
(2, 1), (2, 2), (2, 3), 
(3, 1), (3, 2), (3, 3), 
(4, 1), (4, 2), (4, 3), 
(5, 1), (5, 2), (5, 3);

-- Insert dummy data for Package table
INSERT INTO Package (package_id, name) VALUES 
(1, 'Luxury Package'), 
(2, 'Sport Package');

-- Insert dummy data for PackageEquipment table
INSERT INTO PackageEquipment (package_id, equipment_id) VALUES 
(1, 4), (1, 5), (1, 6), (1, 7), 
(2, 4), (2, 6), (2, 7);

-- Create a fact table
CREATE TABLE FactTable (
    fact_id INT PRIMARY KEY,
    minivan_id INT NOT NULL,
    package_id INT NOT NULL,
    equipment_id INT NOT NULL,
    FOREIGN KEY (minivan_id) REFERENCES Minivan(minivan_id),
    FOREIGN KEY (package_id) REFERENCES Package(package_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);


-- Insert dummy data into FactTable
INSERT INTO FactTable (fact_id, minivan_id, package_id, equipment_id) VALUES
(1, 1, 1, 4),  -- Minivan 1 with Luxury Package and Radio
(2, 1, 1, 5),  -- Minivan 1 with Luxury Package and Air Conditioning
(3, 1, 1, 6),  -- Minivan 1 with Luxury Package and Automatic Transmission
(4, 1, 1, 7),  -- Minivan 1 with Luxury Package and Airbag
(5, 2, 2, 4),  -- Minivan 2 with Sport Package and Radio
(6, 2, 2, 6),  -- Minivan 2 with Sport Package and Automatic Transmission
(7, 2, 2, 7),  -- Minivan 2 with Sport Package and Airbag
(8, 3, 1, 4),  -- Minivan 3 with Luxury Package and Radio
(9, 3, 1, 5),  -- Minivan 3 with Luxury Package and Air Conditioning
(10, 3, 1, 6), -- Minivan 3 with Luxury Package and Automatic Transmission
(11, 3, 1, 7), -- Minivan 3 with Luxury Package and Airbag
(12, 4, 2, 4), -- Minivan 4 with Sport Package and Radio
(13, 4, 2, 6), -- Minivan 4 with Sport Package and Automatic Transmission
(14, 4, 2, 7), -- Minivan 4 with Sport Package and Airbag
(15, 5, 1, 4), -- Minivan 5 with Luxury Package and Radio
(16, 5, 1, 5), -- Minivan 5 with Luxury Package and Air Conditioning
(17, 5, 1, 6), -- Minivan 5 with Luxury Package and Automatic Transmission
(18, 5, 1, 7); -- Minivan 5 with Luxury Package and Airbag

-- altering MinivanModel Table
alter table MinivanModel add Model_price int;
select * from MinivanModel;
update MinivanModel set Model_price = '14000' where model_id  = 1;
update MinivanModel set Model_price = '25000' where model_id= 2;
update MinivanModel set Model_price = '16500' where model_id= 3;
update MinivanModel set Model_price = '18000' where model_id = 4;
update MinivanModel set Model_price = '15500' where model_id = 5;

-- altering package table
alter table package add package_price int;
select * from package;
update package set package_price = 1900 where package_id = 1;
update package set package_price = 1890 where package_id = 2;

-- alter equipment table
alter table equipment add equipment_price int;
select * from equipment;
update equipment set equipment_price = 900 where equipment_id =1;
update equipment set equipment_price = 290 where equipment_id =2;
update equipment set equipment_price = 5980 where equipment_id =3;
update equipment set equipment_price = 7900 where equipment_id =4;
update equipment set equipment_price = 2000 where equipment_id =5;
update equipment set equipment_price = 41000 where equipment_id =6;
update equipment set equipment_price = 9300 where equipment_id =7;

-- creating a table Minivan_sales
CREATE TABLE Minivan_sales(
    sales_date DATETIME DEFAULT NOW(),
    trans_id INT AUTO_INCREMENT PRIMARY KEY,
    model_id INT NOT NULL,
    package_id INT NOT NULL,
    quantity INT DEFAULT 1,
    total_price DECIMAL(10, 2), -- Assuming total price can have decimal values
    FOREIGN KEY (package_id) REFERENCES Package(package_id),
    FOREIGN KEY (model_id) REFERENCES MinivanModel(model_id)
);

select * from Minivan_sales;

select * from MinivanModel;

-- inserting into Minivan_sales 
insert into Minivan_sales (model_id,package_id,quantity)values
	(1,1,5),
	(4,2,2),
	(5,2,5);

select * from Minivan_sales;

-- creating table sales_transaction
create table sales_transaction(
	trans_id int,
	total_price int,
	-- total int,
	FOREIGN KEY (trans_id) REFERENCES Minivan_sales(trans_id)
);

-- alter table sales_transaction drop column total_price;

select * from sales_transaction;

DELIMITER ;
-- creating a procedure to calculate total
CREATE PROCEDURE calculate_total(IN t_id INT, OUT total INT)
begin
	-- Calculate total price
   select (mm.Model_price + p.package_price) * ms.quantity into total  from minivan_sales as ms inner join minivanmodel as mm on(ms.model_id = mm.model_id)
   inner join package as p on(ms.package_id = p.package_id)
   where ms.trans_id = t_id;
END

-- Inserting values
CALL calculate_total(1, @total1);
INSERT INTO sales_transaction (trans_id, total_price) VALUES (1, @total1);

CALL calculate_total(2, @total1);
INSERT INTO sales_transaction (trans_id, total_price) VALUES (2, @total1);

