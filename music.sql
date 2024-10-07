use db;

CREATE TABLE employee (
    employee_id int,
    last_name varchar(255),
    first_name varchar(255),
    title varchar(100),
    reports_to int,
    levels varchar(100),
    birthdate date,
    hire_date date,
    address varchar(255),
    city varchar(100),
    state varchar(100),
    country varchar(100),
    postal_code varchar(20),
    phone varchar(50),
    fax varchar(50),
    email varchar(255)
);
BULK INSERT employee
FROM 'C:\Users\HARI\Desktop\employee.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',
    FIRSTROW = 2);

SELECT*FROM employee;



--querys
SELECT COUNT(*) FROM employee;
UPDATE employee SET email = 'newemail@example.com' WHERE employee_id = 1;
DELETE FROM employee WHERE employee_id = 101;
SELECT * FROM employee WHERE hire_date > '2016-08-14';
INSERT INTO employee (employee_id, last_name, first_name, title, hire_date, email)VALUES (5, 'Doe', 'John', 'Software Engineer', '2023-01-15', 'john.doe@example.com');
SELECT * FROM employee WHERE city = 'Edmonton';
SELECT * FROM employee WHERE title = 'General Manager';
SELECT MAX(employee_id) AS maximum FROM employee;
SELECT * FROM employee WHERE email IS NULL OR email = 'newemail@example.com';
SELECT * FROM employee ORDER BY last_name ASC;
CREATE INDEX idx_email ON employee(email);
SELECT * FROM employee WHERE birthdate < '1958-02-18';
SELECT title, COUNT(reports_to) AS reports FROM employee GROUP BY title;
SELECT * FROM employee WHERE reports_to = 6;
SELECT * FROM employee WHERE last_name LIKE 'P%';
SELECT * FROM employee WHERE state = 'AB';
UPDATE employee SET address = '123 New St, womens hostel, Arumbakkam' WHERE employee_id = 1;
SELECT AVG(employee_id) AS Average FROM employee;
SELECT * FROM employee WHERE employee_id = (SELECT MAX(employee_id) FROM employee);
SELECT * FROM employee ORDER BY hire_date DESC;
EXEC sp_rename 'employee.city', 'location', 'COLUMN';
SELECT * FROM employee WHERE phone = '+1 (780) 428-9482';
CREATE VIEW employee_titles AS Title SELECT first_name, last_name, title FROM employee;
--------------------------------------------------------------------

CREATE TABLE customer(customer_id int,first_name varchar(255),last_name varchar(255),company varchar(255),addresss varchar(255),city varchar(200),states varchar(200),country varchar(200),
postal_code varchar(100),phone varchar(100),fax varchar(100),email varchar(100),support_rep_id varchar(50));

BULK INSERT customer
FROM 'C:\Users\HARI\Desktop\customer.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

CREATE TABLE invoice(invoice_id int	,customer_id int,invoice_date date,billing_address varchar(255),billing_city varchar(200),billing_state varchar(200),billing_country varchar(200),billing_postal_code varchar(200),total varchar(255));

BULK INSERT invoice
FROM 'C:\Users\HARI\Desktop\invoice.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

CREATE TABLE invoice_line(invoice_line_id int,invoice_id int,track_id int,unit_price varchar(255),quantity int);

BULK INSERT invoice_line
FROM 'C:\Users\HARI\Desktop\invoice_line.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);


--joins
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    i.invoice_id, 
    i.invoice_date
FROM 
    customer c
INNER JOIN 
    invoice i ON c.customer_id = i.customer_id;


SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    i.invoice_id, 
    i.invoice_date
FROM 
    customer c
LEFT JOIN 
    invoice i ON c.customer_id = i.customer_id;

	SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    i.invoice_id, 
    i.invoice_date
FROM 
    customer c
RIGHT JOIN 
    invoice i ON c.customer_id = i.customer_id;

	SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    i.invoice_id, 
    i.invoice_date
FROM 
    customer c
FULL OUTER JOIN 
    invoice i ON c.customer_id = i.customer_id;

	SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    i.invoice_id
