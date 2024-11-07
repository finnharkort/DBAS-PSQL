INSERT INTO users (userID, fullName) VALUES (1, 'Anna Anderson');
INSERT INTO users (userID, fullName) VALUES (2, 'Bosse Bolinder');
INSERT INTO users (userID, fullName) VALUES (3, 'Carl Carlsson');
INSERT INTO users (userID, fullName) VALUES (4, 'David Didriksson');
INSERT INTO users (userID, fullName) VALUES (5, 'Eva Erlandsson');
INSERT INTO users (userID, fullName) VALUES (6, 'Fredrik Friskberg');

INSERT INTO friendship (userID1, userID2) VALUES (1,2);
INSERT INTO friendship (userID1, userID2) VALUES (1,3);
INSERT INTO friendship (userID1, userID2) VALUES (1,6);
INSERT INTO friendship (userID1, userID2) VALUES (3,5);
INSERT INTO friendship (userID1, userID2) VALUES (4,5);
INSERT INTO friendship (userID1, userID2) VALUES (5,6);

INSERT INTO post(postID, userID, title, date, place) VALUES (1, 3, 'På stranden :) Vad gör ni?', '2024-06-24', 'Tofta Beach');
INSERT INTO videopost(postID, videoURL, codec) VALUES (1, 'https://vimeo.com/123456789', 'HEVC');

INSERT INTO post(postID, userID, title, date, place) VALUES (2, 1, 'Thoughts on the election', '2024-08-01', NULL);
INSERT INTO textpost(postID, textContent) VALUES (2, 'What are your thoughts on the election in America? I feel torn.');

INSERT INTO post(postID, userID, title, date, place) VALUES (3, 6, 'Pluggar...', '2024-10-15', 'D-Huset');
INSERT INTO imagePost(postID, imageURL, filter) VALUES (3, 'https://i.imgur.com/Tv8MzJk.jpg', NULL);

INSERT INTO posttag(postID, tag) VALUES (1, 'social');
INSERT INTO posttag(postID, tag) VALUES (1, 'question');
INSERT INTO posttag(postID, tag) VALUES (3, 'studying');

INSERT INTO events(eventID, userID, title, place, startDate, endDate) VALUES (1, 1, 'Tentapub', 'Nymble', '2024-10-20', '2024-10-21');

INSERT INTO attendee(eventID, userID) VALUES (1,1);
INSERT INTO attendee(eventID, userID) VALUES (1,2);
INSERT INTO attendee(eventID, userID) VALUES (1,3);
INSERT INTO attendee(eventID, userID) VALUES (1,6);

INSERT INTO subscription(subscriptionID, userID, dateOfPayment, paymentMethod) VALUES (1,1,'2024-10-03','Klarna');
INSERT INTO subscription(subscriptionID, userID, dateOfPayment, paymentMethod) VALUES (2,2,'2024-10-07','Swish');
INSERT INTO subscription(subscriptionID, userID, dateOfPayment, paymentMethod) VALUES (3,3,'2024-10-01','Card');
INSERT INTO subscription(subscriptionID, userID, dateOfPayment, paymentMethod) VALUES (4,4,'2024-10-20','Swish');
INSERT INTO subscription(subscriptionID, userID, dateOfPayment, paymentMethod) VALUES (5,5,'2024-10-19','Bitcoin');
INSERT INTO subscription(subscriptionID, userID, dateOfPayment, paymentMethod) VALUES (6,6,'2024-10-27','Klarna');