DROP TABLE smuser;
DROP TABLE textPost;

CREATE TABLE sm_user(
    userID INT PRIMARY KEY,
    fullName VARCHAR(255)
);

CREATE TABLE Post(
    postID INT PRIMARY KEY,
    userID INT NOT NULL,
    title VARCHAR(255),
    date DATE NOT NULL,
    place VARCHAR(255),
    tag VARCHAR(255)[],
    CONSTRAINT fk_sm_user
        FOREIGN KEY (userID)
            REFERENCES sm_user (userID)
);

CREATE TABLE TextPost(
    postID INT PRIMARY KEY,
    textContent VARCHAR(255) NOT NULL
);

CREATE TABLE ImagePost(
    postID INT PRIMARY KEY,
    imageURL VARCHAR(255) NOT NULL,
    filter VARCHAR(255)[]
);

CREATE TABLE VideoPost(
    postID INT PRIMARY KEY,
    videoURL VARCHAR(255) NOT NULL,
    codec VARCHAR(255)
);
