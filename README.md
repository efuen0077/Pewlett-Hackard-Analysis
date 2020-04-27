# Pewlett-Hackard-Analysis

## Challenge
### Data
#### Table 1

[retiring_emp_by_title.csv.zip](https://github.com/efuen0077/Pewlett-Hackard-Analysis/files/4536852/retiring_emp_by_title.csv.zip)

#### Table 2

[eligibility_info.csv.zip](https://github.com/efuen0077/Pewlett-Hackard-Analysis/files/4536851/eligibility_info.csv.zip)

### Technical Analysis

There are 90,398 employees who are retiring and the number of individuals eligible for the mentorship role is 14,673. It is recommended that the company begins to look into their budget ASAP as they have a large number of individuals who are either retiring or eligible for retirement. Each individual's salary will play a huge role in determining how much each person will be receiving during retirement.

#### Table 1: Number of Retiring Employees by Title

Table 1 contains the number of current employees who are about to retire, grouped by job title. In order to do this, I generated a table that showed ONLY people who were born between 1952 and 1955 by using the WHERE function. I named this table "retirement_info." Then, in order retrieve a table with the correct columns (i.e. Employee number (emp_no), First name (first_name), last name (last_name), Title (title), from_date (from_date), Salary (salary)), I used two INNER JOIN statements and created a new table named retiring_emp_data. I, then, noticed that there were duplicates in the table that I generated, which is not what was needed. It is important that the data in each row is unique. Thus, I used the SELECT DISTINCT command to retrieve only distinct values in the table. Lastly, in order to to show only most recent title per employee, I needed to partition the data in retiring_emp_data by employee number and retrieved the following table:

[retiring_emp_by_title.csv.zip](https://github.com/efuen0077/Pewlett-Hackard-Analysis/files/4536852/retiring_emp_by_title.csv.zip)

#### Table 2: Mentorship Eligibility

Table 2 contains a list of employees (born in 1965) who are eligible for the retirement program. I generated a table that showed ONLY people who were born in 1965 by using a filter (I used the WHERE function). I named this table "eligibility_info." Then, in order retrieve a table with the correct columns (i.e. Employee number (emp_no), First name (first_name), last name (last_name), Title (title), from_date (from_date), Salary (salary)), I used two INNER JOIN statements and created a new table named "new_eligibility_info." I, then, noticed that there were duplicates in the table that I generated, which is not what was needed. It is important that the data in each row is unique. Thus, I used the SELECT DISTINCT command to retrieve only distinct values in table and placed that data into a new table called "final_eligibility_info." The final table is linked below.


[eligibility_info.csv.zip](https://github.com/efuen0077/Pewlett-Hackard-Analysis/files/4536851/eligibility_info.csv.zip)
