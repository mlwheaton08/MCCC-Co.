USE [master]
GO

IF db_id('MCCC Co') IS NULL
  CREATE DATABASE [MCCC Co]
GO

USE [MCCC Co]
GO

DROP TABLE IF EXISTS [OrderItem];
DROP TABLE IF EXISTS [UserItemComment];
DROP TABLE IF EXISTS [UserItemFavorite];
DROP TABLE IF EXISTS [PackItem];
DROP TABLE IF EXISTS [SeriesApplication];
DROP TABLE IF EXISTS [Distributor];
DROP TABLE IF EXISTS [Order];
DROP TABLE IF EXISTS [UserShippingAddress];
DROP TABLE IF EXISTS [Application];
DROP TABLE IF EXISTS [Pack];
DROP TABLE IF EXISTS [User];
DROP TABLE IF EXISTS [Item];
DROP TABLE IF EXISTS [ItemTypeSeries];
DROP TABLE IF EXISTS [Type];
DROP TABLE IF EXISTS [Series];

CREATE TABLE [User] (
  [Id] int PRIMARY KEY identity,
  [FirebaseId] nvarchar(255) unique not null,
  [IsAdmin] bit not null,
  [Name] nvarchar(255) not null,
  [Email] nvarchar(255) not null,
  [RewardsPoints] int
)
GO

CREATE TABLE [UserShippingAddress] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [NickName] nvarchar(255),
  [CompanyName] nvarchar(255),
  [LineOne] nvarchar(255) not null,
  [LineTwo] nvarchar(255),
  [City] nvarchar(255) not null,
  [State] nvarchar(255),
  [ZIPCode] nvarchar(255) not null,
  [Country] nvarchar(255) not null,
  [IsDefault] bit
)
GO

CREATE TABLE [UserItemComment] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [ItemId] int not null,
  [Text] nvarchar(255)
)
GO

CREATE TABLE [UserItemFavorite] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [ItemId] int not null
)
GO

CREATE TABLE [Series] (
  [Id] int PRIMARY KEY identity,
  [Name] nvarchar(255) unique not null,
  [Alloy] nvarchar(255),
  [BrightnessLevel] int,
  [Description] nvarchar(500),
  [Image] nvarchar(255)
)
GO

CREATE TABLE [SeriesApplication] (
  [Id] int PRIMARY KEY identity,
  [SeriesId] int not null,
  [ApplicationId] int not null
)
GO

CREATE TABLE [Application] (
  [Id] int PRIMARY KEY identity,
  [Case] nvarchar(255) not null
)
GO

CREATE TABLE [Type] (
  [Id] int PRIMARY KEY identity,
  [Name] nvarchar(255) unique not null,
  [Image] nvarchar(255)
)
GO

CREATE TABLE [Item] (
  [Id] int PRIMARY KEY identity,
  [TypeId] int,
  [SeriesId] int,
  [Height] int,
  [Width] int,
  [Depth] int,
  [Description] nvarchar(500),
  [Image] nvarchar(255),
  [Price] float not null,
  [PurchaseCount] int
)
GO

CREATE TABLE [PackItem] (
  [Id] int PRIMARY KEY identity,
  [PackId] int not null,
  [ItemId] int not null
)
GO

CREATE TABLE [Pack] (
  [Id] int PRIMARY KEY identity,
  [Name] nvarchar(255) unique not null,
  [Description] nvarchar(255),
  [Price] float not null,
  [PurchaseCount] int
)
GO

CREATE TABLE [OrderItem] (
  [Id] int PRIMARY KEY identity,
  [OrderId] int not null,
  [ItemId] int not null,
  [ItemQuantity] int not null
)
GO

CREATE TABLE [Order] (
  [Id] int PRIMARY KEY identity,
  [UserId] int not null,
  [ShippingAddressId] int,
  [DateCreated] datetime not null,
  [DateCompleted] datetime,
  [RewardsUsed] int,
  [TotalValue] float,
  [TotalPaid] float,
  [ConfirmationNumber] nvarchar(255)
)
GO

