DROP TABLE smuser;
DROP TABLE textPost;

CREATE TABLE Post(
    postID INT NOT NULL PRIMARY KEY,
    userID INT NOT NULL,
    title VARCHAR(255),
    date Date NOT NULL,
    place VARCHAR(255),
    tag VARCHAR(255)[]
);

CREATE TABLE TextPost(
    postID INT NOT NULL REFERENCES,
    textContent VARCHAR(255) NOT NULL
);

CREATE TABLE ImagePost(
    postID INT NOT NULL REFERENCES,
    imageURL VARCHAR(255) NOT NULL,
    filter VARCHAR(255)[]
);

CREATE TABLE VideoPost(
    postID INT NOT NULL REFERENCES,
    videoURL VARCHAR(255) NOT NULL,
    codec VARCHAR(255)
);
