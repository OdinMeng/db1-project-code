
-- Base de Dados I - Second Project Deliverable

-- Use DB
USE [iLovePets]
GO

-- Task 1

CREATE OR ALTER FUNCTION GetPetSitterReviewGrading(@petsitterid INT) RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @reviewcount INT
    DECLARE @averagescore FLOAT

    SELECT @reviewcount = COUNT(*),
           @averagescore = AVG(b.sitter_rating)
    FROM dbo.[booking] b
             JOIN
         dbo.[session] s ON b.session_id = s.session_id
             JOIN
         dbo.[slotsrecurrenceconfiguration] slt ON slt.recurrence_id = s.recurrence_id
    WHERE slt.user_id = @petsitterid
      AND s.session_end < GETDATE()

    RETURN CASE
               WHEN @reviewcount < 3 THEN 'Not enough reviews'
               WHEN @averagescore < 2 THEN 'Bad'
               WHEN @averagescore < 3 THEN 'Medium'
               WHEN @averagescore < 4 THEN 'Good'
               ELSE 'Great'
        END;
END
GO

-- Task 2

CREATE OR ALTER TRIGGER trg_change_session_capacity_check
    ON session
    INSTEAD OF UPDATE AS
BEGIN
    UPDATE [session]
    SET recurrence_id          = i.recurrence_id,
        session_start          = i.session_start,
        session_end            = i.session_end,
        session_max_attendance = i.session_max_attendance,
        lat                    = i.lat,
        long                   = i.long
    FROM inserted i
             LEFT JOIN (SELECT session_id,
                               COUNT(*) AS booking_count
                        FROM booking
                        GROUP BY session_id) b ON i.session_id = b.session_id
    WHERE i.session_id = [session].session_id
      AND (i.session_max_attendance IS NULL
        OR COALESCE(b.booking_count, 0) <= i.session_max_attendance);

    DECLARE @num_rec_ok INT; SET @num_rec_ok = @@ROWCOUNT;
    DECLARE @num_rec INT; SELECT @num_rec = COUNT(*) FROM inserted;

    PRINT 'Number of correct records ' + CONVERT(VARCHAR, @num_rec_ok) + ' from a total of ' +
          CONVERT(VARCHAR, @num_rec) + ' records';

    IF @num_rec_ok < @num_rec
        PRINT 'There are ' + CONVERT(VARCHAR, @num_rec - @num_rec_ok) +
              ' that could not be updated'
END;
GO

-- Task 3

CREATE OR ALTER TRIGGER trg_review_after_session_end_check
    ON booking
    INSTEAD OF UPDATE AS
BEGIN
    UPDATE booking
    SET 
        pet_rating    = i.pet_rating,
        pet_review    = i.pet_review,
        sitter_rating = i.sitter_rating,
        sitter_review = i.sitter_review

    FROM booking b
             JOIN inserted i
                  ON b.session_id = i.session_id AND i.PET_ID = b.PET_ID
             JOIN session s
                  ON i.session_id = s.session_id
    WHERE s.session_end < GETDATE();

    DECLARE @num_rec_ok INT; SET @num_rec_ok = @@ROWCOUNT;
    DECLARE @num_rec INT; SELECT @num_rec = COUNT(*) FROM inserted;

    PRINT 'Number of correct records ' + CONVERT(VARCHAR, @num_rec_ok) + ' from a total of ' +
          CONVERT(VARCHAR, @num_rec) + ' records';

    IF @num_rec_ok < @num_rec
        PRINT 'There are ' + CONVERT(VARCHAR, @num_rec - @num_rec_ok) +
              ' that could not be reviewed because the session has not ended yet'
END
GO

-- Task 4

CREATE OR ALTER TRIGGER trg_message_exchange_check
    ON [messages]
    INSTEAD OF INSERT AS
BEGIN
    INSERT INTO [messages] (sender_id, receiver_id, body, subject, time)
    SELECT i.sender_id, i.receiver_id, i.body, i.subject, i.time
    FROM inserted i
             JOIN [User] u1 ON i.sender_id = u1.user_id
             JOIN [User] u2 ON i.receiver_id = u2.user_id
    WHERE u1.is_pet_sitter <> u2.is_pet_sitter;

    DECLARE @num_rec_ok INT; SET @num_rec_ok = @@ROWCOUNT;
    DECLARE @num_rec INT; SELECT @num_rec = COUNT(*) FROM inserted;

    PRINT 'Number of correct records ' + CONVERT(VARCHAR, @num_rec_ok) + ' from a total of ' +
          CONVERT(VARCHAR, @num_rec) + ' records';

END
GO

-- Task 5

CREATE OR ALTER TRIGGER trg_book_session_check
    ON booking
    INSTEAD OF INSERT AS