CREATE TABLE [Distributor] (
  [Id] int PRIMARY KEY identity,
  [Name] nvarchar(255) not null,
  [AddressLineOne] nvarchar(255),
  [AddressLineTwo] nvarchar(255),
  [City] nvarchar(255),
  [State] nvarchar(255),
  [ZIPCode] nvarchar(255),
  [Country] nvarchar(255),
  [PhoneNumber] nvarchar(255)
)
GO

ALTER TABLE [UserShippingAddress] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [Item] ADD FOREIGN KEY ([TypeId]) REFERENCES [Type] ([Id])
GO

ALTER TABLE [Item] ADD FOREIGN KEY ([SeriesId]) REFERENCES [Series] ([Id])
GO

ALTER TABLE [SeriesApplication] ADD FOREIGN KEY ([SeriesId]) REFERENCES [Series] ([Id])
GO

ALTER TABLE [SeriesApplication] ADD FOREIGN KEY ([ApplicationId]) REFERENCES [Application] ([Id])
GO

ALTER TABLE [UserItemComment] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [UserItemFavorite] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [UserItemComment] ADD FOREIGN KEY ([ItemId]) REFERENCES [Item] ([Id])
GO

ALTER TABLE [UserItemFavorite] ADD FOREIGN KEY ([ItemId]) REFERENCES [Item] ([Id])
GO

ALTER TABLE [PackItem] ADD FOREIGN KEY ([PackId]) REFERENCES [Pack] ([Id])
GO

ALTER TABLE [PackItem] ADD FOREIGN KEY ([ItemId]) REFERENCES [Item] ([Id])
GO

ALTER TABLE [OrderItem] ADD FOREIGN KEY ([OrderId]) REFERENCES [Order] ([Id])
GO

ALTER TABLE [OrderItem] ADD FOREIGN KEY ([ItemId]) REFERENCES [Item] ([Id])
GO

ALTER TABLE [Order] ADD FOREIGN KEY ([UserId]) REFERENCES [User] ([Id])
GO

ALTER TABLE [Order] ADD FOREIGN KEY ([ShippingAddressId]) REFERENCES [UserShippingAddress] ([Id])
GO



-- STARTING DATA --

INSERT INTO [User] (FirebaseId,IsAdmin,[Name],Email,RewardsPoints)
VALUES
  ('aaaaa','1','Damon Blanchard','damonblanchard@aol.net',null),
  ('bbbbb','0','Amela Wall','amelawall@yahoo.edu',2),
  ('ccccc','0','Hedley Waters','hedleywaters4172@protonmail.net',12),
  ('ddddd','0','Aaron Hancock','aaronhancock@yahoo.org',31),
  ('eeeee','0','Portia Dudley','portiadudley@protonmail.com',49),
  ('fffff','0','Portia Dudley','portiadudley@protonmail.com',49)
GO

INSERT INTO UserShippingAddress (UserId, NickName, CompanyName, LineOne, LineTwo, City, [State], ZIPCode, Country, IsDefault)
VALUES
	(2,'','','971-5940 Lorem. Av.','','Nampa','Idaho','66888','United States','1'),
	(2,'','','4000 Cubilia Avenue','Apt 754','Huntsville','Alabama','35581','United States','0'),
	(3,'','','5785 Nec Road','Apt 95','South Bend','Indiana','85249','United States','1'),
	(3,'','','135-9762 Suspendisse Rd.','','Saint Paul','Minnesota','72381','United States','0'),
	(4,'','','146-596 Nibh Rd.','','Austin','Texas','78502','United States','1'),
	(4,'','','6439 Urna Rd.','','New Haven','Connecticut','88747','United States','0'),
	(5,'','','6655 Suspendisse Rd.','','Fayetteville','Arkansas','71276','United States','1'),
	(5,'','','6705 Elit Rd.','','Idaho Falls','Idaho','32751','United States','0')
