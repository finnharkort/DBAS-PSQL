DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS friendship;
DROP TABLE IF EXISTS attendee;
DROP TABLE IF EXISTS subscription;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS posttag;
DROP TABLE IF EXISTS textPost;
DROP TABLE IF EXISTS imagePost;
DROP TABLE IF EXISTS videoPost;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS users;


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
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID),
    CONSTRAINT postID_non_negative
        CHECK (postID >= 0)
);

CREATE TABLE postTag(
    postID INT,
    tag VARCHAR(255),
    PRIMARY KEY (postID, tag),
    CONSTRAINT fk_post      
        FOREIGN KEY (postID)
            REFERENCES post (postID),
    CONSTRAINT accepted_tag
        CHECK (tag IN ('crypto', 'studying', 'question', 'social'))
);

CREATE TABLE textPost(
    textContent TEXT NOT NULL,
    postID INT REFERENCES post(postID)
) INHERITS (post);

CREATE TABLE imagePost(
    imageURL VARCHAR(255) NOT NULL,
    filter VARCHAR(255),
    postID INT REFERENCES post(postID)
) INHERITS (post);

CREATE TABLE videoPost(
    videoURL VARCHAR(255) NOT NULL,
    codec VARCHAR(255) NOT NULL,
    postID INT REFERENCES post(postID)
) INHERITS (post);

CREATE TABLE likes(
    postID INT,
    userID INT,
    PRIMARY KEY (postID, userID),
    timestamp DATE NOT NULL,
    CONSTRAINT fk_post
        FOREIGN KEY (postID)
            REFERENCES post (postID),
    CONSTRAINT fk_users
        FOREIGN KEY (userID)
            REFERENCES users (userID)
);

CREATE TABLE friendship(
    userID1 INT,
    userID2 INT,
    PRIMARY KEY (userID1, userID2),
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
            REFERENCES users (userID),
    CONSTRAINT correct_order_dates
        CHECK (StartDate <= EndDate)
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
            REFERENCES events (eventID)
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

GRANT ALL PRIVILEGES ON TABLE attendee TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE events TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE friendship TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE imagepost TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE likes TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE post TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE subscription TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE textpost TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE users TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE videopost TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE posttag TO nikolajg;