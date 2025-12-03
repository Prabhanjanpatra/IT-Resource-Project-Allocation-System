-- 1. DATABASE CREATION
CREATE DATABASE Capgemini_Project_DB;
USE Capgemini_Project_DB;

-- 2. TABLE CREATION

-- Table to store Client details
CREATE TABLE Clients (
    Client_ID INT PRIMARY KEY,
    Client_Name VARCHAR(100),
    Region VARCHAR(50)
);

-- Table to store Employee details
CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(100),
    Designation VARCHAR(50),
    Department VARCHAR(50),
    Joining_Date DATE,
    Hourly_Rate DECIMAL(10, 2)
);

-- Table to store Project details
CREATE TABLE Projects (
    Project_ID INT PRIMARY KEY,
    Project_Name VARCHAR(100),
    Client_ID INT,
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20) CHECK (Status IN ('Active', 'Completed', 'Pipeline')),
    FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID)
);

-- Table to map Employees to Projects (Many-to-Many Relationship)
CREATE TABLE Allocations (
    Allocation_ID INT PRIMARY KEY,
    Emp_ID INT,
    Project_ID INT,
    Role_In_Project VARCHAR(50),
    Allocation_Date DATE,
    FOREIGN KEY (Emp_ID) REFERENCES Employees(Emp_ID),
    FOREIGN KEY (Project_ID) REFERENCES Projects(Project_ID)
);

-- 3. INSERTING SAMPLE DATA

INSERT INTO Clients VALUES 
(101, 'Globex Corp', 'North America'),
(102, 'TechFlow Inc', 'Europe'),
(103, 'MediCare Systems', 'Asia-Pacific');

INSERT INTO Employees VALUES 
(1, 'Rahul Sharma', 'Senior Developer', 'IT', '2020-01-15', 50.00),
(2, 'Priya Verma', 'Data Analyst', 'Data', '2021-06-20', 45.00),
(3, 'Amit Singh', 'Project Manager', 'Management', '2018-11-01', 80.00),
(4, 'Sneha Gupta', 'Java Developer', 'IT', '2023-02-10', 40.00),
(5, 'Vikram Rao', 'Testing Engineer', 'QA', '2022-09-05', 35.00);

INSERT INTO Projects VALUES 
(501, 'Cloud Migration', 101, '2024-01-01', '2024-12-31', 'Active'),
(502, 'AI Chatbot', 102, '2024-03-01', '2024-09-30', 'Active'),
(503, 'E-Health Portal', 103, '2023-05-01', '2023-12-31', 'Completed');

INSERT INTO Allocations VALUES 
(1001, 1, 501, 'Backend Lead', '2024-01-05'),
(1002, 3, 501, 'Project Manager', '2024-01-01'),
(1003, 2, 502, 'Data Scientist', '2024-03-05'),
(1004, 5, 503, 'QA Lead', '2023-05-10');
-- Note: Employee 4 (Sneha) is intentionally left unassigned to simulate "Bench" status.

-- 4. KEY BUSINESS QUERIES (The "Logic" part)

-- Query A: Find all employees currently "On Bench" (Not assigned to any project)
-- Relevance: Critical for HR to optimize resource utilization.
SELECT e.Emp_Name, e.Designation 
FROM Employees e
LEFT JOIN Allocations a ON e.Emp_ID = a.Emp_ID
WHERE a.Project_ID IS NULL;

-- Query B: Calculate total billable employees per Client
-- Relevance: Helps Account Managers track client engagement size.
SELECT c.Client_Name, COUNT(a.Emp_ID) AS Total_Resources
FROM Clients c
JOIN Projects p ON c.Client_ID = p.Client_ID
JOIN Allocations a ON p.Project_ID = a.Project_ID
GROUP BY c.Client_Name;

-- Query C: List Project details with Manager Name and Client Region
-- Relevance: Demonstrates complex joining capability.
SELECT p.Project_Name, c.Client_Name, c.Region, e.Emp_Name AS Project_Manager
FROM Projects p
JOIN Clients c ON p.Client_ID = c.Client_ID
JOIN Allocations a ON p.Project_ID = a.Project_ID
JOIN Employees e ON a.Emp_ID = e.Emp_ID
WHERE a.Role_In_Project = 'Project Manager';