GO

INSERT INTO [Type] ([Name],[Image])
VALUES
	('Ride',null),
	('Crash',null),
	('Splash',null),
	('Hi Hats',null),
	('China',null),
	('Stack',null),
	('Bell',null)
GO

INSERT INTO Series ([Name],Alloy,BrightnessLevel,[Description],[Image])
VALUES
	('MC1','MS63 Brass',4,'MC1 cymbals represent a breakthrough combination of quality and value, and convince with superior sound and appearance.',null),
	('MC2','MS63 Brass',3,'Ushering in a higher standard of sound and durability, the MC2 series stay true to the renown MCCC quality whilst offering an affordable option for the aspiring drummer looking for high performance and quality sound at an attainable price.',null),
	('MC3','CuSn8 Bronze',5,'MC3 cymbals offer the big, bright, vintage sound that takes you straight back to the height of Classic Rock.',null),
	('Signature','CuSn20',2,'Forged from a proprietary bronze developed specifically for cymbals, handcrafted from start to finish by highly skilled craftsmen, conceived and executed according to uncompromising sound concepts, Signature Cymbals are instruments of unsurpassed quality for the discerning drummerís quest for personal creativity and musical excellence.',null),
	('MCFX','CuSn8 Bronze',1,'MCFX is a complete collection of extremely affordable effect cymbals. The core of the MCFX is made up of the Swiss models, cymbals that achieve a noisy, dirty, trashy sound quality by the use of specific layouts and varied sizes for the holes.',null)
GO

INSERT INTO [Application] ([Case])
VALUES
	('Soft setting'),
	('Loud setting'),
	('Acoustic music'),
	('Live'),
	('Recording'),
	('Jazz'),
	('Rock'),
	('Pop'),
	('Country'),
	('Blues'),
	('Latin'),
	('Classical'),
	('Punk'),
	('Heavy Metal'),
	('Experimental')
GO

INSERT INTO SeriesApplication (SeriesId,ApplicationId)
VALUES
	(1,2),
	(1,4),
	(1,7),
	(1,8),
	(1,9),
	(1,13),
	(1,14),
	(2,1),
	(2,2),
	(2,3),
	(2,4),
	(2,5),
	(2,7),
	(2,8),
	(2,9),
	(2,10),
	(2,11),
	(2,13),
	(3,2),
	(3,4),
	(3,5),
	(3,7),
	(3,8),
	(3,9),
	(3,10),
	(3,11),
	(3,14),
	(4,1),
	(4,3),
	(4,4),
	(4,5),
	(4,6),
	(4,8),
	(4,10),
	(4,11),
	(4,12),
	(4,15),
	(5,1),
	(5,2),
	(5,4),
	(5,5),
	(5,13),
	(5,14),
	(5,15)
GO

