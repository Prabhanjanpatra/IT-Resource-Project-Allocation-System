# IT Resource Allocation & Management System

### Project Overview
This SQL project simulates a backend database for an IT consulting firm (like Capgemini). It is designed to manage the relationships between **Employees**, **Clients**, and **Projects**. The system solves key business problems such as identifying "On-Bench" resources (unallocated employees) and calculating billable resources per client.

### Problem Statement
In large IT organizations, efficient resource management is critical. This project addresses the need to:
1. Track employee designations and departmental data.
2. Manage client portfolios and regional distribution.
3. Handle many-to-many relationships between employees and projects (Allocations).
4. Generate reports on resource utilization (Bench strength) and project leadership.

### Technical Skills Demonstrated
* **Schema Design:** Created normalized tables with Primary and Foreign Key constraints to ensure data integrity.
* **Joins:** Used `INNER JOIN` for data retrieval and `LEFT JOIN` for finding missing relationships (Bench identification).
* **Aggregations:** Used `COUNT()` and `GROUP BY` to generate summary reports for account managers.
* **Filtering:** Applied `WHERE` clauses to specific roles (e.g., extracting Project Managers).

### Key Features (SQL Queries)
1.  **Bench Analysis:** Automatically identifies employees not currently assigned to active projects.
2.  **Client Billing:** Aggregates the total number of consultants billable to each client.
3.  **Project Hierarchy:** Retrieves detailed project views including Client Region and assigned Project Managers.

### How to Run
1.  Download the `project_code.sql` file.
2.  Open in MySQL Workbench or any standard SQL compiler.
3.  Execute the script to build the schema and populate the sample data.