BEGIN
    INSERT INTO booking (session_id, pet_id, pet_rating, pet_review, sitter_rating, sitter_review)
    SELECT i.session_id, i.pet_id, i.pet_rating, i.pet_review, i.sitter_rating, i.sitter_review
    FROM inserted i
			-- Join tables to get necessary information to check
             INNER JOIN pet p ON i.pet_id = p.pet_id
             INNER JOIN session s ON i.session_id = s.session_id
             INNER JOIN slotsrecurrenceconfiguration src ON s.recurrence_id = src.recurrence_id
             INNER JOIN [user] u ON src.user_id = u.user_id
             LEFT JOIN (SELECT session_id, COUNT(*) AS current_bookings
                        FROM booking
                        GROUP BY session_id) b
                       ON i.session_id = b.session_id
		
	-- COALESCE is a statement which gets the first non-null value in its input
		-- ex: COALESCE(NULL,2,NULL) returns 2

    WHERE -- Test conditions
		s.session_start > GETDATE() AND -- Condition 5.1. 
		(COALESCE(b.current_bookings, 0) < COALESCE(s.session_max_attendance, u.max_attendance) OR (u.MAX_ATTENDANCE is NULL AND s.SESSION_MAX_ATTENDANCE is NULL)) AND -- Condition 5.2.
		p.breed_id IN (
					SELECT breed_id
					FROM slottargetbreeds
					WHERE session_id = i.session_id

					UNION

					SELECT breed_id
					FROM preferredbreeds
					WHERE user_id = u.user_id
					); -- Condition 5.3.

    DECLARE @num_rec_ok INT; SET @num_rec_ok = @@ROWCOUNT;
    DECLARE @num_rec INT; SELECT @num_rec = COUNT(*) FROM inserted;

    PRINT 'Number of correct records ' + CONVERT(VARCHAR, @num_rec_ok) + ' from a total of ' +
          CONVERT(VARCHAR, @num_rec) + ' records';

    IF @num_rec_ok < @num_rec
        PRINT 'There are ' + CONVERT(VARCHAR, @num_rec - @num_rec_ok) +
              ' that could not be inserted'

END;
GO

-- Task 6

CREATE OR ALTER PROCEDURE generate_sessions_for_recurrence(@recurrenceid INT)
AS
BEGIN
	-- Declare local variables
    DECLARE @recurrence_id INT
    DECLARE @lat FLOAT
    DECLARE @long FLOAT
    DECLARE @occurence_start DATETIME
    DECLARE @occurence_end DATETIME

    DECLARE @finish_date DATETIME
    DECLARE @frequency INT

	-- Get info
    SELECT @recurrence_id = recurrence_id,
           @lat = lat,
           @long = long,
           @occurence_start = session_start,
           @occurence_end = session_end,
           @finish_date = recurrence_end_date,
           @frequency = CASE recurrence
                            WHEN 'daily' THEN 1
                            WHEN 'weekly' THEN 7
                            WHEN 'monthly' THEN 30
					  END
    
	FROM slotsrecurrenceconfiguration
    WHERE recurrence_id = @recurrenceid;

	-- Case 0: no frequency
    IF (@frequency IS NULL OR @finish_date IS NULL)
        INSERT INTO session (recurrence_id, session_start, session_end, lat, long)
        VALUES (@recurrence_id, @occurence_start, @occurence_end, @lat, @long);
	-- Case 1: has frequency
    ELSE
        WHILE (@occurence_start <= @finish_date)
            BEGIN
                INSERT INTO session (recurrence_id, session_start, session_end, lat, long)
                VALUES (@recurrence_id, @occurence_start, @occurence_end, @lat, @long);

                SET @occurence_start = DATEADD(DAY, @frequency, @occurence_start);
                SET @occurence_end = DATEADD(DAY, @frequency, @occurence_end);
            END
END;
GO

CREATE OR ALTER TRIGGER trg_generate_sessions
    ON slotsrecurrenceconfiguration
    AFTER INSERT AS
    DECLARE @nrows INT; SET @nrows = (SELECT COUNT(*)
                                      FROM inserted);
    DECLARE @i INT; SET @i = 0;
    DECLARE @id_slot INT;

	-- Create some a temporary table, representing a sort of array of recurrence IDs to be processed
    DECLARE
        @recurrenceids TABLE
                       (
                           recurrence_id INT
                       );

	--  Fill the temporary array
    INSERT INTO @recurrenceids (recurrence_id)
    SELECT i.recurrence_id
    FROM inserted i

	-- "Iterate" over array and execute SP; it processes the array i times, which is the amount of rows to be processed
    WHILE @i < @nrows
        BEGIN
            SET @id_slot = (SELECT TOP 1 r.recurrence_id FROM @recurrenceids r);
            DELETE FROM @recurrenceids WHERE recurrence_id = @id_slot;
            EXECUTE generate_sessions_for_recurrence @id_slot;
            SET @i = @i + 1;
        END;
GO