INSERT INTO [Item] (TypeId,SeriesId,Height,Width,Depth,[Description],[Image],Price,PurchaseCount)
VALUES
	(1,1,null,18,18,null,null,45,1),
	(1,1,null,20,20,null,null,50,10),
	(1,1,null,22,22,null,null,55,8),
	(2,1,null,14,14,null,null,30,2),
	(2,1,null,16,16,null,null,35,12),
	(2,1,null,18,18,null,null,40,8),
	(3,1,null,8,8,null,null,15,4),
	(3,1,null,10,10,null,null,20,5),
	(4,1,null,13,13,null,null,50,2),
	(4,1,null,14,14,null,null,55,15),
	(4,1,null,15,15,null,null,60,5),
	(5,1,null,16,16,null,null,45,2),
	(5,1,null,18,18,null,null,50,1),

	(1,2,null,18,18,null,null,70,1),
	(1,2,null,20,20,null,null,75,9),
	(1,2,null,22,22,null,null,80,8),
	(2,2,null,14,14,null,null,60,1),
	(2,2,null,16,16,null,null,65,10),
	(2,2,null,18,18,null,null,70,7),
	(3,2,null,8,8,null,null,40,2),
	(3,2,null,10,10,null,null,45,4),
	(4,2,null,13,13,null,null,80,0),
	(4,2,null,14,14,null,null,85,11),
	(4,2,null,15,15,null,null,90,1),
	(5,2,null,16,16,null,null,70,1),
	(5,2,null,18,18,null,null,75,0),

	(1,3,null,18,18,null,null,100,3),
	(1,3,null,20,20,null,null,105,10),
	(1,3,null,22,22,null,null,110,8),
	(2,3,null,14,14,null,null,80,4),
	(2,3,null,16,16,null,null,85,12),
	(2,3,null,18,18,null,null,90,7),
	(3,3,null,8,8,null,null,50,1),
	(3,3,null,10,10,null,null,55,2),
	(4,3,null,13,13,null,null,110,3),
	(4,3,null,14,14,null,null,115,17),
	(4,3,null,15,15,null,null,120,5),
	(5,3,null,16,16,null,null,95,0),
	(5,3,null,18,18,null,null,100,0),

	(1,4,null,18,18,null,null,160,4),
	(1,4,null,20,20,null,null,170,10),
	(1,4,null,21,21,null,null,175,4),
	(1,4,null,22,22,null,null,180,8),
	(2,4,null,14,14,null,null,150,2),
	(2,4,null,16,16,null,null,160,10),
	(2,4,null,18,18,null,null,170,9),
	(4,4,null,13,13,null,null,180,1),
	(4,4,null,14,14,null,null,190,10),
	(4,4,null,15,15,null,null,200,7),

	(6,5,null,16,16,null,null,80,2),
	(6,5,null,18,18,null,null,90,1),
	(7,5,null,6,6,null,null,70,3),
	(7,5,null,8,8,null,null,80,0)
GO

INSERT INTO [Order] (UserId,ShippingAddressId,DateCreated,DateCompleted,RewardsUsed,TotalValue,TotalPaid,ConfirmationNumber)
VALUES
  (1,null,'2020-06-21T17:10:02.000Z','2020-11-27T16:35:15.000Z',null,255,null,'QW0A18TW0I8B0O'),
  (2,2,'2020-04-18T09:04:17.000Z','2020-11-18T23:52:19.000Z',28,95,67,'JK0I34HN0N2E0F'),
  (3,4,'2020-03-26T05:35:47.000Z','2020-11-26T05:14:51.000Z',0,225,225,'IY0R54KN0S8H0T'),
  (4,6,'2020-06-02T02:09:35.000Z','2020-11-15T13:25:39.000Z',23,253,230,'MS0Q77TR0D3E0O'),
  (5,8,'2020-08-01T13:41:07.000Z','2020-11-23T16:49:20.000Z',33,197,164,'PS0O13QD0D2K0F'),
  (1,null,'2021-01-10T12:07:23.000Z','2021-02-03T02:51:49.000Z',null,251,null,'QS0C88TY0Y2U0O'),
  (2,2,'2021-01-23T08:50:48.000Z','2021-02-02T18:04:17.000Z',6,315,309,'XX0M43YQ0E8A0Y'),
  (3,4,'2021-01-06T00:33:20.000Z','2021-02-01T18:39:09.000Z',21,293,272,'OO0I71HL0C1K0M'),
  (4,6,'2021-01-12T23:13:32.000Z','2021-01-30T10:32:16.000Z',22,72,50,'IP0B64JK0Q8S0O'),
  (5,8,'2021-01-26T16:14:15.000Z','2021-02-02T06:29:53.000Z',10,214,204,'MN0L78UH0I0O0C'),
  (1,null,'2021-03-15T21:06:35.000Z','2021-04-03T19:30:28.000Z',null,127,null,'TK0L84SC0U7W0S'),
  (2,1,'2021-03-25T06:03:37.000Z','2021-04-07T05:04:04.000Z',35,281,246,'XJ0Y49MB0P6X0B'),
  (3,3,'2021-03-24T21:28:46.000Z','2021-04-29T06:29:14.000Z',27,231,204,'KM0S54KO0J7L0X'),
  (4,5,'2021-03-20T19:36:51.000Z','2021-04-07T12:12:39.000Z',4,53,49,'MY0K84VT0E3H0K'),
  (5,7,'2021-03-26T04:08:04.000Z','2021-04-14T23:52:42.000Z',2,69,67,'LS0H26DQ0M5E0I'),
  (1,null,'2021-09-07T21:40:02.000Z','2022-02-04T13:17:14.000Z',null,305,null,'YF0N04EC0C9M0Q'),
  (2,1,'2021-09-05T06:37:43.000Z','2022-02-23T15:59:44.000Z',12,168,156,'MQ0Q31WK0R6U0P'),
  (3,3,'2021-09-05T18:04:08.000Z','2022-02-19T10:24:12.000Z',22,149,127,'OR0T90EQ0U8T0K'),
  (4,5,'2021-09-04T05:14:44.000Z','2022-02-18T10:46:34.000Z',31,322,291,'AE0N38SW0C2B0J'),
  (5,7,'2021-09-08T04:45:11.000Z','2022-02-06T02:17:27.000Z',40,267,227,'RI0I92YJ0K6G0I'),
  (1,null,'2022-03-13T23:38:56.000Z',null,null,null,null,null),
  (2,null,'2022-06-28T13:07:30.000Z',null,null,null,null,null),
  (3,null,'2022-07-26T06:45:37.000Z',null,null,null,null,null),
  (4,null,'2022-03-13T07:17:53.000Z',null,null,null,null,null),
  (5,null,'2022-06-01T10:52:33.000Z',null,null,null,null,null)
