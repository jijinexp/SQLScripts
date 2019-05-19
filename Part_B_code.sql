/*Write a query that will list all the books with the price difference (between retail and cost) of $10 or more. Display your results in the decreasing order of the price difference.*/

SELECT  BOOK_TITLE AS "LIST OF BOOKS",BOOK_RETAIL-BOOK_COST AS "PRICE DIFFERENCE"
FROM BOOK 
WHERE BOOK_RETAIL-BOOK_COST>=10.0
ORDER BY  "PRICE DIFFERENCE" DESC;

/*Write a query that will list books in COMPUTER category along with other details (e.g. author(s), etc.). The query should work for all the case-variations of category values (i.e. 'computer', 'Computer', etc.) in the database.*/

SELECT BOOK_ISBN,BOOK_TITLE,BOOK_CATEGORY AS "CATEGORY",AUTHOR_FNAME||' '|| AUTHOR_LNAME AS "AUTHOR NAME" 
FROM ((BOOKAUTHOR
INNER JOIN BOOK ON BA_ISBN=BOOK_ISBN)
INNER JOIN AUTHOR ON BA_AUTHORID=AUTHOR_ID)
WHERE UPPER(BOOK_CATEGORY)  LIKE  'COMPUTE%' ;


/*Write a query that will list books that have retail price $30 or less and were published in any of the years 1999 or 2001. Display results in the increasing order of the publication year (and not the publication date) and decreasing retail price. Display the year of publication with the column
titled Publication Year.*/

SELECT BOOK_TITLE AS "BOOK TITLE",BOOK_RETAIL AS "RETAIL PRICE",EXTRACT(YEAR FROM BOOK_PUBDATE) AS "Publication Year"
FROM BOOK
WHERE BOOK_RETAIL <= 30
AND  (EXTRACT(YEAR FROM BOOK_PUBDATE) = 1999 OR EXTRACT(YEAR FROM BOOK_PUBDATE) = 2001) 
ORDER BY  'RETAIL PRICE' DESC ,'Publication Year' ASC;

/*Write a query that lists both customer and author details (only their ids, first and last names). Provide suitable headings for the merged list.*/

SELECT DISTINCT(C.CUST_NUM) AS "Customer ID",
              C.CUST_FNAME ||' '||C.CUST_LNAME AS "Customer Name",
              A.BA_AUTHORID AS "Author ID",
              N.AUTHOR_FNAME||' '||N.AUTHOR_LNAME AS "Author Name"
FROM CUSTOMER C, BOOKORDER O,BOOKORDERITEM I,BOOKAUTHOR A,AUTHOR N
WHERE C.CUST_NUM=O.BO_CUSTNUM
AND O.BO_ORDERNUM=I.BOI_ORDERNUM
AND I.BOI_ISBN=A.BA_ISBN
AND A.BA_AUTHORID=N.AUTHOR_ID;

/*Write a query that will list all the publishers, their details (name, etc.) and total number of published books. Display your output in the decreasing order of total number of publications.*/

SELECT P.PUB_ID AS "ID",
              P.PUB_NAME AS "PUBLISHER NAME",
              P.PUB_CONTACT AS "CONTACT NAME",
              P.PUB_PHONE AS "PHONE NO",
              COUNT(P.PUB_ID) AS "BOOKS PUBLISHED"
FROM PUBLISHER P,BOOK B
WHERE P.PUB_ID=B.BOOK_PUBID
GROUP BY P.PUB_ID,P.PUB_NAME,P.PUB_CONTACT,P.PUB_PHONE
ORDER BY P.PUB_ID ASC;

/*Write a query that will display the states with more than one customer. Display the state with maximum customers first.*/
SELECT C.CUST_STATE AS "STATE",COUNT(C.CUST_NUM) AS "NUMBER OF CUSTOMERS"
FROM CUSTOMER C
GROUP BY C.CUST_STATE
HAVING COUNT(C.CUST_NUM) >1
ORDER BY COUNT(C.CUST_NUM) DESC ;

/*Write a query that will list the publisher(s) with the maximum number of published books. If there is more than one publisher (e.g. 2 publishers) with maximum publications, your query should and list all (i.e. both if 2).*/

SELECT P.PUB_ID ,P.PUB_NAME,P.PUB_CONTACT,P.PUB_PHONE,COUNT(P.PUB_ID) AS "BOOK PUBLICATIONS"
FROM PUBLISHER P,BOOK B
WHERE P.PUB_ID=B.BOOK_PUBID 
GROUP BY P.PUB_ID,P.PUB_NAME,P.PUB_CONTACT,P.PUB_PHONE
HAVING P.PUB_ID=(SELECT MAX(COUNT(P.PUB_ID))
FROM PUBLISHER P,BOOK B WHERE P.PUB_ID=B.BOOK_PUBID
GROUP BY P.PUB_ID);

/*Write a query that will list the customer(s) who had ordered maximum number of items (two copies of the same book will be counted as two items). Again, like g) there can be more than one customer.*/

SELECT C.CUST_NUM AS "CUSTOMER ID",C.CUST_FNAME||' '||C.CUST_LNAME AS "NAME",SUM(I.BOI_QTY) AS "MAX BOOK QUANTITY PURCHASED"
FROM  BOOKORDER O,BOOKORDERITEM I,CUSTOMER C
WHERE O.BO_ORDERNUM=I.BOI_ORDERNUM
AND C.CUST_NUM=O.BO_CUSTNUM
GROUP BY C.CUST_NUM,C.CUST_NUM,C.CUST_FNAME||' '||C.CUST_LNAME
HAVING SUM(I.BOI_QTY)=(SELECT MAX(SUM(I.BOI_QTY))
FROM  BOOKORDER O,BOOKORDERITEM I,CUSTOMER C
WHERE O.BO_ORDERNUM=I.BOI_ORDERNUM
AND C.CUST_NUM=O.BO_CUSTNUM
GROUP BY C.CUST_NUM,C.CUST_FNAME,C.CUST_LNAME);

