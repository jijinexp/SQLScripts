<Query Kind="Statements">
  <Connection>
    <ID>957a9bb0-6cb0-4c02-9b2d-4d9b58930ef5</ID>
    <Persist>true</Persist>
    <Driver Assembly="IQDriver" PublicKeyToken="5b59726538a49684">IQDriver.IQDriver</Driver>
    <Provider>Devart.Data.Oracle</Provider>
    <CustomCxString>AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAMK/im4EMB02w1cUTayk5ngAAAAACAAAAAAAQZgAAAAEAACAAAAC6qSNpOlFrabxqiXIBkoCMJ/CAGv8LwTvC7CHRM/OMWgAAAAAOgAAAAAIAACAAAABjcEbvGXZcNV21NGu/v0JTslE0Zep/KRDYKxRGiGk/qXAAAACGSswf90zyBM/sn6kOCRyddlZwpvrQD7MhU+XAfsSbiw4y7qS5O/YUoQsBws/IBk1oJz1xMSrgr8GoiLWdn8C9UFXNoPtUGys40ero3giEyblDZRp0LNseV0v1OPPut3azKhKipPBMHBysziGqqlMGQAAAAAMdwtC5HdN6+V+PWNJ9LNOXozRxpMj65DqMrdVAuergB3gPYYmHJC1JJsyQNp0TiFwqC+CoHcq7joNIpTxbw8s=</CustomCxString>
    <Server>inms-oracle.massey.ac.nz</Server>
    <UserName>IT337049</UserName>
    <Password>AQAAANCMnd8BFdERjHoAwE/Cl+sBAAAAMK/im4EMB02w1cUTayk5ngAAAAACAAAAAAAQZgAAAAEAACAAAABpxb3IlaDj6OsSQSQYZmEio0dQDkTCcPnkAoJgVC/2zgAAAAAOgAAAAAIAACAAAAAxfdrfILRSFK218SJ62diLmTeA7DoaQqxalrPtvCoqUhAAAADFCRm4Wn9zN1sCpTb+HRHDQAAAAHCADw3VFRAa71aV5ElL0j99EesA/5PRCP2xuTmdd0F/5wiigcyCTFhGMv9YquO9SYip52VQXXerLyqIB4tATzo=</Password>
    <DisplayName>Johney_18032679</DisplayName>
    <EncryptCustomCxString>true</EncryptCustomCxString>
    <DriverData>
      <StripUnderscores>true</StripUnderscores>
      <QuietenAllCaps>true</QuietenAllCaps>
      <ConnectAs>Default</ConnectAs>
      <UseOciMode>false</UseOciMode>
      <SID>orcl</SID>
      <Port>1521</Port>
    </DriverData>
  </Connection>
</Query>

var book_list = 
			from b in Books
			where b.BookRetail >= 22.0M
			select b;
				
book_list.Dump();	

var title= from s in Books
				 where s.BookTitle.StartsWith("HOW") 	
				 select s; 	
title.Dump();					 

var publishers = from b in Books join s in Publishers
				 on b.BookPubid equals s.PubID
				 select new
				 {
				  Book_Title = b.BookTitle,
				  Book_Category = b.BookCategory,
				  Publisher = s.PubName
				 };
publishers.Dump();


var book_nos = from h in Publishers join n in Books
			   on h.PubID equals n.BookPubid
			   group n.BookPubid by h.PubID into p
			   select new
			   {
			   Pub_id = p.Key,
			   Book_nos =p.Count()
			   };
book_nos.Dump();			   
			   
			   
			   
