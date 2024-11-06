

CREATE TABLE users(
    userID INT PRIMARY KEY,
    fullName VARCHAR(255)
);

CREATE TABLE post(
    postID INT PRIMARY KEY,
    userID INT NOT NULL,
    title VARCHAR(255),
    date DATE NOT NULL,
    place VARCHAR(255),
    tag VARCHAR(255)[],
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID)
);

CREATE TABLE textPost(
    postID INT,
    textContent VARCHAR(255) NOT NULL,
    CONSTRAINT fk_post
        FOREIGN KEY (postID)
            REFERENCES Post (postID)
);

CREATE TABLE imagePost(
    postID INT,
    imageURL VARCHAR(255) NOT NULL,
    filter VARCHAR(255)[],
    CONSTRAINT fk_post
        FOREIGN KEY (postID)
            REFERENCES Post (postID)
);

CREATE TABLE videoPost(
    postID INT,
    videoURL VARCHAR(255) NOT NULL,
    codec VARCHAR(255),
    CONSTRAINT fk_post
        FOREIGN KEY (postID)
            REFERENCES Post (postID)
);

CREATE TABLE likes(
    postID INT,
    userID INT,
    PRIMARY KEY (postID, userID),
    timestamp VARCHAR(255) NOT NULL,
    CONSTRAINT fk_post
        FOREIGN KEY (postID)
            REFERENCES Post (postID),
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID)
);

CREATE TABLE friendship(
    userID1 INT,
    userID2 INT,
    PRIMARY KEY (userID1, userID2),
    timestamp VARCHAR(255) NOT NULL,
    CONSTRAINT fk_users
        FOREIGN KEY (userID1)
            REFERENCES users (userID),
    CONSTRAINT fk_users2
        FOREIGN KEY (userID2)
            REFERENCES users (userID)
);

CREATE TABLE events(
    eventID INT PRIMARY KEY,
    userID INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    place VARCHAR(255) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID)
);

CREATE TABLE attendee(
    eventID INT,
    userID INT,
    PRIMARY KEY (eventID, userID),
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID),
    CONSTRAINT fk_event
        FOREIGN KEY (eventID)
            REFERENCES Event (eventID)
);

CREATE TABLE subscription(
    subscriptionID INT PRIMARY KEY,
    userID INT NOT NULL,
    dateOfPayment DATE NOT NULL,
    paymentMethod  VARCHAR(255) NOT NULL,
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID)
);