FROM 
    customer c
CROSS JOIN 
    invoice i;

	SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    il.invoice_id, 
    il.track_id, 
    il.unit_price, 
    il.quantity
FROM 
    customer c
INNER JOIN 
    invoice i ON c.customer_id = i.customer_id
INNER JOIN 
    invoice_line il ON i.invoice_id = il.invoice_id;

----------------------------------------------------------------------------------------


CREATE TABLE playlist(playlist_id int,names varchar(255));

BULK INSERT playlist
FROM 'C:\Users\HARI\Desktop\playlist.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

CREATE TABLE playlist_track(playlist_id int,track_id int);

BULK INSERT playlist_track
FROM 'C:\Users\HARI\Desktop\playlist_track.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

--query
--select
SELECT * FROM playlist;
SELECT * FROM playlist_track;
--count
SELECT COUNT(*) AS total_playlists FROM playlist;
SELECT playlist_id ,COUNT(track_id) AS total_tracks FROM playlist_track  GROUP BY playlist_id;
--joins
SELECT 
    p.names, 
    COUNT(t.track_id) AS total_tracks
FROM 
    playlist p
LEFT JOIN 
    playlist_track t ON p.playlist_id = t.playlist_id
GROUP BY 
    p.playlist_id, p.names;
--Aggregated
SELECT TOP 5
    p.names, 
    COUNT(pt.track_id) AS total_tracks
FROM 
    playlist p
INNER JOIN 
    playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY 
    p.playlist_id, p.names
ORDER BY 
    total_tracks DESC;  

--having
SELECT 
    p.names, 
    COUNT(pt.track_id) AS total_tracks
FROM 
    playlist p
INNER JOIN 
    playlist_track pt ON p.playlist_id = pt.playlist_id
GROUP BY 
    p.playlist_id, p.names
HAVING 
    COUNT(pt.track_id) > 5;  
--cross join
SELECT TOP 5
    p.names AS playlist_name, 
    pt.track_id
FROM 
    playlist p
CROSS JOIN 
    playlist_track pt;

	-----------------------------------------------------------------------------------------------
drop table artist;
CREATE TABLE artist(artist_id varchar(200),names varchar(200));
BULK INSERT artist
FROM 'C:\Users\HARI\Desktop\artist.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);
drop table album;
CREATE TABLE album(album_id int,title varchar(200),artist_id varchar(200));
BULK INSERT album
FROM 'C:\Users\HARI\Desktop\album.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

CREATE TABLE media_type(media_type_id int,named varchar(200));
BULK INSERT media_type
FROM 'C:\Users\HARI\Desktop\media_type.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

CREATE TABLE genre(genre_id varchar(200),names varchar(200));
BULK INSERT genre
FROM 'C:\Users\HARI\Desktop\genre.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);


--Total number of artists
SELECT COUNT(*) AS total_artists FROM artist;

--List all artist names
SELECT names AS artist_name
FROM artist
ORDER BY names;

--Number of albums per artist
SELECT a.names AS artist_name, COUNT(al.album_id) AS album_count
FROM artist a
JOIN album al ON a.artist_id = al.artist_id
GROUP BY a.artist_id, a.names
ORDER BY album_count DESC;

--artists with more that 5 albums
SELECT a.names AS artist_name, COUNT(al.album_id) AS album_count
FROM artist a
JOIN album al ON a.artist_id = al.artist_id
GROUP BY a.artist_id, a.names
HAVING COUNT(al.album_id) > 5
ORDER BY album_count DESC;

--Albums without an Associated Artist
SELECT al.album_id, al.title
FROM album al
LEFT JOIN artist a ON al.artist_id = a.artist_id
WHERE a.artist_id IS NULL;

--List all albums with Their artist names
SELECT al.title AS album_title, a.names AS artist_name
FROM album al
JOIN artist a ON al.artist_id = a.artist_id
ORDER BY a.names, al.title;

--most common album title
SELECT TOP 5 title, COUNT(*) AS title_count
FROM album
GROUP BY title
ORDER BY title_count DESC;








 