/*Write a query that will display the customer(s) that referred maximum number of customers. Again, like g) there can be more than one customer.*/

SELECT C.CUST_REFERRED AS "CUSTOMER ID REFERRED",COUNT(C.CUST_REFERRED) AS "MAX REFERRED"
FROM CUSTOMER C
WHERE C.CUST_REFERRED IS NOT NULL
GROUP BY C.CUST_REFERRED
HAVING COUNT(C.CUST_REFERRED)=(SELECT MAX(COUNT(C.CUST_REFERRED))
FROM CUSTOMER C
WHERE C.CUST_REFERRED IS NOT NULL
GROUP BY C.CUST_REFERRED);

/*Write a query to list all the books that have multiple authors. Also, display the number of authors who wrote the book.*/

SELECT A.BA_ISBN AS "BOOK ISBN",B.BOOK_TITLE AS "BOOK NAME",COUNT(A.BA_AUTHORID) AS "NUMBER OF AUTHORS" 
FROM BOOKAUTHOR A,BOOK B
WHERE A.BA_ISBN=B.BOOK_ISBN
GROUP BY A.BA_ISBN,B.BOOK_TITLE
HAVING COUNT(A.BA_AUTHORID)>1;

/*PART B*/
/*Rule- If a customer has bought more than or equal to the price of $100, they are eligible for a free shipping cost i.e no courier fees applicable*/

DROP TABLE BOOK_ORDER_PRICE CASCADE CONSTRAINTS;
CREATE TABLE BOOK_ORDER_PRICE AS
                             SELECT B.BOI_ORDERNUM,B.BOI_ISBN,B.BOI_QTY,A.BOOK_RETAIL,B.BOI_QTY*A.BOOK_RETAIL  AS "TOTAL"
                             FROM BOOKORDERITEM B,BOOK A
                             WHERE B.BOI_ISBN=A.BOOK_ISBN
                             GROUP BY  B.BOI_ORDERNUM,B.BOI_ISBN, B.BOI_QTY, A.BOOK_RETAIL,B.BOI_QTY*A.BOOK_RETAIL
                             ORDER BY B.BOI_ORDERNUM ASC;
                             
  SELECT * FROM BOOK_ORDER_PRICE;
  
  DROP TABLE BOOKORDER_TOTAL_AMT CASCADE CONSTRAINTS;
  CREATE TABLE BOOKORDER_TOTAL_AMT AS
                              SELECT  B.BO_ORDERNUM,B.BO_CUSTNUM,B.BO_ORDERDATE,B.BO_SHIPDATE,B.BO_SHIPSTREET,B.BO_SHIPCITY,B.BO_SHIPSTATE,SUM(O.BOI_QTY) AS "BO_QTY",SUM(O.TOTAL) AS "BO_AMT"
                              FROM BOOKORDER B,BOOK_ORDER_PRICE O
                              WHERE B.BO_ORDERNUM=O.BOI_ORDERNUM
                              GROUP BY B.BO_ORDERNUM,B.BO_CUSTNUM,B.BO_ORDERDATE,B.BO_SHIPDATE,B.BO_SHIPSTREET,B.BO_SHIPCITY,B.BO_SHIPSTATE
                              ORDER BY B.BO_ORDERNUM ASC;
                 
 ALTER TABLE BOOKORDER_TOTAL_AMT
            ADD ( BOOK_FREE_SHIP varchar2(3) DEFAULT 'NO');
  
  SELECT
      *
  FROM  BOOKORDER_TOTAL_AMT;
  
         
CREATE OR REPLACE TRIGGER FREE_SHIPPING_ORDER
AFTER INSERT OR UPDATE OF BO_AMT ON BOOKORDER_TOTAL_AMT
BEGIN
        UPDATE BOOKORDER_TOTAL_AMT
                SET BOOK_FREE_SHIP = 'YES'
                    WHERE BO_AMT  >= 100.0;
END;
/

SELECT *
  FROM  BOOKORDER_TOTAL_AMT
  WHERE BO_ORDERNUM= 1001;
        

UPDATE  BOOK_ORDER_PRICE
SET BOI_QTY=3,TOTAL=3*BOOK_RETAIL
WHERE BOI_ORDERNUM=1001
AND BOI_ISBN='2491748320';

SELECT
      *
  FROM  BOOK_ORDER_PRICE;

SELECT
      *
  FROM  BOOKORDER_TOTAL_AMT;

UPDATE  BOOKORDER_TOTAL_AMT
SET BO_QTY=(SELECT SUM(O.BOI_QTY)
                        FROM BOOKORDER_TOTAL_AMT B,BOOK_ORDER_PRICE O
                        WHERE B.BO_ORDERNUM=O.BOI_ORDERNUM
                        AND  BO_ORDERNUM=1001
                        GROUP BY B.BO_ORDERNUM),
         BO_AMT=(SELECT SUM(O.TOTAL)
                         FROM BOOKORDER_TOTAL_AMT B,BOOK_ORDER_PRICE O
                         WHERE B.BO_ORDERNUM=O.BOI_ORDERNUM
                         AND  BO_ORDERNUM=1001
                         GROUP BY B.BO_ORDERNUM)               
WHERE BO_ORDERNUM=1001;


SELECT
      *
  FROM  BOOKORDER_TOTAL_AMT
  WHERE BO_ORDERNUM= 1001;
  
 /* 




