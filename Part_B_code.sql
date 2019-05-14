/*Write a query that will list all the books with the price difference (between retail and cost) of $10 or more. Display your results in the decreasing order of the price difference.*/
/*CREATE VIEW BOOKDETAILS AS*/
/*SELECT  BOOK_TITLE AS "LIST OF BOOKS",BOOK_RETAIL-BOOK_COST AS "PRICE DIFFERENCE"
FROM BOOK 
WHERE BOOK_RETAIL-BOOK_COST>=10.0
ORDER BY  "PRICE DIFFERENCE" DESC;*/

/*SELECT * FROM BOOKDETAILS;*/

/*DROP VIEW BOOKDETAILS;*/

/*Write a query that will list books in COMPUTER category along with other details (e.g. author(s), etc.). The query should work for all the case-variations of category values (i.e. 'computer', 'Computer', etc.) in the database.*/

/*SELECT BOOK_ISBN,BOOK_TITLE,BOOK_CATEGORY AS "CATEGORY",AUTHOR_FNAME||' '|| AUTHOR_LNAME AS "AUTHOR NAME" 
FROM ((BOOKAUTHOR
INNER JOIN BOOK ON BA_ISBN=BOOK_ISBN)
INNER JOIN AUTHOR ON BA_AUTHORID=AUTHOR_ID)
WHERE UPPER(BOOK_CATEGORY)  LIKE  'COMPUTE%' ;*/


/*Write a query that will list books that have retail price $30 or less and were published in any of the years 1999 or 2001. Display results in the increasing order of the publication year (and not the publication date) and decreasing retail price. Display the year of publication with the column
titled Publication Year.*/

/*SELECT BOOK_TITLE AS "BOOK TITLE",BOOK_RETAIL AS "RETAIL PRICE",EXTRACT(YEAR FROM BOOK_PUBDATE) AS "Publication Year"
FROM BOOK
WHERE BOOK_RETAIL <= 30
AND  (EXTRACT(YEAR FROM BOOK_PUBDATE) = 1999 OR EXTRACT(YEAR FROM BOOK_PUBDATE) = 2001) 
ORDER BY  'RETAIL PRICE' DESC ,'Publication Year' ASC;*/

/*Write a query that lists both customer and author details (only their ids, first and last names). Provide suitable headings for the merged list.*/

/*SELECT DISTINCT(C.CUST_NUM) AS "Customer ID",
              C.CUST_FNAME ||' '||C.CUST_LNAME AS "Customer Name",
              A.BA_AUTHORID AS "Author ID",
              N.AUTHOR_FNAME||' '||N.AUTHOR_LNAME AS "Author Name"
FROM CUSTOMER C, BOOKORDER O,BOOKORDERITEM I,BOOKAUTHOR A,AUTHOR N
WHERE C.CUST_NUM=O.BO_CUSTNUM
AND O.BO_ORDERNUM=I.BOI_ORDERNUM
AND I.BOI_ISBN=A.BA_ISBN
AND A.BA_AUTHORID=N.AUTHOR_ID;*/

/*Write a query that will list all the publishers, their details (name, etc.) and total number of published books. Display your output in the decreasing order of total number of publications.*/

/*SELECT P.PUB_ID AS "ID",
              P.PUB_NAME AS "PUBLISHER NAME",
              P.PUB_CONTACT AS "CONTACT NAME",
              P.PUB_PHONE AS "PHONE NO",
              COUNT(P.PUB_ID) AS "BOOKS PUBLISHED"
FROM PUBLISHER P,BOOK B
WHERE P.PUB_ID=B.BOOK_PUBID
GROUP BY P.PUB_ID,P.PUB_NAME,P.PUB_CONTACT,P.PUB_PHONE
ORDER BY P.PUB_ID ASC;*/

/*Write a query that will display the states with more than one customer. Display the state with maximum customers first.*/
/*SELECT C.CUST_STATE AS "STATE",COUNT(C.CUST_NUM) AS "NUMBER OF CUSTOMERS"
FROM CUSTOMER C
GROUP BY C.CUST_STATE
HAVING COUNT(C.CUST_NUM) >1
ORDER BY COUNT(C.CUST_NUM) DESC ;*/

/*Write a query that will list the publisher(s) with the maximum number of published books. If there is more than one publisher (e.g. 2 publishers) with maximum publications, your query should and list all (i.e. both if 2).*/

/*SELECT P.PUB_ID ,P.PUB_NAME,P.PUB_CONTACT,P.PUB_PHONE,COUNT(P.PUB_ID) AS "BOOK PUBLICATIONS"
FROM PUBLISHER P,BOOK B
WHERE P.PUB_ID=B.BOOK_PUBID 
GROUP BY P.PUB_ID,P.PUB_NAME,P.PUB_CONTACT,P.PUB_PHONE
HAVING P.PUB_ID=(SELECT MAX(COUNT(P.PUB_ID))
FROM PUBLISHER P,BOOK B WHERE P.PUB_ID=B.BOOK_PUBID
GROUP BY P.PUB_ID);*/
