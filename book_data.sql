CREATE TABLE books 
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);



SELECT title,author_fname,author_lname, CONCAT_WS('///',title,author_fname,author_lname) AS Jhakaas FROM books;

SELECT CONCAT(author_fname,' ',author_lname) AS 'Full Name' FROM books;

SELECT CONCAT_WS(' ',author_fname,author_lname) AS 'Full Name' FROM books;

SELECT CONCAT_WS('...',SUBSTR(title,1,10),author_fname,author_lname) FROM books;

SELECT SUBSTR(REPLACE(title,'e','3'),1,10) FROM books;

SELECT CONCAT_WS(' ',author_lname,'is',CHAR_LENGTH(author_lname),'charecters long') AS 
'Weird line' FROM books;

SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'));

I-like-cats

SELECT REPLACE(CONCAT('I',' ','like',' ','cats'),' ','-');

SELECT REPLACE(title,' ','->') AS title FROM books;

SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

SELECT UPPER(CONCAT(author_fname,' ',author_lname)) AS 'full name in caps' FROM books;

SELECT CONCAT(title,' was released in ',released_year) AS blurb FROM books;

SELECT title,CHAR_LENGTH(title) AS 'charector count' FROM books;

SELECT CONCAT(SUBSTR(title,1,10),'...') AS 'short title', CONCAT(author_lname,',',author_fname) AS 'author', CONCAT(stock_quantity,' in stock') AS quanity FROM books;

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);




SELECT DISTINCT CONCAT(author_fname,' ',author_lname) FROM books;

SELECT author_fname, author_lname FROM books ORDER BY author_lname;

SELECT author_fname, author_lname FROM books ORDER BY 2 DESC,1 DESC;

SELECT title, released_year FROM books ORDER BY released_year LIMIT 3;

SELECT title, released_year FROM books ORDER BY released_year LIMIT 2, 3;

SELECT title FROM books WHERE title LIKE '%stories%';

SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

SELECT CONCAT(title,' - ',released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;

SELECT title,author_lname FROM books WHERE author_lname LIKE '% %';

SELECT title, released_year, stock_quantity FROM books ORDER BY 3,1 LIMIT 3;

SELECT title, author_lname FROM books ORDER BY 2,1 ;




SELECT UPPER(CONCAT('My favorite author is ',author_fname,' ',author_lname,'!')) AS yell FROM books ORDER BY author_lname;

SELECT * FROM books 
WHERE pages = (SELECT MIN(pages) FROM books);

SELECT CONCAT(author_fname,' ',author_lname) AS Author,
	   SUM(pages) AS pageCount
FROM books
GROUP BY author_lname, author_fname;

SELECT COUNT(title) FROM books;

SELECT released_year, COUNT(title) FROM books GROUP BY released_year;

SELECT SUM(stock_quantity) FROM books;

SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_lname,author_fname;

SELECT MAX(pages), author_lname, author_fname FROM books GROUP BY author_lname,author_fname;
	or
SELECT author_lname,author_fname FROM books ORDER BY pages DESC LIMIT 1;
	or 
SELECT author_lname, author_fname FROM books WHERE pages = (SELECT MAX(pages) FROM books);

SELECT released_year AS year, COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP by 1 ORDER BY 1;



CREATE TABLE deci(dec DECIMAL(5,2), f FLOAT, do DOUBLE);

CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');
 
SELECT * FROM people;

January 2nd at 3:15

SELECT DATE_FORMAT(NOW(),'%M %D at %H:%i');


SELECT title, released_year, 
CASE 
WHEN released_year >= 2000
THEN 'Modern Lit'
ELSE 'Old Lit'
END AS GENRE
FROM books;


SELECT title, stock_quantity, 
CASE 
WHEN stock_quantity BETWEEN 0 AND 50
THEN '*'
WHEN stock_quantity BETWEEN 51 AND 100
THEN '**'
ELSE '***'
END AS Stock
FROM books;

-- 0
-- 0
-- 1

SELECT title, author_lname, CONCAT(count(*),' ', (
	SELECT CASE 
 WHEN count(*) = 1 THEN 'book'
 ELSE 'books'
 END
 FROM books;
);
) AS 'Count' FROM books GROUP BY author_lname,author_fname;


-- 0
-- 1
-- 1

SELECT * FROM books WHERE released_year < 1980;

SELECT * FROM books WHERE author_lname = 'eggers' OR author_lname = 'chabon';

SELECT * FROM books WHERE author_lname IN ('EGGERS','chabon');

SELECT * FROM books WHERE author_lname = 'Lahiri' AND released_year > 2000;

SELECT * FROM books WHERE pages BETWEEN 100 AND 200;

SELECT * FROM books WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

SELECT * FROM books WHERE SUBSTR(author_lname,1,1) IN ('S','C');

SELECT title, author_lname, 
CASE 
WHEN title LIKE '%stories%' THEN 'Short Stoties'
WHEN title IN ('Just Kids','A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
ELSE 'Novel'
END
AS 'Type'
FROM books;



-- this works
SELECT title, author_lname, CASE WHEN COUNT(*) = 1 THEN CONCAT(COUNT(*),' book') ELSE CONCAT(COUNT(*),' books') END AS 'Count' FROM books GROUP BY author_lname,author_fname ORDER BY author_lname;
-- this doesnt
SELECT title, author_lname, CONCAT(COUNT(*),' ',CASE WHEN COUNT(*) = 1 THEN 'book' ELSE 'books' END) FROM books GROUP BY author_lname, author_fname ORDER BY author_lname;


