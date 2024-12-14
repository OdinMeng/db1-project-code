-- Generate Synthetic Data for Testing Purposes
USE [iLovePets]
GO

--========================X========================--

-- Populate tables without any FK constraints:
	-- Users: 5 sitters and 5 owners
BEGIN TRANSACTION
	INSERT INTO dbo.[user] (first_name, last_name, e_mail, is_pet_sitter, hourly_rate, max_attendance)
	VALUES ('Alice', 'Smith', 'alice.smith@example.com', 1, 17, 5),
	('Bob', 'Johnson', 'bob.johnson@example.com', 1, 15, 3),
	('Charlie', 'Williams', 'charlie.williams@example.com', 1, 19, 3),
	('Diana', 'Jones', 'diana.jones@example.com', 1, 15, 5),
	('Ethan', 'Brown', 'ethan.brown@example.com', 1, 23, 4),
	('Fiona', 'Davis', 'fiona.davis@example.com', 0, NULL, NULL),
	('George', 'Miller', 'george.miller@example.com', 0, NULL, NULL),
	('Hannah', 'Wilson', 'hannah.wilson@example.com', 0, NULL, NULL),
	('Ian', 'Moore', 'ian.moore@example.com', 0, NULL, NULL),
	('Julia', 'Taylor', 'julia.taylor@example.com', 0, NULL, NULL);
	SELECT * FROM dbo.[user];
COMMIT TRANSACTION

	-- Areas of Expertise: 5 areas
BEGIN TRANSACTION
	INSERT INTO dbo.[AREASOFEXPERTISE](area_name)
	VALUES ('Pet fitness'), ('Basic animal first aid'), ('Animal behavior');
	SELECT * FROM dbo.[AREASOFEXPERTISE];
COMMIT TRANSACTION

	-- Species: 6 species, very realistic species
BEGIN TRANSACTION
	INSERT INTO dbo.[SPECIES]([NAME])
	VALUES ('Dog'), ('Fish'), ('Cat'), ('Human'), ('Alligator'), ('Airplane');
	SELECT * FROM dbo.[SPECIES];
COMMIT TRANSACTION

--========================X========================--

-- Populate second-order tables:
	-- Messages: 5 messages
BEGIN TRANSACTION
	INSERT INTO dbo.[MESSAGES](sender_id, receiver_id, body, subject, time)
	VALUES(1, 9, 'Hello, World!', NULL, GETDATE() ),
	(9, 1, 'i like your cut g', 'HEADER', GETDATE() ),
	(2, 8, 'This is a test message', 'Hello', GETDATE() ),
	(2, 8, 'This is a test message', 'Hello2', GETDATE() );
	SELECT * FROM dbo.[MESSAGES]
COMMIT TRANSACTION

	-- Sitter Expertise: some random links
BEGIN TRANSACTION
	INSERT INTO dbo.[SITTEREXPERTISE](user_id, area_id)
	VALUES
		(1, 2),
		(1,3),
		(2,1),
		(2,2),
		(3,3);
	SELECT * from dbo.[SITTEREXPERTISE]
COMMIT TRANSACTION
	-- Breeds: 5 breeds (1-1 link)
BEGIN TRANSACTION
	INSERT INTO dbo.[BREED](SPECIES_ID, BREED_NAME)
	VALUES
		(1, 'Canis Lupus'),
		(1, 'Doge'),
		(2, 'Goldfish'),
		(3, 'Some cat'),
		(4, 'John'),
		(5, 'Exploding'),
		(6, 'Boeing 747');
	SELECT * FROM dbo.[BREED]
COMMIT TRANSACTION
	
	-- Pets
BEGIN TRANSACTION
	INSERT INTO dbo.[PET](USER_ID, BREED_ID, [NAME], YEAR_OF_BIRTH, TEMPERAMENT, COMMENTS)
	VALUES 
		(6, 1, 'Dog', 2004, 'Playful', NULL),
		(7, 7, 'Airplane', 1963, 'Calm', 'Good pet'),
		(8, 3, 'Blubby', 2020, 'Anxious', 'Drinks water'),
		(9, 4, 'Catty', 2012, 'Friendly', 'Some cat'),
		(6, 2, 'Dog 2', 2005, 'Aggressive', NULL);
	SELECT * FROM dbo.[PET]
COMMIT TRANSACTION

--========================X========================--

-- Third order:
	-- Preferred Breeds
BEGIN TRANSACTION
	INSERT INTO dbo.[PREFERREDBREEDS](USER_ID, BREED_ID)
	VALUES
		(1, 1),
		(1, 2),
		(2, 3),
		(2, 1),
		(3, 5),
		(4, 1);
	SELECT * FROM dbo.[PREFERREDBREEDS]
COMMIT TRANSACTION

	-- Vaccination Cert.s: 3 vac. cert.s (no)

--========================X========================--

-- Fourth Order: 
	-- Recurrence Configurations
	-- Note: ([RECURRENCE] IS NULL OR ([RECURRENCE]='not recurrent' OR [RECURRENCE]='monthly' OR [RECURRENCE]='weekly' OR [RECURRENCE]='daily'))
BEGIN TRANSACTION
	INSERT INTO dbo.SLOTSRECURRENCECONFIGURATION(USER_ID, RECURRENCE_END_DATE, RECURRENCE, SESSION_END, SESSION_START, LAT, LONG)
	VALUES 
		(1, NULL, NULL, '2024-01-02 15:00', '2024-01-01 12:00', NULL, NULL),
		(1, '2024-09-06', 'daily', '2024-09-01 15:00', '2024-09-01 12:00', NULL, NULL),
		(2, '2024-10-01', 'monthly', '2024-05-01 15:00', '2024-05-01 10:00', NULL, NULL),
		(3, '2025-02-15', 'weekly', '2025-01-02 09:30', '2025-01-02 08:30:00', NULL, NULL),
		(4, NULL, 'not recurrent', '2020-01-01 00:01', '2019-01-01 00:01', NULL, NULL);
	SELECT * FROM dbo.SLOTSRECURRENCECONFIGURATION
	SELECT * FROM dbo.[SESSION] -- Tests pranas' code as well, it works :thumbsup: 👍
COMMIT TRANSACTION

	-- Sessions: automatically done with pranas' trigger

	
--========================X========================--

	
-- Last Order:
	-- Slot target breeds


	-- Bookings

