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

ALTER TABLE products
MODIFY COLUMN id INT;


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

CREATE TABLE transactions_products (
  transaction_id VARCHAR(100),
  product_id VARCHAR(30),
  PRIMARY KEY (transaction_id, product_id)
);

ALTER TABLE transactions_products
MODIFY COLUMN  product_id INT;

INSERT INTO transactions_products (transaction_id, product_id)
SELECT
        t.id,
        SUBSTRING_INDEX(SUBSTRING_INDEX(t.product_ids, ',', n.n), ',', -1) as product_id
FROM (SELECT 1 as n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
    ) n
JOIN transactions t
        ON n.n <= 1 + (LENGTH(t.product_ids) - LENGTH(REPLACE(t.product_ids, ',', '')))
ORDER BY t.id, n.n;

DELETE FROM transactions_products
WHERE product_id NOT IN (SELECT id FROM products);

ALTER TABLE transactions_products
ADD CONSTRAINT fk_transaction_id
FOREIGN KEY (transaction_id) REFERENCES transactions(id);

ALTER TABLE transactions_products
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id) REFERENCES products(id);

CREATE TABLE transactions (
  id VARCHAR(100) PRIMARY KEY,
  card_id VARCHAR(20),
  business_id VARCHAR(100),
  timestamp TIMESTAMP,
  amount DECIMAL(10, 2),
  declined TINYINT(1),
  user_id INT,
  lat FLOAT,
  longitude FLOAT,
  FOREIGN KEY (card_id) REFERENCES credit_cards(id),
  FOREIGN KEY (business_id) REFERENCES companies(company_id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


-- Anteriormente no podía importar los datos de transactions correctamente dado que los datos de la columna
-- product_ids eran diferentes a los de la tabla product(id), por lo tanto no existe como clave foránea en esta tabla