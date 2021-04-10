CREATE TABLE users(
    email VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(email) VALUES
    ('Katie34@yahoo.com'), ('Tunde@gmail.com');

-- earliest_date registered
SELECT DATE_FORMAT(created_at," %b %d %Y") AS earliest_date FROM users ORDER BY created_at LIMIT 1

SELECT DATE_FORMAT(MIN(created_at),"%b %d %Y") FROM users

-- email of earliest user
SELECT email, created_at FROM users ORDER BY created_at LIMIT 1; 

-- Count of users registering in each month
SELECT DATE_FORMAT(created_at,'%M') AS month, COUNT(*) AS count FROM users GROUP BY month ORDER BY count DESC;

-- number of yahoo users
SELECT COUNT(*) FROM users WHERE email LIKE '%@yahoo.com';

-- Total number of users for each email host

SELECT provider,COUNT(provider) FROM (SELECT CASE
WHEN email LIKE '%@gmail.com' THEN 'gmail'
WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
ELSE 'other'
END AS provider FROM users) AS temp_table GROUP BY provider;


SELECT CASE
WHEN email LIKE '%@gmail.com' THEN 'gmail'
WHEN email LIKE '%@yahoo.com' THEN 'yahoo'
WHEN email LIKE '%@hotmail.com' THEN 'hotmail'
ELSE 'other',
COUNT(*) AS count
END AS provider
FROM users
GROUP BY provider

