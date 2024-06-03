CREATE DATABASE GeekStore;
USE GeekStore;

CREATE TABLE companies (
  company_id VARCHAR(100) PRIMARY KEY,
  company_name VARCHAR(50),
  phone VARCHAR(20),
  email VARCHAR(50),
  country VARCHAR(50),
  website VARCHAR(100)
);

CREATE TABLE credit_cards (
  id VARCHAR(20) PRIMARY KEY,
  user_id INT,
  iban VARCHAR(34) NOT NULL UNIQUE,
  pan VARCHAR(25) NOT NULL,
  pin INT(4) NOT NULL,
  cvv INT(3) NOT NULL,
  track1 VARCHAR(100) ,
  track2 VARCHAR(100),
  expiring_date VARCHAR(10) NOT NULL
);
CREATE TABLE products(
	id VARCHAR(30) PRIMARY KEY ,
	product_name VARCHAR(20),
	price VARCHAR(20),
	colour VARCHAR(7),
	weight FLOAT,
	warehouse_id VARCHAR(7)
);

CREATE TABLE users (
id INT PRIMARY KEY,
name VARCHAR(30),
surname VARCHAR(30),
phone VARCHAR(20), 
email VARCHAR(50),
birth_date VARCHAR(25) NOT NULL, 
country VARCHAR(50),
city VARCHAR(50),
postal_code VARCHAR (15),
address VARCHAR(50)
);


CREATE TABLE transactions (
  id VARCHAR(100) PRIMARY KEY,
  card_id VARCHAR(20),
  business_id VARCHAR(100),
  timestamp TIMESTAMP,
  amount DECIMAL(10, 2),
  declined TINYINT(1),
  product_ids VARCHAR(30),
  user_id INT,
  lat FLOAT,
  longitude FLOAT,
  FOREIGN KEY (card_id) REFERENCES credit_cards(id),
  FOREIGN KEY (business_id) REFERENCES companies(company_id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
-- Anteriormente no podía importar los datos de transactions correctamente dado que los datos de la columna
-- product_ids eran diferentes a los de la tabla product(id), por lo tanto no existe como clave foránea en esta tabla