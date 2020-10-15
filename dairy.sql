-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 08, 2019 at 06:37 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dairy`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertdelivery` (`id` INT, `r_f_no` INT, `r_kg` INT, `r_dt` DATETIME, `r_deliverer` TEXT)  BEGIN
	insert into delivery(id, r_f_no, r_kg, r_dt, r_deliverer) VALUES (id, r_f_no, r_kg, r_dt, r_deliverer);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `id` int(11) NOT NULL,
  `r_f_no` varchar(50) NOT NULL,
  `r_kg` float NOT NULL,
  `r_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `r_deliverer` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `delivery`
--
DELIMITER $$
CREATE TRIGGER `after_delivery_insert` AFTER INSERT ON `delivery` FOR EACH ROW BEGIN
insert into del_backup values(NEW.id, NEW.r_f_no, NEW.r_kg, New.r_dt, NEW.r_deliverer);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `del_backup`
--

CREATE TABLE `del_backup` (
  `id` int(11) NOT NULL,
  `r_f_no` varchar(50) NOT NULL,
  `r_kg` float NOT NULL,
  `r_dt` timestamp NOT NULL DEFAULT current_timestamp(),
  `r_deliverer` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `e_name` varchar(50) NOT NULL,
  `e_mail` varchar(50) DEFAULT NULL,
  `e_pass` varchar(50) NOT NULL,
  `e_role` varchar(50) DEFAULT NULL,
  `e_payroll_no` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `e_name`, `e_mail`, `e_pass`, `e_role`, `e_payroll_no`) VALUES
(126, 'lokesh', 'lokesh@example.com', '585f4e84820f6cb00c149bd5c3f22f1b', 'Manager', '1002'),
(127, 'manoj', 'manoj@example.com', '977c0156d7403e2bebba75cdf5652678', 'Manager', '1001'),
(128, 'kiran', 'kiran@example.com', '50c2472801ba5f5158b71047563521ef', 'Supervisor', '1003'),
(129, 'nandan', 'nandan@example.com', 'afc4854df8915218834926d9ab12484a', 'Clerk', '1004');

--
-- Triggers `employees`
--
DELIMITER $$
CREATE TRIGGER `login_details` AFTER INSERT ON `employees` FOR EACH ROW BEGIN
INSERT INTO login VALUES(NEW.E_MAIL,NEW.E_PASS);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `farmers`
--

CREATE TABLE `farmers` (
  `f_no` varchar(50) NOT NULL,
  `f_id` text NOT NULL,
  `f_name` varchar(50) NOT NULL,
  `f_locallity` varchar(50) DEFAULT NULL,
  `f_ac` varchar(50) DEFAULT NULL,
  `last_paid` date DEFAULT NULL,
  `f_phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `e_mail` varchar(30) NOT NULL,
  `e_pass` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`e_mail`, `e_pass`) VALUES
('kiran@example.com', '50c2472801ba5f5158b71047563521'),
('lokesh@example.com', '585f4e84820f6cb00c149bd5c3f22f'),
('manoj@example.com', '977c0156d7403e2bebba75cdf56526'),
('nandan@example.com', 'afc4854df8915218834926d9ab1248');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `p_to` varchar(50) NOT NULL,
  `p_date` date NOT NULL,
  `p_ac` bigint(20) NOT NULL,
  `p_method` varchar(30) NOT NULL,
  `p_transaction_code` int(11) NOT NULL COMMENT 'Bank or Mpesa confirmation or receipt no',
  `p_transacted_by` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings_rates`
--

CREATE TABLE `settings_rates` (
  `id` int(11) NOT NULL,
  `from` date NOT NULL,
  `to` date NOT NULL,
  `rate` float NOT NULL COMMENT 'sh per kg'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings_rates`
--

INSERT INTO `settings_rates` (`id`, `from`, `to`, `rate`) VALUES
(4, '2018-01-01', '2018-01-31', 20),
(5, '2018-03-01', '2018-03-31', 24),
(6, '2019-11-06', '2019-11-06', 50);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`id`),
  ADD KEY `r_f_no` (`r_f_no`);

--
-- Indexes for table `del_backup`
--
ALTER TABLE `del_backup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `r_f_no` (`r_f_no`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `e_name` (`e_name`),
  ADD UNIQUE KEY `e_payroll_no_2` (`e_payroll_no`),
  ADD KEY `e_payroll_no` (`e_payroll_no`);

--
-- Indexes for table `farmers`
--
ALTER TABLE `farmers`
  ADD PRIMARY KEY (`f_no`),
  ADD KEY `f_no` (`f_no`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`e_mail`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `p_to` (`p_to`),
  ADD KEY `p_transacted_by` (`p_transacted_by`);

--
-- Indexes for table `settings_rates`
--
ALTER TABLE `settings_rates`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `del_backup`
--
ALTER TABLE `del_backup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `settings_rates`
--
ALTER TABLE `settings_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`r_f_no`) REFERENCES `farmers` (`f_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `del_backup`
--
ALTER TABLE `del_backup`
  ADD CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`r_f_no`) REFERENCES `farmers` (`f_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`p_transacted_by`) REFERENCES `employees` (`e_payroll_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`p_to`) REFERENCES `farmers` (`f_no`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
