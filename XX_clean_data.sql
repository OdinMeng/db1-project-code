-- Make sure that you are using your database!!!

use [iLovePets]

-- disable all constraints before loading data to avoid FK restrictions
EXEC sp_MSForEachTable "ALTER TABLE ? NOCHECK CONSTRAINT all";

-- delete data in all tables
EXEC sp_MSForEachTable "DELETE FROM ?";


-- reset identity columns if necessary

DECLARE @sql VARCHAR(MAX) = '', @crlf VARCHAR(2) = CHAR(13) + CHAR(10) ;

SELECT @sql = @sql + 'DBCC CHECKIDENT (''' + OBJECT_NAME(OBJECT_ID) + ''', RESEED, 0);' + @crlf
FROM sys.identity_columns WHERE system_type_id = 108 AND last_value IS NOT NULL

PRINT @sql;
if @sql <> '' 
	EXEC(@sql);

set @sql ='';

EXEC sp_MSForEachTable "ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

