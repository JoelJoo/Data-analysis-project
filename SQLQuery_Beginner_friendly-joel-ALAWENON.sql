--CREATE TABLE EmployeeDemographics
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--)

--CREATE TABLE EmployeeSalary
--(EmployeeID int,
--JobTitle varchar(50),
--Salary int
--)

--(1001, 'Joel', 'ALAWENON', 20, 'Male')

--INSERT INTO EmployeeDemographics VALUES
--(1002, 'shalom', 'DOSSEH', 20, 'Male'),
--(1003, 'Joel', 'ALAWENON', 20, 'Male'),
--(1004, 'Jeremie', 'ALAWENON', 23, 'Male'),
--(1005, 'David', 'ALAWENON', 25, 'Male'),
--(1006, 'esther', 'ALAWENON', 28, 'Female'),
--(1007, 'rebecca', 'ALAWENON', 14, 'female'),
--(1008, 'Priscille', 'ALAWENON', 11, 'Female'),
--(1009, 'Vital', 'ALAWENON', 9, 'Male'),
--(1010, 'Kafui', 'Hounkpatin', 24, 'Male'),
--(1011, 'Rockib', 'KELANI', 22, 'Male')

--DELETE FROM EmployeeDemographics WHERE LastName = 'ALAWENON' AND EmployeeID != 1001
--UPDATE EmployeeSalary SET JobTitle = 'Data analyst' where JobTitle = 'Data analysis'
--UPDATE EmployeeSalary SET JobTitle = 'Data analyst' where JobTitle = 'Data analysis'
--DELETE FROM EmployeeDemographics where LastName = 'DOSSEH'
--INSERT INTO EmployeeDemographics VALUES
--(1002, 'Shalom', 'DOSSEH', 19, 'Male')
--DELETE FROM EmployeeDemographics where FirstName = 'Joel' AND EmployeeID != 1001

--INSERT INTO EmployeeSalary VALUES
--(1002, 'Data analyst', 80000),
--(1004, 'Engineer', 200000),
--(1005, 'Engineer', 170000),
--(1006, 'Business woman', 500000),
--(1007, 'Sage femme', 200000),
--(1008, 'Avocate', 1000000),
--(1009, 'Doctor', 900000),
--(1010, 'Mobil developper', 240000),
--(1011, 'Real estate', 220000)

/*
select top, distinct, count,as, max, min, avg
*/


--SELECT FirstName, Age FROM EmployeeDemographics

--SELECT TOP 5  FirstName FROM EmployeeDemographics

--SELECT TOP 5 * FROM EmployeeDemographics

--SELECT DISTINCT(EmployeeID)  FROM EmployeeDemographics

--SELECT DISTINCT(Gender)  FROM EmployeeDemographics

--SELECT COUNT(LastName) FROM EmployeeDemographics

--SELECT COUNT(LastName) AS LastNameCount FROM EmployeeDemographics

--SELECT MAX(Salary) FROM EmployeeSalary
--SELECT MIN(Salary) FROM EmployeeSalary
--SELECT AVG(Salary) FROM EmployeeSalary
--SELECT * FROM SQLTutorial.dbo.EmployeeSalary

/*where statement 
(where,<>, >, >,  and, or, not null, null, in, like)
*/
--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where FirstName <> 'Joel'

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where Age < 15

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where Age <= 21

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where Age >= 21

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where Age <= 21 AND Gender = 'Male'

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where Age <= 15 OR Gender = 'Female'

--start with x
--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName LIKE 'A%'

--x is beetween
--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName LIKE '%K%'

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName LIKE 'K%NI%'

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName LIKE 'K%L%AN%'

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName IS NOT NULL

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where LastName IS NULL

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--where FirstName IN ('Joel', 'esther')

--SELECT Age FROM SQLTutorial.dbo.EmployeeDemographics
--where FirstName IN ('Joel', 'esther')

/*
Group by, order by
*/

--SELECT Gender, COUNT(Gender) AS Number_of_this_gender
--FROM EmployeeDemographics GROUP BY Gender

--SELECT Gender, Age, COUNT(Gender) AS Number_of_person_having_the_same_gender_and_age
--FROM EmployeeDemographics GROUP BY Gender, Age

