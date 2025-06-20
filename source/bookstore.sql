-- Active: 1750378319760@@127.0.0.1@3306@library_project
CREATE DATABASE library_project;
USE library_project;

CREATE TABLE books (
  id INTEGER AUTO_INCREMENT,
  isbn VARCHAR(50) NOT NULL UNIQUE,
  type VARCHAR(20) NOT NULL,
  price INTEGER CHECK(price > 0),
  PRIMARY KEY (id)
); 

INSERT INTO books (isbn, type, price)
VALUES (?, ?, ?);

