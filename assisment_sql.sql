#1. Create Database
CREATE DATABASE try;
USE try;

#2. Create Tables
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE,
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

#3. Insert Sample Records
INSERT INTO employees (name, position, salary, hire_date) VALUES
('John Doe', 'Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

#4. Create Trigger (for automatic audit entry)
DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, name, position, salary, hire_date)
    VALUES (NEW.employee_id, NEW.name, NEW.position, NEW.salary, NEW.hire_date);
END;
//

DELIMITER ;

#5. Create Stored Procedure (to insert employee & log automatically)
DELIMITER //

CREATE PROCEDURE add_employee (
    IN emp_name VARCHAR(100),
    IN emp_position VARCHAR(100),
    IN emp_salary DECIMAL(10,2),
    IN emp_hire_date DATE
)
BEGIN
    INSERT INTO employees (name, position, salary, hire_date)
    VALUES (emp_name, emp_position, emp_salary, emp_hire_date);
END;
//

DELIMITER ;

#6. Use the Procedure
CALL add_employee('Michael Brown', 'Data Analyst', 65000.00, '2024-07-10')