--SELECT Gender, LastName, COUNT(LastName)
--FROM EmployeeDemographics GROUP BY Gender, LastName

--SELECT Gender, COUNT(Gender) AS Number_of_this_gender
--FROM EmployeeDemographics
--WHERE Age < 20
--GROUP BY Gender

--SELECT Gender, COUNT(Gender) AS Number_of_this_gender
--FROM EmployeeDemographics
--WHERE Age < 23
--GROUP BY Gender ORDER BY Number_of_this_gender DESC

--SELECT * FROM EmployeeDemographics ORDER BY Age DESC, Gender ASC
 
 /*
 join table
 */
 --ceci va joindre les table mais on aura double du primary key et foreign key
 --SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
 --Inner Join SQLTutorial.dbo.EmployeeSalary
 --ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

 --SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
 --Full Outer Join SQLTutorial.dbo.EmployeeSalary
	--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT * FROM SQLTutorial.dbo.EmployeeDemographics
--Left Outer Join SQLTutorial.dbo.EmployeeSalary
-- ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
--FROM SQLTutorial.dbo.EmployeeDemographics
--Inner Join SQLTutorial.dbo.EmployeeSalary
-- ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary
--FROM SQLTutorial.dbo.EmployeeDemographics
--Right Outer Join SQLTutorial.dbo.EmployeeSalary
-- ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- where FirstName <> 'Joel'
-- ORDER BY Salary DESC

--salaire moyen dun x job
--SELECT  JobTitle, AVG(Salary) AS Average_salary_of_data_analyst
--FROM SQLTutorial.dbo.EmployeeDemographics
--Inner Join SQLTutorial.dbo.EmployeeSalary
-- ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
-- where JobTitle = 'Data analyst'
-- GROUP BY JobTitle

/*
union
*/

--CREATE TABLE WareHouseEmployeeDemographics
--(EmployeeID int,
--FirstName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50)
--)

--INSERT INTO WareHouseEmployeeDemographics VALUES
--(1012, 'Lolo', 'UNKNOW', NULL, 'Male'),
--(1013, 'Blazo', 'INCONNUTO', 20, 'Male'),
--(1014, 'Pirate', 'NO LO SE', 23, 'Male'),
--(1015, 'Cloclo', 'ZOUPA', NULL, 'Male')


--SELECT *
--FROM SQLTutorial.dbo.EmployeeDemographics
--UNION ALL
--SELECT *
--FROM SQLTutorial.dbo.WareHouseEmployeeDemographics
--ORDER BY EmployeeID

--SELECT EmployeeID, FirstName, Age
--FROM SQLTutorial.dbo.EmployeeDemographics
--UNION 
--SELECT EmployeeID, JobTitle, Salary
--FROM SQLTutorial.dbo.EmployeeSalary
--ORDER BY EmployeeID

/*
case statement
*/

--SELECT FirstName, LastName, Age,
--CASE
--	WHEN Age > 23 THEN 'Old'
--	WHEN Age BETWEEN 20 AND 23 THEN 'Becoming old'
--	WHEN Age BETWEEN 18 AND 19 THEN 'Became Adult'
--	ELSE 'Teenager'
--END
--FROM SQLTutorial.dbo.EmployeeDemographics
--WHERE Age IS NOT NULL
--ORDER BY Age

--SELECT FirstName, LastName, JobTitle, Salary,
--CASE
--	WHEN JobTitle = 'Data analyst' THEN Salary + (Salary * .10)
--	WHEN JobTitle = 'Engineer' THEN  Salary + (Salary *.05)
--	WHEN JobTitle = 'Doctor' THEN Salary + (Salary * .03)
--	ELSE Salary + (Salary * .02)
--END AS SalaryAfterRAise
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--where Salary IS NOT NULL

/*
Having Clause
*/

--SELECT JobTitle, COUNT(JobTitle)
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING COUNT(JobTitle) > 1

--SELECT JobTitle, AVG(Salary)
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG(Salary) > 200000
--ORDER BY AVG(Salary)

/*
Updating
deleting data
*/

--UPDATE SQLTutorial.dbo.WareHouseEmployeeDemographics
--SET LastName = 'KNOWN UPDATED'
--WHERE LastName = 'UNKNOW'

