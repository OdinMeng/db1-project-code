-- Make sure that you are using your database!!!

use [iLovePets]

DECLARE @sql VARCHAR(MAX) = '', @crlf VARCHAR(2) = CHAR(13) + CHAR(10) ;
-- drop views

SELECT @sql = @sql + 'DROP VIEW ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(v.name) +';' + @crlf
FROM   sys.views v

PRINT @sql;
if @sql <> '' 
	EXEC(@sql);

set @sql ='';


--
-- drop triggers


SELECT @sql = @sql + 'DROP TRIGGER ' + QUOTENAME(OBJECT_SCHEMA_NAME(OBJECT_id)) + '.' + QUOTENAME(v.name) +';' + @crlf
FROM   sys.TRIGGERS v

PRINT @sql;
if @sql <> '' 
	EXEC(@sql);

set @sql ='';


-- 
-- drop procedures

SELECT @sql = @sql + 'DROP PROCEDURE [' + SCHEMA_NAME(p.schema_id) + '].[' + p.NAME + '];' + @crlf
FROM sys.procedures p 

PRINT @sql;
if @sql <> '' 
	EXEC(@sql);

set @sql ='';

--
-- drop functions

SELECT @sql = @sql + N' DROP FUNCTION ' 
                   + QUOTENAME(SCHEMA_NAME(schema_id)) 
                   + N'.' + QUOTENAME(name) + @crlf
FROM sys.objects
WHERE type_desc LIKE '%FUNCTION%';

PRINT @sql;
if @sql <> '' 
	EXEC(@sql);

set @sql ='';