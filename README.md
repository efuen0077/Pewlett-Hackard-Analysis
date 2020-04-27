# Pewlett-Hackard-Analysis

## Challenge
### Data
#### Table 1



#### Table 2



### Technical Analysis
Bobby’s manager would like to know how many roles will need to be filled as the “silver tsunami” begins to make an impact. They would also like to identify retirement-ready employees who qualify to mentor the next generation of Pewlett Hackard employees.

#### Table 1: Number of Retiring Employees by Title

Table 1 contains the number of current employees who are about to retire, grouped by job title. In order to do this, I generated a table that showed ONLY people who were born between 1952 and 1955 by using a filter. I named this table "retirement_info." Then, in order retrieve a table with the correct columns (i.e. Employee number (emp_no), First name (first_name), last name (last_name), Title (title), from_date (from_date), Salary (salary)), I used two INNER JOIN statements and created a new table named retiring_emp_data. I, then, noticed that there were duplicates in the table that I generated, which is not what was needed. It is important that the data in each row is unique. Thus, I used the SELECT DISTINCT command to retrieve only distinct values in the table. Lastly, in order to to show only most recent title per employee, I needed to partition the data in retiring_emp_data by employee number and retrieved the following table:


#### Table 2: Mentorship Eligibility

Table 2 will list those employees from Table 1 who are eligible for the mentorship program.
Now, let’s take a closer look at how to create these tables.
