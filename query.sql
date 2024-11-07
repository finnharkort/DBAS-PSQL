SELECT fullname FROM users;

SELECT * FROM friendship;

SELECT u1.fullName AS user1_name, u2.fullName AS user2_name
FROM friendship f
JOIN users u1 ON f.userID1 = u1.userID
JOIN users u2 ON f.userID2 = u2.userID;

SELECT * FROM imagePost;
SELECT * FROM videoPost;
SELECT * FROM textPost;

SELECT * FROM events;

SELECT * FROM subscription;