DROP TABLE IF EXISTS Racers;
DROP TABLE IF EXISTS Races;
DROP TABLE IF EXISTS Belongs_to;
DROP TABLE IF EXISTS Sponsored;
DROP TABLE IF EXISTS Drivers;
DROP TABLE IF EXISTS Sponsor;
DROP TABLE IF EXISTS Cars;
DROP TABLE IF EXISTS Spec_Parameters;

-- Class Parameters --
CREATE TABLE IF NOT EXISTS Spec_Parameters (
  Spec	 			integer			not null,
  Min_Weight_lbs	integer			not null,
  Max_Cubic_inch	integer      	not null,
  Max_Torque		integer			not null,
  Max_HorsePower	integer			not null,
  primary key(Spec)
);

-- Cars --
CREATE TABLE IF NOT EXISTS Cars (
  CarID    	char(4) 		not null,
  Spec	 	integer			not null,
  Year		Integer			not null,
  Brand 	VARCHAR (25)	not null,
  Model 	VARCHAR (25)	not null,
  foreign key (Spec) references Spec_Parameters(Spec),  
  primary key(CarID)
);

-- Sponsors --
CREATE TABLE IF NOT EXISTS Sponsors (
  SponsorID	char(4)			not null,
  Sponsor_Name VARCHAR (25)	not null,
  primary key(SponsorID)
);

-- Drivers --
CREATE TABLE IF NOT EXISTS Drivers (
  DriverID 	char(4) 		not null,
  CarID    	char(4) 		not null,
  SponsorID char(4)			not null,
  First_Name VARCHAR (25)	not null,
  Last_Name VARCHAR (25)	not null,
  Age 		Integer			not null,
  Foreign key(CarID) references Cars(CarID),
  Foreign key(SponsorID) references Sponsors(SponsorID),
  primary key(DriverID)
);

-- Sponsored --
CREATE TABLE IF NOT EXISTS Sponsored (
  SponsorID	char(4)			not null,
  DriverID  char(4)			not null,
  Foreign key(SponsorID) references Sponsors(SponsorID),
  Foreign key(DriverID) references Drivers(DriverID),
  primary key(SponsorID, DriverID)
);

-- Belongs to --
CREATE TABLE IF NOT EXISTS Belongs_to (
  CarID    	char(4) 		not null,
  DriverID  char(4) 		not null,
  Foreign key(CarID) references Cars(CarID),  
  Foreign key(DriverID) references Drivers(DriverID),
  primary key(CarID, DriverID)
);

-- Races --
CREATE TABLE IF NOT EXISTS Races (
  RaceID 		char(4) 		not null,
  Race_Name		VARCHAR (25)	not null,
  Difficulty	VARCHAR (25)	not null,
  Crowd_Size	integer			not null,
  Date			VARCHAR	(25)	not null,
  Weather		VARCHAR	(25)	not null,  
  primary key(RaceID)
);

-- Racers --
CREATE TABLE IF NOT EXISTS Racers (
  RaceID 			char(4) 		not null,
  DriverID 			char(4) 		not null,
  CarID 			char(4) 		not null,
  Place				VARCHAR (25)	not null,
  Laps_completed	integer			not null,
  Prize_in_USD		integer			not null,
  Foreign key(RaceID) references Races(RaceID),
  Foreign key(DriverID) references Drivers(DriverID),
  Foreign key(CarID) references Cars(CarID),
  primary key(RaceID,DriverID,CarID)
);

-- Spec_Parameters Insert --
INSERT INTO Spec_Parameters ( Spec, Min_Weight_lbs, Max_Cubic_inch, Max_Torque, Max_HorsePower)
VALUES(1, 3200, 440, 400, 385),
      (2, 2800, 600, 580, 550),
      (3, 2600, 675, 760, 725),
      (4, 2450, 800, 900, 875);

-- Cars Insert --
INSERT INTO Cars ( CarID, Spec, Year, Brand, Model)
VALUES('c01', 1, 2005, 'Pontiac', 'Grand am GT'),
      ('c02', 3, 2013, 'Audi', 'RS5'),
      ('c03', 3, 2010, 'Nissan', 'GTR'),
      ('c04', 2, 2005, 'BMW', 'M3'),
      ('c05', 1, 2004, 'Subaru', 'STI'),
      ('c06', 2, 2001, 'Honda', 'S2000'),
      ('c07', 4, 2017, 'Porsche', 'GT3-RS');

