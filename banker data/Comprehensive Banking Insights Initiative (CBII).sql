

--1. List the details of all customers from italy  who have joined since 2015.
SELECT *
FROM [dbo].[Customer_Data]
WHERE nationality = 'italy' and  customer_since >= '2015-01-01';

--2. Find the total number of loans per country.
SELECT country, COUNT(*) AS total_loans
FROM [dbo].[Home_Loan_Data]
GROUP BY country;

--3. Retrieve the first name, last name, and phone number of all female bankers who joined before 2015.
SELECT first_name, last_name, phone
FROM [dbo].[Banker_Data]
WHERE gender = 'Female' AND date_joined < '2015-01-01';


-- 4. Identify customers with more than one loan record.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(l.loan_id) AS number_of_loans
FROM [dbo].[Customer_Data] c
JOIN [dbo].[Loan_Records_Data] l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(l.loan_id) > 1;

-- 5. List all loans where the loan term is greater than 5 years and the property type is 'Condominium'
SELECT loan_id, property_type, loan_term, city
FROM [dbo].[Home_Loan_Data]
WHERE loan_term > 5 AND property_type = 'Condominium';


--- 6. Find all bankers who have never been assigned to a loan.
SELECT b.banker_id, b.first_name, b.last_name
FROM [dbo].[Banker_Data] b
LEFT JOIN [dbo].[Loan_Records_Data] l ON b.banker_id = l.banker_id
WHERE l.banker_id IS NULL;

--7. Show the average property value and loan percent for each country in the home loan data.
SELECT country, AVG(property_value) AS average_property_value, AVG(loan_percent) AS average_loan_percent
FROM [dbo].[Home_Loan_Data]
GROUP BY country;

-- 8. Get a list of loans issued in 'San Francisco' with a property value over $2,000,000.
SELECT loan_id, property_type, property_value
FROM [dbo].[Home_Loan_Data]
WHERE city = 'San Francisco' AND property_value > 2000000;

-- 9.Find the total loan amount for each customer:

SELECT c.customer_id, c.first_name, c.last_name, SUM(h.property_value * h.loan_percent / 100) as total_loan_amount
FROM Customer_Data c
JOIN Loan_Records_Data l ON c.customer_id = l.customer_id
JOIN Home_Loan_Data h ON l.loan_id = h.loan_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 10. Find the number of customers each banker is serving:

SELECT b.banker_id, b.first_name, b.last_name, COUNT(DISTINCT l.customer_id) as number_of_customers
FROM Banker_Data b
JOIN Loan_Records_Data l ON b.banker_id = l.banker_id
GROUP BY b.banker_id, b.first_name, b.last_name;

-- 11. Find the most popular property type for loans:
SELECT top 1 h.property_type, COUNT(*) as number_of_loans
FROM Home_Loan_Data h
JOIN Loan_Records_Data l ON h.loan_id = l.loan_id
GROUP BY h.property_type
ORDER BY number_of_loans DESC


-- 12. Find the average loan term and loan percent for each property type:
SELECT h.property_type, AVG(h.loan_term) as average_loan_term, AVG(h.loan_percent) as average_loan_percent
FROM Home_Loan_Data h
GROUP BY h.property_type;







