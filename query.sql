SELECT fullname FROM users;

SELECT * FROM friendship;

SELECT friendship.userID1, friendship.userID2, users.name
FROM friendship
JOIN users ON friendship.userID1 = users.id, friendship.userID2 = users.id;

SELECT * FROM imagePost;
SELECT * FROM videoPost;
SELECT * FROM textPost;

SELECT * FROM events;

SELECT * FROM subscription;