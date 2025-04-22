# E-Commerce Database Platform

## Overview
This project implements a relational database schema for an e-commerce platform. The schema is designed to handle products, their variations, attributes, and related metadata.

## Database Tables
1. **brand**: Stores brand-related data.
2. **product_category**: Classifies products into categories.
3. **product**: Stores general product details.
4. **product_item**: Represents purchasable items with specific variations.
5. **product_image**: Stores product image URLs or file references.
6. **color**: Manages available color options.
7. **size_category**: Groups sizes into categories.
8. **size_option**: Lists specific sizes.
9. **product_variation**: Links a product to its variations (e.g., size, color).
10. **attribute_category**: Groups attributes into categories.
11. **attribute_type**: Defines types of attributes (e.g., text, number, boolean).
12. **product_attribute**: Stores custom attributes for products.

## ERD
Refer to the ERD section in the documentation for a visual representation of the relationships between tables.

## How to Use
1. Import the `schema.sql` file into your database management system.
2. Populate the tables with data as needed.
3. Use SQL queries to interact with the data.

## Future Enhancements
- Add user and order management tables.
- Implement stored procedures for common operations.
- Optimize indexing for faster queries.

### E-Commerce Platform: Database Schema and Documentation

Below is the implementation of the requested e-commerce platform database schema, including the tables, an ERD (Entity-Relationship Diagram), and a README file.

---

### Database Schema

#### SQL Script for Tables
```sql
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
    name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: product
CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
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
    name VARCHAR(255) NOT NULL
);

-- Table: size_option
CREATE TABLE size_option (
    id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
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
    name VARCHAR(255) NOT NULL
);

-- Table: attribute_type
CREATE TABLE attribute_type (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
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
```

---

### Entity-Relationship Diagram (ERD)

Below is the ERD for the database schema:

```plaintext
brand (id) --------------------< product (brand_id)
product_category (id) --------< product (category_id)
product (id) ------------------< product_item (product_id)
product (id) ------------------< product_image (product_id)
product (id) ------------------< product_variation (product_id)
color (id) --------------------< product_variation (color_id)
size_option (id) --------------< product_variation (size_option_id)
size_category (id) ------------< size_option (size_category_id)
attribute_category (id) -------< product_attribute (attribute_category_id)
attribute_type (id) -----------< product_attribute (attribute_type_id)
product (id) ------------------< product_attribute (product_id)
```

---

### README File

```markdown
# E-Commerce Database Platform

## Overview
This project implements a relational database schema for an e-commerce platform. The schema is designed to handle products, their variations, attributes, and related metadata.

## Database Tables
1. **brand**: Stores brand-related data.
2. **product_category**: Classifies products into categories.
3. **product**: Stores general product details.
4. **product_item**: Represents purchasable items with specific variations.
5. **product_image**: Stores product image URLs or file references.
6. **color**: Manages available color options.
7. **size_category**: Groups sizes into categories.
8. **size_option**: Lists specific sizes.
9. **product_variation**: Links a product to its variations (e.g., size, color).
10. **attribute_category**: Groups attributes into categories.
11. **attribute_type**: Defines types of attributes (e.g., text, number, boolean).
12. **product_attribute**: Stores custom attributes for products.

## ERD
Refer to the ERD section in the documentation for a visual representation of the relationships between tables.

## How to Use
1. Import the `schema.sql` file into your database management system.
2. Populate the tables with data as needed.
3. Use SQL queries to interact with the data.

## Future Enhancements
- Add user and order management tables.
- Implement stored procedures for common operations.
- Optimize indexing for faster queries.

### Data Flow Plan
1. **Product Creation**: Admin creates a product, assigns a brand, category, and base price.
2. **Product Variations**: Variations (e.g., color, size) are linked to the product.
3. **Attributes**: Custom attributes (e.g., material, weight) are added to the product.
4. **Inventory Management**: Product items with specific variations are created with stock and price.
5. **Images**: Product images are uploaded and linked to the product.
6. **Frontend Display**: Products, variations, and attributes are queried and displayed to users.

