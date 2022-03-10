-- phpMyAdmin SQL Dump
-- version 5.1.3-2.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 23, 2022 at 11:31 PM
-- Server version: 10.6.5-MariaDB-log
-- PHP Version: 7.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_titusda`
--

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `classId` int(11) NOT NULL,
  `teacherId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`classId`, `teacherId`, `name`) VALUES
(1, 2, 'Physics'),
(2, 3, 'Geometry'),
(3, 1, 'Spanish'),
(4, NULL, 'History');

-- --------------------------------------------------------

--
-- Table structure for table `classesStudentsDetails`
--

DROP TABLE IF EXISTS `classesStudentsDetails`;
CREATE TABLE `classesStudentsDetails` (
  `studentId` int(11) NOT NULL,
  `classId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `classesStudentsDetails`
--

INSERT INTO `classesStudentsDetails` (`studentId`, `classId`) VALUES
(1, 3),
(3, 1),
(3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `reviewId` int(11) NOT NULL,
  `reviewYear` int(11) NOT NULL,
  `reviewTerm` varchar(255) NOT NULL,
  `studentId` int(11) DEFAULT NULL,
  `teacherId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`reviewId`, `reviewYear`, `reviewTerm`, `studentId`, `teacherId`) VALUES
(1, 2021, 'Summer', 2, 2),
(2, 2018, 'Winter', 1, 3),
(3, 2020, 'Fall', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `studentId` int(11) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentId`, `firstName`, `lastName`, `email`) VALUES
(1, 'Max', 'Finger', 'fingerm@schoolie.com'),
(2, 'Sarah', 'Forearm', 'forearms@schoolie.com'),
(3, 'Audrey', 'Elbow', 'elbowa@schoolie.com');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers` (
  `teacherId` int(11) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacherId`, `firstName`, `lastName`, `email`) VALUES
(1, 'Amy', 'Foot', 'foota@turner.com'),
(2, 'James', 'Shin', 'shinj@crocket.com'),
(3, 'Parker', 'Kneecap', 'kneecapp@bueller.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`classId`),
  ADD UNIQUE KEY `classId` (`classId`),
  ADD KEY `fkTeacher` (`teacherId`);

--
-- Indexes for table `classesStudentsDetails`
--
ALTER TABLE `classesStudentsDetails`
  ADD PRIMARY KEY (`studentId`,`classId`),
  ADD KEY `fkClasses` (`classId`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`reviewId`),
  ADD UNIQUE KEY `reviewId` (`reviewId`),
  ADD KEY `fkStudentReview` (`studentId`),
  ADD KEY `fkTeacherReview` (`teacherId`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentId`),
  ADD UNIQUE KEY `studentId` (`studentId`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacherId`),
  ADD UNIQUE KEY `teacherId` (`teacherId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `classId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `reviewId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `studentId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacherId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `fkTeacher` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`teacherId`) ON DELETE CASCADE;

--
-- Constraints for table `classesStudentsDetails`
--
ALTER TABLE `classesStudentsDetails`
  ADD CONSTRAINT `fkClasses` FOREIGN KEY (`classId`) REFERENCES `classes` (`classId`) ON DELETE CASCADE,
  ADD CONSTRAINT `fkStudent` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fkStudentReview` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE,
  ADD CONSTRAINT `fkTeacherReview` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`teacherId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