--DELETE FROM SQLTutorial.dbo.WareHouseEmployeeDemographics
--WHERE LastName = 'KNOWN UPDATED'

/*
Aliasing
*/

--SELECT FirstName AS Prenom
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT FirstName Prenom
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT FirstName + ' ' + LastName AS FullName
--FROM SQLTutorial.dbo.EmployeeDemographics

--SELECT Demo.Age
--FROM SQLTutorial.dbo.EmployeeDemographics AS Demo

--SELECT Demo.Age, Demo.FirstName
--FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
--JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
--ON Demo.EmployeeID = Sal.EmployeeID

/*
Partition By 
*/

--SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
--FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
--JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
--ON Demo.EmployeeID = Sal.EmployeeID

--SELECT Gender, COUNT(Gender)
--FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
--JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
--ON Demo.EmployeeID = Sal.EmployeeID
--GROUP BY Gender

/*
--CTEs

WITH CTE_Employee as 
(SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM SQLTutorial.dbo.EmployeeDemographics AS Demo
JOIN SQLTutorial.dbo.EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > 200000
)

SELECT FirstName, AvgSalary 
FROM CTE_Employee

select *
FROM CTE_Employee
*/


/*
Temp  Tables
*/

--CREATE TABLE #temp_Employee
--(EmployeeID int,
--JobTile varchar(100),
--Salary int
--)


--Select *
--FROM #temp_Employee

--INSERT INTO #temp_Employee VALUES
--(1122, 'Doctor', 750000),
--(1123, 'Business woman', 800000),
--(1124, 'Sage femme', 550000),
--(1125, 'Avocate', 830000)

--Select *
--FROM #temp_Employee

--INSERT INTO #temp_Employee
--SELECT *
--FROM EmployeeSalary
 
 --DROP TABLE IF EXISTS #temp_Employee2

-- CREATE TABLE #temp_Employee2(
-- JobTitle varchar(50),
-- EmployeePerJob int,
-- AvgAge int,
-- avgSalary int)

-- INSERT INTO #temp_Employee2
-- SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
-- FROM SQLTutorial.dbo.EmployeeDemographics as Demo
-- JOIN SQLTutorial.dbo.EmployeeSalary as Sal
--	ON Demo.EmployeeID = Sal.EmployeeID
--GROUP BY JobTitle

--SELECT *
--FROM #temp_Employee2


/*
String Functions : TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower
*/

--DROP TABLE IF EXISTS EmployeeErrors

--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50),
--FirstName varchar(50),
--LastName varchar(50)
--)

--INSERT INTO EmployeeErrors VALUES
--('1100      ', 'Jimbo', 'Halbert'),
--('          1110', 'Blazo', 'Beasely'),
--('  1120  ', 'TOby', 'Flenderson - Fired')


--Select *
--From EmployeeErrors

--using Trim, LTRIM(left trim), RTRIM

--SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
--FROM EmployeeErrors

--SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIMLEFT
--FROM EmployeeErrors

--SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIMRIGHT
--FROM EmployeeErrors

--using Replace

--Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
--From EmployeeErrors

--using Substring

--Select SUBSTRING(FirstName, 1, 3)
--From EmployeeErrors
 
--Jim
--Jimo

--Select err.FirstName, SUBSTRING(err.FirstName, 1, 3), dem.FirstName, SUBSTRING(dem.FirstName, 1, 3)
--From EmployeeErrors err
--JOIN EmployeeDemographics dem
--	ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName, 1, 3)

--using UPPER and LOWER

--SELECT FirstName, LOWER(FirstName)
--FROM EmployeeErrors

--SELECT FirstName, UPPER(FirstName)
--FROM EmployeeErrors

/*
Stored Procedures
*/

--CREATE PROCEDURE TEST
--AS
--SELECT *
--FROM EmployeeDemographics 


--EXECUTE TEST

------CREATE PROCEDURE Temp_Employee
------AS 
------CREATE TABLE #temp_employee (
------JobTitle varchar(100),
------EmployeePerJob int,
------AvgAge int,
------AvgSalary int
------)

------INSERT INTO #temp_employee
------SELECT

/*
Subqueries (in the select, from, and where Statement)
*/

