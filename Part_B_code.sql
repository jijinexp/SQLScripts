/*Write a query that will list all the books with the price difference (between retail and cost) of $10 or more. Display your results in the decreasing order of the price difference.*/

SELECT  BOOK_TITLE AS "LIST OF BOOKS",BOOK_RETAIL-BOOK_COST AS "PRICE DIFFERENCE"
FROM BOOK 
WHERE BOOK_RETAIL-BOOK_COST>10.0
ORDER BY  'PRICE DIFFERENCE' DESC;



/*Write a query that will list books in COMPUTER category along with other details (e.g. author(s), etc.). The query should work for all the case-variations of category values (i.e. 'computer', 'Computer', etc.) in the database.*/

SELECT BOOK_ISBN,BOOK_TITLE,BOOK_CATEGORY AS "CATEGORY",CONCAT(AUTHOR_FNAME,  AUTHOR_LNAME) AS "AUTHOR NAME" 
FROM ((BOOKAUTHOR
INNER JOIN BOOK ON BA_ISBN=BOOK_ISBN)
INNER JOIN AUTHOR ON BA_AUTHORID=AUTHOR_ID)
WHERE BOOK_CATEGORY IN ( 'COMPUTER' , 'Computer');

/*Write a query that will list books that have retail price $30 or less and were published in any of the years 1999 or 2001. Display results in the increasing order of the publication year (and not the publication date) and decreasing retail price. Display the year of publication with the column
titled Publication Year.*/

SELECT BOOK_TITLE AS "BOOK TITLE",BOOK_RETAIL AS "RETAIL PRICE",EXTRACT(YEAR FROM BOOK_PUBDATE) AS "Publication Year"
FROM BOOK
WHERE BOOK_RETAIL <= 30
AND  (EXTRACT(YEAR FROM BOOK_PUBDATE) = 1999 OR EXTRACT(YEAR FROM BOOK_PUBDATE) = 2001) 
ORDER BY  'RETAIL PRICE' DESC ,'Publication Year' ASC;

/*Write a query that lists both customer and author details (only their ids, first and last names). Provide suitable headings for the merged list.

SELECT C.CUST_NUM,C.CUST_FNAME,C.CUST_LNAME,A.BA_AUTHORID
FROM CUSTOMER C, BOOKORDER I,BOOKAUTHOR A, BOOKORDERITEM O
WHERE C.CUST_NUM = I.BO_CUSTNUM 
AND A.BA_ISBN =BOI_ISBN;*/

/*Write a query that will list all the publishers, their details (name, etc.) and total number of published books. Display your output in the decreasing order of total number of publications.*/

SELECT PUB_ID,PUB_NAME,PUB_CONTACT,PUB_PHONE
FROM PUBLISHER;