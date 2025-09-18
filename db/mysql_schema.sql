CREATE DATABASE IF NOT EXISTS ertdb;
USE ertdb;

CREATE TABLE IF NOT EXISTS robot (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL UNIQUE,
  model VARCHAR(255) NOT NULL,
  firmware_version VARCHAR(255),
  active BIT,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS student (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  grade_level VARCHAR(255),
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS course (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  code VARCHAR(255) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  capacity INT,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS training_session (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  course_id BIGINT NOT NULL,
  robot_id BIGINT NOT NULL,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  location VARCHAR(255),
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  CONSTRAINT fk_ts_course FOREIGN KEY (course_id) REFERENCES course(id),
  CONSTRAINT fk_ts_robot FOREIGN KEY (robot_id) REFERENCES robot(id)
);

CREATE TABLE IF NOT EXISTS enrollment (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  student_id BIGINT NOT NULL,
  course_id BIGINT NOT NULL,
  created_at TIMESTAMP NULL,
  updated_at TIMESTAMP NULL,
  CONSTRAINT fk_enr_student FOREIGN KEY (student_id) REFERENCES student(id),
  CONSTRAINT fk_enr_course FOREIGN KEY (course_id) REFERENCES course(id),
  CONSTRAINT uq_enr UNIQUE (student_id, course_id)
);
