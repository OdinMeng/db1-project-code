-- Testing Pranas' triggers
USE [iLovePets]
GO

-- Test Task nr. 1
BEGIN TRANSACTION test_function
	-- Insert Data for petsitterid 2, session ids 9 -> 13
	INSERT INTO dbo.[BOOKING](SESSION_ID, PET_ID, PET_REVIEW, PET_RATING, SITTER_RATING, SITTER_REVIEW)
	VALUES
		(9, 1, NULL, NULL, 3, NULL),
		(10, 1, NULL, NULL, 3, NULL),
		(11, 1, NULL, NULL, 3, NULL),
		(12, 1, NULL, NULL, 3, NULL),
		(13, 1, NULL, NULL, 3, NULL);

	-- Insert data for persitterid 3, session IDs 2->8
	INSERT INTO dbo.[BOOKING](SESSION_ID, PET_ID, PET_REVIEW, PET_RATING, SITTER_RATING, SITTER_REVIEW)
	VALUES
		(2, 1, NULL, NULL, 1, NULL),
		(3, 1, NULL, NULL, 2, NULL),
		(4, 1, NULL, NULL, 3, NULL),
		(5, 1, NULL, NULL, 4, NULL),
		(6, 1, NULL, NULL, 5, NULL);


	-- Test Functions (normal cases)
	DECLARE @rat VARCHAR(MAX)
	
	EXEC @rat = GetPetSitterReviewGrading @petsitterid = 1; -- Should return great
	PRINT 'User 1 has' + ' ' + @rat

	EXEC @rat = GetPetSitterReviewGrading @petsitterid = 2; -- Should return good
	PRINT  'User 2 has' + ' '+  @rat

	EXEC @rat = GetPetSitterReviewGrading @petsitterid = 4; -- Should return not enough reviews because they do not exist
	PRINT 'User 4 has' + ' '+  @rat

	EXEC @rat = GetPetSitterReviewGrading @petsitterid = 3; -- Should return not enough reviews because none of the sessions happened
	PRINT 'User 3 has' + ' '+  @rat
	
ROLLBACK TRANSACTION test_function