-- Sponsors Insert --
INSERT INTO Sponsors ( SponsorID, Sponsor_Name)
VALUES('s01', 'Patron'),
      ('s02', 'Citgo'),
      ('s03', 'Quest Software'),
      ('s04', 'True Value'),
      ('s05', 'Green Global'),
      ('s06', 'FLying Lizard'),
      ('s07', 'Pepsi'),
      ('s08', 'Tropicana');

-- Drivers Insert --
INSERT INTO Drivers ( DriverID, CarID, SponsorID, First_Name, Last_Name, Age)
VALUES('d01', 'c01', 's01', 'Mark', 'Lozinski', 19),
      ('d02', 'c02', 's02', 'AJ', 'Lorenzetti', 19),
      ('d03', 'c03', 's03', 'Kyle', 'Maclean', 20),
      ('d04', 'c04', 's04', 'Jon', 'Hylan', 20),
      ('d05', 'c05', 's05', 'Joey', 'Wilkinson', 21),
      ('d06', 'c06', 's06', 'Teddy', 'Morgues', 19),
      ('d07', 'c07', 's07', 'Alan', 'Labouseur', 50);

-- Sponsored Insert --
INSERT INTO Sponsored ( SponsorID, DriverID)
VALUES('s01', 'd01'),
      ('s02', 'd02'),
      ('s03', 'd03'),
      ('s04', 'd04'),
      ('s01', 'd05'),
      ('s05', 'd06'),
      ('s03', 'd07'),
      ('s08', 'd05'),
      ('s06', 'd04'),
      ('s07', 'd01');

-- Belongs_to Insert --
INSERT INTO Belongs_to ( DriverID, CarID)
VALUES('d01', 'c01'),
      ('d02', 'c02'),
      ('d03', 'c03'),
      ('d04', 'c04'),
      ('d05', 'c05'),
      ('d06', 'c06'),
      ('d07', 'c07');

-- Races Insert --
INSERT INTO Races ( RaceID, Race_Name, Difficulty, Crowd_Size, Date, Weather)
VALUES('r01', 'EMRA PM', 'Med', 31000, '05/08/17', 'Sunny'),
      ('r02', 'PCA CVR', 'Med', 23000, '05/29/17', 'Sunny'),
      ('r03', 'BMW CT Valley - Autocross', 'Low', 19000, '06/12/17', 'Overcast'),
      ('r04', 'Lime Rock Drivers Club', 'High', 29000, '06/30/17', 'Overcast'); 

-- Racers Insert --
INSERT INTO Racers (RaceID, DriverID, CarID, Place, Laps_completed, Prize_in_USD)
VALUES('r01', 'd01', 'c01', 'First', 144, 9000),
      ('r02', 'd02', 'c02', 'Third', 164, 7000),
      ('r02', 'd03', 'c03', 'Second', 167, 1100),
      ('r03', 'd04', 'c04', 'First', 157, 10000),
      ('r01', 'd05', 'c05', 'Forth', 131, 1000),
      ('r03', 'd06', 'c06', 'Third', 149, 6000),
      ('r04', 'd07', 'c07', 'First', 177, 25000);

select *
from Drivers;

select *
from Spec_Parameters;

select *
from Cars;

select *
from Sponsors;

select * 
from Sponsored;

select * 
from Belongs_to;

select *
from  Races;

select *
from  Racers;



/*CREATE OR REPLACE VIEW Belongs_to_Filled AS
 SELECT 
 	d.first_name,
 	d.last_name,
 	c.spec,
 	c.year,
 	c.brand,
 	c.model
 FROM 	Drivers d,
 		Cars c
 WHERE d.CarID = c.CarID
 ORDER BY d.last_name DESC;
 
 CREATE OR REPLACE VIEW Lets_Race AS
 SELECT 
 	r.race_name,
    r.difficulty,
    d.first_name,
 	d.last_name,
 	c.spec,
 	c.year,
 	c.brand,
 	c.model
 FROM 	Drivers d,
 		Cars c,
        Races r
 WHERE d.CarID = c.CarID
 ORDER BY d.last_name DESC; */
 
SELECT 	r.RaceID AS RaceID,
		r.Race_Name AS Name,
 	avg(r.Crowd_Size) AS Avg_Crowd_Size
FROM Races r
WHERE r.Crowd_Size IS NOT NULL
GROUP BY r.RaceID;

SELECT  r.Prize_in_USD * .05 AS The_Bill,
		d.first_name AS  First_Name,
		d.last_name AS  Last_Name
FROM Drivers d,
 	 Racers r
WHERE r.DriverID = d.DriverID
GROUP BY The_Bill;