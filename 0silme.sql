
declare @id int;
declare @deger varchar(100);


DECLARE @result TABLE (
    id INT,
	deger varchar(100),
	sonuc varchar(100)
);


DECLARE db_cursor CURSOR FOR 
SELECT id, deger
from Table_1

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @id, @deger

WHILE @@FETCH_STATUS = 0  
BEGIN  
	declare @sonuc varchar(100) = '.' + @deger;

	 while (CHARINDEX('.0', @sonuc, 1)>0)
	 begin
		set @sonuc = REPLACE(@sonuc, '.0', '.');
	 end;

	 set @sonuc = SUBSTRING(REPLACE(@sonuc, '..', '.0.'), 2, 100);
	 set @sonuc = REPLACE( @sonuc,'..','.0.')
     set @sonuc = @sonuc +'+';
	 set @sonuc = REPLACE(@sonuc ,'.+','.0');
     set @sonuc = REPLACE(@sonuc ,'+','');

	 --select @id, @deger, @sonuc
	 insert into @result (id, deger, sonuc) values (@id, @deger,@sonuc)

     FETCH NEXT FROM db_cursor INTO  @id, @deger
END 


CLOSE db_cursor  
DEALLOCATE db_cursor 



select * from @result


