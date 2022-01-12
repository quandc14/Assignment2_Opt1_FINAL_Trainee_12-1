/* create database of assgiment 2 day 12/1 */
CREATE DATABASE Assignment2_Opt1_FINAL
/* create table */
go
use Assignment2_Opt1_FINAL
go 
CREATE TABLE Trainee
(
	TraineeID int identity(1,1) primary key not null,
	Full_Name NVARCHAR(50),
	Bird_Date date,
	Gender bit,
	ET_IQ  int,
	ET_Gmath int,
	ET_English int,
	Training_Class char(10),
	Evaluation_Notes NVARCHAR(300)
)
go
/*
	check ET_IQ, ET_Gmath, ET_English
*/ 
ALTER TABLE Trainee
ADD CONSTRAINT Check_ET_IQ CHECK (ET_IQ >= 0 AND ET_IQ <= 20)
go
ALTER TABLE Trainee
ADD CONSTRAINT Check_ET_Gmath CHECK (ET_Gmath >=0 and ET_Gmath <=20)
go
ALTER TABLE Trainee
ADD CONSTRAINT Check_ET_ENGLISH CHECK (ET_English >=0 and ET_ENGLISH <=50)
go
/* insert into value 
A) Create the tables (with the most appropriate/economic field/column constraints & types) 
and add at least 10 records into each created table 
*/

/* rename column Bird_day */
EXEC SP_RENAME 'Trainee.Bird_Date', 'Birth_Date', 'COLUMN'

INSERT INTO Trainee
VALUES ('QUANDC', '2018-03-14', 1, 19, 15, 46, 'TC1', 'Hard-working'),
('leo', '2018-03-14', 1, 10, 20, 30, 'TC2', 'Friendly'),
('ronaldo', '2015-03-13', 1, 19, 19, 49, 'TC1', 'Smart and Talented'),
('neymar', '2018-06-20', 1, 19, 19, 40, 'TC3', 'Smart and Talented'),
('thanh hien', '2014-02-13', 0, 19, 9, 40, 'TC2', 'Optimistic'),
('binh thanh', '2001-07-12', 1, 9, 8, 20, 'TC1', 'Naughty'),
('nguye tu', '2000-02-14', 0, 19, 7, 30, 'TC1', 'Hardest'),
('duc thinh', '1999-04-14', 1, 4, 3, 10, 'TC1', 'Stupid'),
('phuong thao', '1998-03-30', 0, 15, 16, 40, 'TC2', 'Serious and Understantding'),
('duc huy', '2003-03-14', 1,  16, 15, 40, 'TC3', 'medium')
go


/*
B) Change the table TRAINEE to add one more field named Fsoft_Account which is a not-null & unique field.
*/
ALTER TABLE Trainee ADD Fsoft_Account char(20) not null unique
go

/* C) Create a VIEW which includes all the ET-passed trainees. 
One trainee is considered as ET-passed when he/she has the entry test points satisfied below criteria 
ET_IQ + ET_Gmath >=20
ET_IQ>=8
ET_Gmath>=8
ET_English>=18
*/

CREATE VIEW ET_Passed_Trainees1 AS
	SELECT TraineeID, Full_Name, Birth_Date, Gender
	FROM Trainee
	WHERE ET_IQ + ET_Gmath >= 20 AND ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >= 18
GO

/*
D) Query all the trainees who is passed the entry test, group them into different birth months.
*/

SELECT T.TraineeID, T.Full_Name, T.Birth_Date FROM Trainee as T
WHERE ET_IQ + ET_Gmath >= 20 AND ET_IQ >= 8 AND ET_Gmath >= 8 AND ET_English >= 18
ORDER BY MONTH(T.Birth_Date)
go

/*
E) Query the trainee who has the longest name, showing his/her age along with his/her basic information (as defined in the table). 
*/
SELECT T.TraineeID, T.Full_Name, T.Birth_Date, YEAR(GETDATE()) - YEAR(T.Birth_Date) as AGE, T.Gender
FROM Trainee as T
WHERE LEN(T.Full_Name) = (SELECT MAX(LEN(T.Full_Name)) FROM Trainee AS T)

