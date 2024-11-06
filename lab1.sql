DROP TABLE post;
DROP TABLE sm_user;
CREATE TABLE textPost(
    postID INT NOT NULL PRIMARY KEY,
    textContent VARCHAR(255) NOT NULL
);