GO

INSERT INTO OrderItem (OrderId,ItemId,ItemQuantity)
VALUES
	(1,4,2),
	(1,3,2),
	(2,5,2),
	(2,5,2),
	(3,1,2),
	(3,2,2),
	(4,7,2),
	(4,10,2),
	(5,15,2),
	(5,11,2),
	(6,2,2),
	(6,23,2),
	(7,4,2),
	(7,6,2),
	(8,8,2),
	(8,9,2),
	(9,10,2),
	(9,1,2),
	(10,1,2),
	(10,4,2),
	(11,6,2),
	(11,7,2),
	(12,8,2),
	(12,10,2),
	(13,15,2),
	(13,16,2),
	(14,19,2),
	(14,21,2),
	(15,25,2),
	(15,24,2),
	(16,1,2),
	(16,24,2),
	(17,1,2),
	(17,52,2),
	(18,51,2),
	(18,24,2),
	(19,44,2),
	(19,34,2),
	(20,38,2),
	(20,39,2),
	(21,24,2),
	(21,49,2),
	(22,52,2),
	(22,23,2),
	(23,34,2),
	(23,35,2),
	(24,36,2),
	(24,37,2),
	(25,20,2),
	(25,12,2)
GO

INSERT INTO Pack ([Name],[Description],Price,PurchaseCount)
VALUES
	('Starter','',100,8),
	('Rockstar','',250,5),
	('Mega','',400,2),
	('Jazzcat','',350,1),
	('Cocktail','',350,1),
	('New School','',200,3)
GO

INSERT INTO PackItem (PackId,ItemId)
VALUES
	(1,2),
	(1,5),
	(1,10),

	(2,29),
	(2,31),
	(2,32),
	(2,37),

	(3,16),
	(3,19),
	(3,18),
	(3,31),
	(3,20),
	(3,23),
	(3,25),
	(3,50),

	(4,42),
	(4,48),

	(5,14),
	(5,21),
	(5,22),

	(6,41),
	(6,49),
	(6,51),
	(6,52)
GO