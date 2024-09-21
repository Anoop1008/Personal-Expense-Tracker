SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dailyexpense`
--

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `expense_id` int(20) NOT NULL,
  `user_id` varchar(15) NOT NULL,
  `expense` int(20) NOT NULL,
  `expensedate` varchar(15) NOT NULL,
  `expensecategory` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`expense_id`, `user_id`, `expense`, `expensedate`, `expensecategory`) VALUES
(101, '9', 789, '2023-08-31', 'Medicine'),
(102, '9', 3, '2023-08-31', 'Entertainment'),
(103, '9', 469, '2023-08-29', 'Clothings'),
(104, '9', 985, '2023-08-25', 'Entertainment'),
(105, '12', 3, '2023-08-31', 'Clothings'),
(106, '12', 89, '2023-08-16', 'Bills & Recharges'),
(107, '9', 3, '2023-09-06', 'Clothings'),
(108, '9', 300, '2023-07-04', 'Food'),
(109, '9', 456, '2023-09-01', 'Clothings'),
(110, '9', 3, '2023-08-28', 'Entertainment'),
(111, '9', 300, '2023-09-03', 'Clothings'),
(112, '9', 789, '2021-06-03', 'Medicine'),
(113, '9', 756, '2021-02-23', 'Entertainment'),
(114, '9', 123, '2022-09-03', 'Medicine'),
(115, '9', 256, '2021-09-07', 'Medicine'),
(116, '9', 798, '2023-09-04', 'Medicine'),
(117, '9', 45, '2023-08-28', 'Entertainment'),
(118, '9', 50, '2023-10-20', 'Medicine'),
(119, '9', 786, '2023-10-20', 'Food'),
(120, '9', 1000, '2023-10-04', 'Entertainment'),
(121, '9', 500, '2023-10-19', 'Clothings'),
(122, '9', 426, '2023-10-16', 'Household Items');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`category_id`, `category_name`) VALUES
(1, 'Medicine'),
(2, 'Food'),
(3, 'Bills & Recharges'),
(4, 'Entertainment'),
(5, 'Clothings'),
(6, 'Rent'),
(7, 'Household Items'),
(8, 'Others');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT 0  -- Added salary field
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `email`, `password`, `salary`) VALUES
(9, 'Anjalita', 'Fernandes', 'anjalita@sjec.in', 'b7161ae9080c2604adb157463312ed47', 500),
(12, 'Ebey', 'Joe Regi', 'ejr@sjec.in', '25d55ad283aa400af464c76d713c07ad', 300);

-- --------------------------------------------------------

-- Indexes for tables

ALTER TABLE `expenses`
  ADD PRIMARY KEY (`expense_id`);

ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`category_id`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

-- AUTO_INCREMENT for tables

ALTER TABLE `expenses`
  MODIFY `expense_id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

ALTER TABLE `expense_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

-- --------------------------------------------------------

-- Trigger to check salary after an expense

DELIMITER $$

CREATE TRIGGER check_salary_after_expense 
AFTER INSERT ON expenses
FOR EACH ROW
BEGIN
  DECLARE user_salary INT;
  DECLARE threshold INT DEFAULT 1000;  -- Example threshold
  
  -- Get the user's current salary
  SELECT salary INTO user_salary
  FROM users
  WHERE user_id = NEW.user_id;
  
  -- Check if the salary is below the threshold
  IF user_salary < threshold THEN
    -- Notify user by sending email (this logic is handled in the application)
    CALL notify_user_email(NEW.user_id);
  END IF;
END$$

DELIMITER ;

-- Stored Procedure for email notification

DELIMITER $$

CREATE PROCEDURE notify_user_email(IN user_id INT)
BEGIN
  DECLARE user_email VARCHAR(50);
  
  -- Get user's email
  SELECT email INTO user_email
  FROM users
  WHERE user_id = user_id;
  
  -- Email sending logic is handled in the backend application
  -- Example: send an email notification (handled outside MySQL)
END$$

DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
