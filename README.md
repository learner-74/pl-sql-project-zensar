# pl-sql-shopping making list-zensar
# pl-sql-shopping making list-zensar




Shopping List Manager System - PLSQL

Project Created By:
Aniket Sandip Babar student of  from Amrutwahini College of Engineering from Computer Engineering Department (under Zensar SQL and Python Training)

Project Description:
This project is a Shopping List Manager System designed to efficiently manage shopping lists, categorize items, and streamline the purchasing process. The system consists of five interconnected tables: Users, Shopping_Lists, Categories, Items, and Status. It allows users to create and manage personalized shopping lists, add items to specific categories such as groceries, electronics, or stationery, and mark items as purchased. The system also features automated notifications via triggers, ensuring users are informed when all items in a list are purchased. This solution provides a comprehensive framework for organizing and tracking shopping activities efficiently.

Key Features:

1.Categorized Shopping Management:
Organizes shopping items into predefined categories like groceries, clothes, stationery, household items, and electronic gadgets for better management.

2.Mark as Purchased Feature:
Implements PL/SQL procedures to dynamically update item statuses, ensuring real-time tracking of purchased items.

3.Automated Notifications:
Utilizes triggers to notify users when all items in a specific shopping list are purchased, enhancing user experience.

4.Data Integrity and Cascading Updates:
Ensures referential integrity with foreign key constraints and cascading updates, maintaining consistency across related tables.

Objective:
The primary objective of this project is to create a centralized system for managing shopping lists, categorizing items, and ensuring seamless tracking of item statuses. It aims to enhance the efficiency of shopping-related tasks and provide users with accurate notifications for their shopping activities.

Technologies Used:
PL/SQL (Oracle Database), SQL (for queries, stored procedures, and triggers)

Output:

Users Table

user_id

username

email

1

Alice

alice@example.com

2

Bob

bob@example.com

Shopping_Lists Table

list_id

list_name

user_id

1

Groceries

1

2

Electronics

2

Categories Table

category_id

category_name

1

Grocery

2

Clothes

3

Stationery

4

Household

5

Electronic Items

Items Table

item_id

item_name

list_id

status

category_id

1

Milk

1

Pending

1

2

Eggs

1

Purchased

1

3

Laptop

2

Pending

5

4

Headphones

2

Purchased

5

Example Procedures and Triggers:

Procedure: Mark items as purchased
