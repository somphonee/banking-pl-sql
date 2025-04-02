
--Step 1: Connect to the Database
--
--Use SQL*Plus, SQL Developer, or other tools to connect to the Oracle database.

-- Step 2: Create the Customers Table (CUSTOMERS)
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    phone_number VARCHAR2(20),
    address VARCHAR2(200),
    registration_date DATE DEFAULT SYSDATE,
    status VARCHAR2(10) DEFAULT 'ACTIVE'
);

-- Step 3: Create the Account Types Table (ACCOUNT_TYPES)
CREATE TABLE account_types (
    type_id NUMBER PRIMARY KEY,
    type_name VARCHAR2(50) NOT NULL,
    description VARCHAR2(200),
    min_balance NUMBER(10,2) NOT NULL,
    interest_rate NUMBER(5,2)
);

-- Step 4: Create the Accounts Table (ACCOUNTS)
CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    type_id NUMBER NOT NULL,
    balance NUMBER(15,2) DEFAULT 0,
    open_date DATE DEFAULT SYSDATE,
    last_transaction_date DATE,
    status VARCHAR2(10) DEFAULT 'ACTIVE',
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_account_type FOREIGN KEY (type_id) REFERENCES account_types(type_id),
    CONSTRAINT chk_balance CHECK (balance >= 0)
);

-- Step 5: Create the Transactions Table (TRANSACTIONS)
CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    account_id NUMBER NOT NULL,
    transaction_type VARCHAR2(20) NOT NULL,
    amount NUMBER(15,2) NOT NULL,
    transaction_date DATE DEFAULT SYSDATE,
    description VARCHAR2(200),
    CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

-- Step 6: Create the Audit Log Table (AUDIT_LOG)
CREATE TABLE audit_log (
    log_id NUMBER PRIMARY KEY,
    table_name VARCHAR2(30) NOT NULL,
    operation_type VARCHAR2(10) NOT NULL,
    operation_time TIMESTAMP DEFAULT SYSTIMESTAMP,
    operator_id VARCHAR2(30) DEFAULT USER,
    record_id NUMBER,
    old_value VARCHAR2(4000),
    new_value VARCHAR2(4000)
);

-- Step 7: Create Sequences for Primary Keys

CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE account_type_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE account_seq START WITH 10001 INCREMENT BY 1;
CREATE SEQUENCE transaction_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE log_seq START WITH 1 INCREMENT BY 1;
