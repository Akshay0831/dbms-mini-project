CREATE DATABASE IF NOT EXISTS bookstore;
USE bookstore;

DROP TABLE IF EXISTS Shipment;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Users;

CREATE TABLE IF NOT EXISTS Users(
uId INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
email VARCHAR(30) NOT NULL UNIQUE,
password VARCHAR(50) NOT NULL,
name VARCHAR(20) NOT NULL,
phone CHAR(10) NOT NULL,
dob date);

CREATE TABLE IF NOT EXISTS Addresses(
uId INT UNSIGNED NOT NULL,
address VARCHAR(80),
pincode MEDIUMINT UNSIGNED,
FOREIGN KEY (uId) REFERENCES Users(uId) ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS Books(
bId INT UNSIGNED PRIMARY KEY,
name VARCHAR(30),
price REAL,
description TEXT,
cover BLOB,
stock INT
);

CREATE TABLE IF NOT EXISTS Genres(
bId INT UNSIGNED,
genre VARCHAR(20),
FOREIGN KEY (bId) REFERENCES Books(bId)
);

CREATE TABLE IF NOT EXISTS Authors(
bId INT UNSIGNED,
AuthorName VARCHAR(30),
PRIMARY KEY(bId, AuthorName),
FOREIGN KEY(bId) REFERENCES Books(bId)
);

CREATE TABLE IF NOT EXISTS Cart(
uId INT UNSIGNED,
bId INT UNSIGNED,
FOREIGN KEY(uId) REFERENCES Users(uId),
FOREIGN KEY(bId) REFERENCES Books(bId)
);

CREATE TABLE IF NOT EXISTS Shipment(
uId INT UNSIGNED,
bId INT UNSIGNED,
ordNo INT UNSIGNED,
Ordered DATETIME NOT NULL,
Cancelled BOOL,
PRIMARY KEY(uId, bId, ordNo),
FOREIGN KEY (uId) REFERENCES Users(uId),
FOREIGN KEY(bId) REFERENCES Books(bId)
);