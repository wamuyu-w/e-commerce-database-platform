CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Table: brand
CREATE TABLE brand (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: product_category
CREATE TABLE product_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: product
CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    brand_id INT,
    base_price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

-- Table: product_item
CREATE TABLE product_item (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    sku VARCHAR(255) UNIQUE NOT NULL,
    stock INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Table: product_image
CREATE TABLE product_image (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    image_url VARCHAR(2083) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Table: color
CREATE TABLE color (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    hex_code VARCHAR(7) NOT NULL
);

-- Table: size_category
CREATE TABLE size_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Table: size_option
CREATE TABLE size_option (
    id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);

-- Table: product_variation
CREATE TABLE product_variation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

-- Table: attribute_category
CREATE TABLE attribute_category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL
);

-- Table: attribute_type
CREATE TABLE attribute_type (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    data_type ENUM('text', 'number', 'boolean') NOT NULL
);

-- Table: product_attribute
CREATE TABLE product_attribute (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    attribute_category_id INT NOT NULL,
    attribute_type_id INT NOT NULL,
    value TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);