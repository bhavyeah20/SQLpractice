DROP DATABASE ig_clone;
CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE users(
	id INT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photos(
	id INT PRIMARY KEY AUTO_INCREMENT,
	image_url VARCHAR(255) NOT NULL,
	user_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE comments(
	id INT PRIMARY KEY AUTO_INCREMENT,
	comment_text VARCHAR(100) NOT NULL,
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (photo_id) REFERENCES photos(id)
);

CREATE TABLE likes(
	user_id INT NOT NULL,
	photo_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (photo_id) REFERENCES photos(id),
	PRIMARY KEY(user_id, photo_id)
);

CREATE TABLE follows(
	follower_id INT NOT NULL,
	followee_id INT NOT NULL,
	created_at TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (follower_id) REFERENCES users(id),
	FOREIGN KEY (followee_id) REFERENCES users(id),
	PRIMARY KEY (follower_id, followee_id)
);

CREATE TABLE tags(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	tag_name VARCHAR(255) UNIQUE,
	created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
	photo_id INT NOT NULL,
	tag_id INT NOT NULL,
	FOREIGN KEY (photo_id) REFERENCES photos(id),
	FOREIGN KEY (tag_id) REFERENCES tags(id),
	PRIMARY KEY (photo_id, tag_id)
);

-- Reward 5 oldest users
SELECT * FROM users ORDER BY created_at LIMIT 5;

-- What day of week do most users register on 
SELECT DAYNAME(created_at), COUNT(*) FROM users GROUP BY DAYNAME(created_at) ORDER BY COUNT(*);

-- Target inactive users for an ad campaign
SELECT users.username, photos.user_id FROM users
LEFT JOIN photos
ON users.id = photos.user_id
WHERE photos.user_id IS NULL;

-- Who got most likes on a single photo

--correct + subquery
SELECT photo_id,COUNT(photo_id) FROM likes GROUP BY photo_id ORDER BY COUNT(photo_id); --145

SELECT username, photos.id FROM users
JOIN photos
ON users.id = photos.user_id
WHERE photos.id = (SELECT photo_id FROM likes GROUP BY photo_id ORDER BY COUNT(photo_id) DESC LIMIT 1);

--PHOTOS AND LIKES THEN MATCH USER
SELECT username, photos.user_id AS authorId, photos.id AS photoId, COUNT(*) AS likes  FROM photos
JOIN likes
ON likes.photo_id = photos.id
JOIN users
ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY COUNT(*)
LIMIT 10;

-- How many times does an avg user post

SELECT AVG(pic) AS avg FROM 
(
SELECT IF(photos.id IS NULL,0,COUNT(*)) AS pic FROM users
LEFT JOIN photos
ON users.id = photos.user_id
GROUP BY users.id
) AS temp_table;

 -- Or simply 
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);
-- Or
SELECT
   COUNT(DISTINCT photos.id) / COUNT( DISTINCT users.id) AS avg_posts_per_user
FROM users
LEFT JOIN photos
ON users.id = photos.user_id;

-- Top 5 most commonly used hashtags

SELECT tags.tag_name, COUNT(*) FROM photo_tags
JOIN tags
ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY COUNT(*) DESC LIMIT 5;

-- Find bots who have liked every single photo on the site


SELECT username, COUNT(*) AS num_likes FROM users
JOIN likes
ON users.id = likes.user_id
GROUP BY users.id
HAVING num_likes = (SELECT COUNT(*) FROM photos);

-- or 

SELECT name FROM (
SELECT users.username as name, COUNT(*) as num_likes FROM users
JOIN likes
ON users.id = likes.user_id
GROUP BY users.id
) AS temp_table WHERE num_likes = (SELECT COUNT(*) FROM photos);


