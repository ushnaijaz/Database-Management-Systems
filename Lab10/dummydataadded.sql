-- adding dummy data into production brands table

Declare @Id int
Set @Id = 1

While @Id <= 20000
Begin 
   Insert Into production.brands values ('Brand - ' + CAST(@Id as nvarchar(10)) + ' name')
   Print @Id
   Set @Id = @Id + 1
End


Declare @Id int
Set @Id = 1

While @Id <= 20000
Begin 
   Insert Into production.categories values ('category - ' + CAST(@Id as nvarchar(10)) + ' name')
   Print @Id
   Set @Id = @Id + 1
End



Declare @RandomBrandId int
Declare @RandomCatergoryId int
Declare @RandomModelYear int
Declare @RandomPrice int


Declare @LowerLimitForBrandId int
Declare @UpperLimitForBrandId int

Set @LowerLimitForBrandId = 1
Set @UpperLimitForBrandId = 20000


Declare @LowerLimitForCatergoryId int
Declare @UpperLimitForCatergoryId int

Set @LowerLimitForCatergoryId = 1
Set @UpperLimitForCatergoryId = 20000


Declare @LowerLimitForPrice int
Declare @UpperLimitForPrice int

Set @LowerLimitForPrice = 50 
Set @UpperLimitForPrice = 100 

Declare @LowerLimitForModelYear int
Declare @UpperLimitForModelYear int

Set @LowerLimitForModelYear = 1
Set @UpperLimitForModelYear = 10


Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomBrandId = Round(((@UpperLimitForBrandId - @LowerLimitForBrandId) * Rand()) + @LowerLimitForBrandId, 0)
   Select @RandomCatergoryId = Round(((@UpperLimitForCatergoryId - @LowerLimitForCatergoryId) * Rand()) + @LowerLimitForCatergoryId, 0)
   Select @RandomPrice = Round(((@UpperLimitForPrice - @LowerLimitForPrice) * Rand()) + @LowerLimitForPrice, 0)
   Select @RandomModelYear = Round(((@UpperLimitForModelYear - @LowerLimitForModelYear) * Rand()) + @LowerLimitForModelYear, 0)


   Insert Into production.products values ('Product - ' + CAST(@RandomBrandId as nvarchar(10)), @RandomBrandId,@RandomCatergoryId, @RandomPrice, @RandomModelYear)
   Print @count
   Set @count = @count + 1
End


Declare @RandomPhone int
Declare @RandomZipCode int


Declare @LowerLimitForPhone int
Declare @UpperLimitForPhone int

Set @LowerLimitForPhone = 1
Set @UpperLimitForPhone = 20000


Declare @LowerLimitForZipCode int
Declare @UpperLimitForZipCode int

Set @LowerLimitForZipCode = 1
Set @UpperLimitForZipCode = 20000


Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomPhone = Round(((@UpperLimitForPhone - @LowerLimitForPhone) * Rand()) + @LowerLimitForPhone, 0)
   Select @RandomZipCode = Round(((@UpperLimitForZipCode - @LowerLimitForZipCode) * Rand()) + @LowerLimitForZipCode, 0)

   Insert Into sales.customers values ('Name - ' + CAST(@RandomPhone as nvarchar(10)),'Lastname - ' + CAST(@RandomPhone as nvarchar(10)), @RandomPhone,'email - ' + CAST(@RandomPhone as nvarchar(10)),'street- ' + CAST(@RandomPhone as nvarchar(10)), 'Street - ' + CAST(@RandomPhone as nvarchar(10)),'Street - ' + CAST(@RandomPhone as nvarchar(10)), @RandomZipCode)
   Print @count
   Set @count = @count + 1
End


Declare @RandomOrderid int
Declare @RandomItemid int
Declare @RandomProdid int
Declare @RandomQuant int
Declare @RandomPrice int
Declare @RandomDisc int


Declare @LowerLimitForOrderid int
Declare @UpperLimitForOrderid int

Set @LowerLimitForOrderid = 1
Set @UpperLimitForOrderid = 20000


Declare @LowerLimitForItemid int
Declare @UpperLimitForItemid int

Set @LowerLimitForItemid = 1
Set @UpperLimitForItemid = 20000


Declare @LowerLimitForProdid int
Declare @UpperLimitForProdid int

Set @LowerLimitForProdid = 50 
Set @UpperLimitForProdid = 100 

Declare @LowerLimitForQuant int
Declare @UpperLimitForQuant int

Set @LowerLimitForQuant = 1
Set @UpperLimitForQuant = 10


Declare @LowerLimitForPrice int
Declare @UpperLimitForPrice int

Set @LowerLimitForPrice = 1
Set @UpperLimitForPrice = 20000



Declare @LowerLimitForDisc int
Declare @UpperLimitForDisc int

Set @LowerLimitForDisc = 0.1
Set @UpperLimitForDisc = 1


Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomOrderid = Round(((@UpperLimitForOrderid - @LowerLimitForOrderid) * Rand()) + @LowerLimitForOrderid, 0)
   Select @RandomItemid  = Round(((@UpperLimitForItemid - @LowerLimitForItemid) * Rand()) + @LowerLimitForItemid, 0)
   Select @RandomProdid =Round(((@UpperLimitForProdid - @LowerLimitForProdid) * Rand()) + @LowerLimitForProdid, 0)
   Select @RandomQuant =Round(((@UpperLimitForQuant - @LowerLimitForQuant) * Rand()) + @LowerLimitForQuant, 0)
    Select @RandomPrice = Round(((@UpperLimitForPrice - @LowerLimitForPrice) * Rand()) + @LowerLimitForPrice, 0)
   Select @RandomDisc = Round(((@UpperLimitForDisc - @LowerLimitForDisc) * Rand()) + @LowerLimitForDisc, 0)

   Insert Into sales.order_items values (  @RandomOrderid + @RandomOrderid,@RandomItemid,@RandomProdid,@RandomQuant, @RandomPrice,@RandomDisc)
   Print @count
   Set @count = @count + 1
End



Declare @LowerLimitForPhone int
Declare @UpperLimitForPhone int

Set @LowerLimitForPhone = 1
Set @UpperLimitForPhone = 20000


Declare @LowerLimitForZipCode int
Declare @UpperLimitForZipCode int

Set @LowerLimitForZipCode = 1
Set @UpperLimitForZipCode = 20000


Declare @count int
Set @count = 1

While @count <= 20000
Begin 

   Select @RandomPhone = Round(((@UpperLimitForPhone - @LowerLimitForPhone) * Rand()) + @LowerLimitForPhone, 0)
   Select @RandomZipCode = Round(((@UpperLimitForZipCode - @LowerLimitForZipCode) * Rand()) + @LowerLimitForZipCode, 0)

   Insert Into sales.customers values ('Name - ' + CAST(@RandomPhone as nvarchar(10)),'Lastname - ' + CAST(@RandomPhone as nvarchar(10)), @RandomPhone,'email - ' + CAST(@RandomPhone as nvarchar(10)),'street- ' + CAST(@RandomPhone as nvarchar(10)), 'Street - ' + CAST(@RandomPhone as nvarchar(10)),'Street - ' + CAST(@RandomPhone as nvarchar(10)), @RandomZipCode)
   Print @count
   Set @count = @count + 1
End