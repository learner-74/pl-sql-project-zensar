-- Shopping List Manager with Categories

-- Step 1: Create Users Table
CREATE TABLE Users (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50),
    email VARCHAR2(100)
);

-- Step 2: Create Shopping_Lists Table
CREATE TABLE Shopping_Lists (
    list_id NUMBER PRIMARY KEY,
    list_name VARCHAR2(50),
    user_id NUMBER REFERENCES Users(user_id)
);

-- Step 3: Create Categories Table
CREATE TABLE Categories (
    category_id NUMBER PRIMARY KEY,
    category_name VARCHAR2(50) UNIQUE
);

-- Step 4: Create Items Table
CREATE TABLE Items (
    item_id NUMBER PRIMARY KEY,
    item_name VARCHAR2(100),
    list_id NUMBER REFERENCES Shopping_Lists(list_id),
    status VARCHAR2(20) CHECK (status IN ('Pending', 'Purchased')),
    category_id NUMBER REFERENCES Categories(category_id)
);

-- Step 5: Insert Sample Data into Users
INSERT INTO Users (user_id, username, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO Users (user_id, username, email) VALUES (2, 'Bob', 'bob@example.com');

-- Step 6: Insert Sample Data into Shopping_Lists
INSERT INTO Shopping_Lists (list_id, list_name, user_id) VALUES (1, 'Groceries', 1);
INSERT INTO Shopping_Lists (list_id, list_name, user_id) VALUES (2, 'Electronics', 2);

-- Step 7: Insert Sample Data into Categories
INSERT INTO Categories (category_id, category_name) VALUES (1, 'Grocery');
INSERT INTO Categories (category_id, category_name) VALUES (2, 'Clothes');
INSERT INTO Categories (category_id, category_name) VALUES (3, 'Stationery');
INSERT INTO Categories (category_id, category_name) VALUES (4, 'Household');
INSERT INTO Categories (category_id, category_name) VALUES (5, 'Electronic Items');

-- Step 8: Insert Sample Data into Items
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (1, 'Milk', 1, 'Pending', 1);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (2, 'Eggs', 1, 'Pending', 1);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (3, 'Bread', 1, 'Pending', 1);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (4, 'Cheese', 1, 'Pending', 1);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (5, 'Laptop', 2, 'Pending', 5);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (6, 'Mouse', 2, 'Pending', 5);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (7, 'Keyboard', 2, 'Pending', 5);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (8, 'Headphones', 2, 'Pending', 5);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (9, 'Butter', 1, 'Pending', 1);
INSERT INTO Items (item_id, item_name, list_id, status, category_id) VALUES (10, 'Juice', 1, 'Pending', 1);

-- Step 9: Procedure to Mark Items as Purchased
CREATE OR REPLACE PROCEDURE mark_item_purchased(p_item_id IN NUMBER) IS
BEGIN
    UPDATE Items
    SET status = 'Purchased'
    WHERE item_id = p_item_id;

    DBMS_OUTPUT.PUT_LINE('Item with ID ' || p_item_id || ' marked as purchased.');
END;
/

-- Step 10: Trigger to Notify When All Items in a List Are Purchased
CREATE OR REPLACE TRIGGER notify_all_items_purchased
AFTER UPDATE OF status ON Items
FOR EACH ROW
DECLARE
    total_items NUMBER;
    purchased_items NUMBER;
    list_owner_email VARCHAR2(100);
BEGIN
    -- Count total items in the shopping list
    SELECT COUNT(*) INTO total_items 
    FROM Items 
    WHERE list_id = :NEW.list_id;

    -- Count purchased items in the shopping list
    SELECT COUNT(*) INTO purchased_items 
    FROM Items 
    WHERE list_id = :NEW.list_id AND status = 'Purchased';

    -- If all items are purchased, notify the user
    IF total_items = purchased_items THEN
        SELECT email INTO list_owner_email
        FROM Users u
        JOIN Shopping_Lists sl ON u.user_id = sl.user_id
        WHERE sl.list_id = :NEW.list_id;

        DBMS_OUTPUT.PUT_LINE('Notification sent to ' || list_owner_email || ': All items in your shopping list are purchased.');
    END IF;
END;
/

-- Step 11: Queries for Testing

-- Retrieve all items in a specific category
SELECT i.item_name, c.category_name
FROM Items i
JOIN Categories c ON i.category_id = c.category_id
WHERE c.category_name = 'Grocery';

-- List all items with their categories
SELECT i.item_name, c.category_name
FROM Items i
JOIN Categories c ON i.category_id = c.category_id
ORDER BY c.category_name;

-- Test Procedure: Mark an item as purchased
BEGIN
    mark_item_purchased(1); -- Mark Milk as Purchased
    mark_item_purchased(2); -- Mark Eggs as Purchased
END;
/

-- Check Trigger: Mark remaining items in the list as Purchased
BEGIN
    mark_item_purchased(3); -- Mark Bread as Purchased
    mark_item_purchased(4); -- Mark Cheese as Purchased
    mark_item_purchased(9); -- Mark Butter as Purchased
    mark_item_purchased(10); -- Mark Juice as Purchased
END;
/
