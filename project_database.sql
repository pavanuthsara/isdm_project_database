/* Plan Table */
CREATE TABLE plan (
	planId VARCHAR(10) NOT NULL,
    planName VARCHAR(25) NOT NULL,
    planFee FLOAT NOT NULL,
    planDescription VARCHAR(150) NOT NULL,
    duration INT NOT NULL,
    
    CONSTRAINT plan_pk PRIMARY KEY(planId)
);

/* Manager Table */
CREATE TABLE manager (
	managerId VARCHAR(10) NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(40) CHECK (email LIKE '%_@_%._%') NOT NULL,
    password VARCHAR(15) NOT NULL,
    dob DATE NOT NULL,
    address VARCHAR(150) NOT NULL,

	CONSTRAINT manager_pk PRIMARY KEY(managerId)
);

/* Report Table */
CREATE TABLE Report (
    reportId VARCHAR(6) NOT NULL,
    reportDate DATE NOT NULL,
    type VARCHAR(150) NOT NULL,
    managerId VARCHAR(6) NOT NULL,

	CONSTRAINT report_pk PRIMARY KEY(reportId),
	CONSTRAINT report_fk FOREIGN KEY (managerId) REFERENCES manager(managerId)
);

/* Admin Table */
CREATE TABLE admin(
	adminId VARCHAR(6) NOT NULL, 
	name VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL,
	password VARCHAR(30) NOT NULL,
	dob DATE NOT NULL,
	address VARCHAR(150) NOT NULL,
	managerId VARCHAR(6) NOT NULL,

	CONSTRAINT admin_pk PRIMARY KEY(adminId),
	CONSTRAINT admin_fk FOREIGN KEY (managerId) REFERENCES manager(managerId)
);

/* Admin Contact Table */
CREATE TABLE adminContact(
	adminId VARCHAR(6) NOT NULL,
	phoneNo VARCHAR(10) NOT NULL,

	CONSTRAINT adminContact_pk PRIMARY KEY(adminId, phoneNo),
	CONSTRAINT adminContact_fk FOREIGN KEY(adminId) REFERENCES admin(adminId)
);

/* Employee Table */
CREATE TABLE employee(
	employeeID VARCHAR(10) NOT NULL,
	name VARCHAR(20) NOT NULL,
	email VARCHAR(100) NOT NULL,
	password VARCHAR(20) NOT NULL,
	dob DATE NOT NULL,
	address VARCHAR(250) NOT NULL,
	nic VARCHAR(20),
	adminId VARCHAR(10),

	CONSTRAINT employee_pk PRIMARY KEY (employeeId),
	CONSTRAINT employee_fk FOREIGN KEY (adminId) REFERENCES admin(adminId)
);

/* Employee Contact Table */
CREATE TABLE employeeContact(
	employeeId VARCHAR(10) NOT NULL,
	phoneNo CHAR(10)  NOT NULL,

	CONSTRAINT employeeContact_pk PRIMARY KEY(employeeId, phoneNo),
	CONSTRAINT employeeContact_fk FOREIGN KEY(employeeId) REFERENCES employee(employeeId)
);

/* User Table */
CREATE Table user (
	userId VARCHAR(6) NOT NULL, 
	firstName VARCHAR(30)  NOT NULL,
    lastNAME VARCHAR(30)  NOT NULL, 
    dob DATE  NOT NULL,
    email VARCHAR(150)  NOT NULL,
    password VARCHAR(35)  NOT NULL,
    gender VARCHAR(10)  NOT NULL,
    planId VARCHAR(6) NOT NULL,
    adminId VARCHAR(6) NOT NULL,
    houseNo VARCHAR(50) NOT NULL ,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    postalCode VARCHAR(20) NOT NULL,

	CONSTRAINT user_pk PRIMARY KEY(userId),
	CONSTRAINT user_fk1 FOREIGN KEY(planId) REFERENCES plan(planId),
	CONSTRAINT user_fk2 FOREIGN KEY(adminId) REFERENCES admin(adminId)
);

/* User Contact Table */
CREATE Table userContact(
	userId VARCHAR(6) NOT NULL,
	phoneNo VARCHAR(10) NOT NULL,

	CONSTRAINT userContact_pk PRIMARY KEY(userId, phoneNo),
    CONSTRAINT userContact_fk FOREIGN KEY (userId) REFERENCES user(userId)
);

/* Annual Fee Table */
CREATE Table annualFee(
	feeId VARCHAR(6) NOT NULL,
	userId VARCHAR(6) NOT NULL,
    amount FLOAT NOT NULL,
    paymentDate DATE NOT NULL,
    expireDate DATE NOT NULL,

	CONSTRAINT annualFee_pk PRIMARY KEY(feeId),
    CONSTRAINT annualFee_fk FOREIGN KEY (userId) REFERENCES user(userId)
);

/* Plan Update Table */
CREATE TABLE planUpdate (
	planId	VARCHAR(6) NOT NULL,
	managerId VARCHAR(6) NOT NULL,
	date DATE NOT NULL,

	CONSTRAINT planUpdate_pk PRIMARY KEY(planId, managerId),
	CONSTRAINT planUpdate_fk1 FOREIGN KEY (planId) REFERENCES plan(planId),
	CONSTRAINT planUpdate_fk2 FOREIGN KEY (managerId) REFERENCES manager(managerId)
);

/* Complaint Table */
CREATE TABLE complaint (
	complaintId VARCHAR(6) NOT NULL,
	userId VARCHAR(6) NOT NULL,
	date VARCHAR(15) NOT NULL,
	complaintType VARCHAR(50) NOT NULL,
	status VARCHAR(20) NOT NULL,

	CONSTRAINT complaint_pk PRIMARY KEY(complaintId),
	CONSTRAINT complaint_fk FOREIGN KEY (userId) REFERENCES user(userId)
);

/* Dependent Table */
CREATE TABLE Dependent (
	userId VARCHAR(10) NOT NULL,
	name VARCHAR(50) NOT NULL,
	gender VARCHAR(6) NOT NULL,
	dob date NOT NULL,

	CONSTRAINT dependent_pk PRIMARY KEY(userId, name),
	CONSTRAINT dependent_fk FOREIGN KEY (userId) REFERENCES user(userId)
);

/* Claim Table */
CREATE TABLE Claim(
	claimId VARCHAR(10)  NOT NULL,
	userId VARCHAR(10)  NOT NULL,
	amount FLOAT  NOT NULL,
	claimDescription VARCHAR(250)  NOT NULL,
	date DATE  NOT NULL,
	status VARCHAR(50)  NOT NULL,
	adminId VARCHAR(10)  NOT NULL,

	CONSTRAINT claim_pk PRIMARY KEY(claimId),
	CONSTRAINT claim_fk1 FOREIGN KEY(userId) REFERENCES user(userId),
	CONSTRAINT claim_fk2 FOREIGN KEY(adminId) REFERENCES admin(adminId)
);

/* Feedback Table */
CREATE TABLE feedback (
    feedbackId VARCHAR(6) NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    userId VARCHAR(6) NOT NULL,

	CONSTRAINT feedback_pk PRIMARY KEY(feedbackId),
	CONSTRAINT feedback_fk FOREIGN KEY(userId) REFERENCES user(userId)
);

/* Feedback Approve Table */
CREATE TABLE feedbackApprove(
    feedbackId VARCHAR(6) NOT NULL,
    employeeId VARCHAR(6) NOT NULL,
    date DATE NOT NULL,

    CONSTRAINT feedbackApprove_pk PRIMARY KEY(feedbackId, employeeId),
    CONSTRAINT feedbackApprove_fk1 FOREIGN KEY(feedbackId) REFERENCES feedback(feedbackId),
    CONSTRAINT feedbackApprove_fk2 FOREIGN KEY(employeeId) REFERENCES employee(employeeId)
);

/* Complaint Resolve Table */
CREATE TABLE complaintResolve (
    complaintId VARCHAR(6) NOT NULL,
    employeeId VARCHAR(6) NOT NULL,
    date DATE NOT NULL,

    CONSTRAINT complaintResolve_pk PRIMARY KEY(complaintId, employeeId),
	CONSTRAINT complaintResolve_fk1 FOREIGN KEY(complaintId) REFERENCES complaint(complaintId),
    CONSTRAINT complaintResolve_fk2 FOREIGN KEY(employeeId) REFERENCES employee(employeeId)
);

/* Insert data Plan Table */
INSERT INTO plan (planId, planName, planFee, planDescription, duration)
VALUES
    ('P1', 'Basic', 120000, 'Basic plan with limited features', 1),
    ('P2', 'Standard', 150000, 'Standard plan with additional features', 2),
    ('P3', 'Premium', 170000, 'Premium plan with all features included', 3),
    ('P4', 'Gold', 210000, 'Gold plan with exclusive features and support', 5),
    ('P5', 'Platinum', 250000, 'Platinum plan with VIP support and additional benefits', 5);

/* Insert data Manager Table */
INSERT INTO manager (managerId, name, email, password, dob, address)
VALUES
    ('M1', 'Kamal Perera', 'kamal@example.com', 'pass123', '1980-06-20', '123, Galle Road, Colombo'),
    ('M2', 'Samantha Silva', 'samantha@example.com', 'samanthapass', '1975-09-15', '456, Kandy Road, Kandy'),
    ('M3', 'Nimal Rajapaksa', 'nimal@example.com', 'nimalpass', '1982-03-10', '789, Negombo Road, Negombo'),
    ('M4', 'Lakshmi Fernando', 'lakshmi@example.com', 'lakshmipass', '1978-12-25', '321, Gampaha Road, Gampaha'),
    ('M5', 'Bandara Jayawardena', 'bandara@example.com', 'bandarapass', '1985-07-08', '654, Matara Road, Matara');

/* Insert data Report Table */
INSERT INTO Report (reportId, reportDate, type, managerId)
VALUES
    ('R1', '2024-04-01', 'Monthly Sales Report', 'M1'),
    ('R2', '2024-04-05', 'Quarterly Performance Report', 'M2'),
    ('R3', '2024-04-10', 'Annual Financial Report', 'M3'),
    ('R4', '2024-04-15', 'Marketing Campaign Analysis', 'M4'),
    ('R5', '2024-04-20', 'Customer Satisfaction Survey Results', 'M5');

/* Insert data Admin Table */
INSERT INTO admin (adminId, name, email, password, dob, address, managerId)
VALUES
    ('A1', 'Samantha Perera', 'samantha@example.com', 'pass123', '1982-05-15', '123, Galle Road, Colombo', 'M1'),
    ('A2', 'Nimal Silva', 'nimal@example.com', 'nimalpass', '1978-08-20', '456, Kandy Road, Kandy', 'M2'),
    ('A3', 'Lakshan Rajapaksa', 'lakshan@example.com', 'lakshanpass', '1985-12-10', '789, Negombo Road, Negombo', 'M3'),
    ('A4', 'Thilani Fernando', 'thilani@example.com', 'thilanipass', '1990-03-25', '321, Gampaha Road, Gampaha', 'M4'),
    ('A5', 'Kamal Jayawardena', 'kamal@example.com', 'kamalpass', '1988-07-08', '654, Matara Road, Matara', 'M5');

/* Insert data Admin Contact Table */
INSERT INTO adminContact (adminId, phoneNo)
VALUES
    ('A1', '0712345678'),
    ('A2', '0776543210'),
    ('A3', '0765432109'),
    ('A4', '0754321098'),
    ('A5', '0723456789'),
	('A1', '0745895327');

/* Insert data Employee Table */
INSERT INTO employee (employeeID, name, email, password, dob, address, nic, adminId)
VALUES
    ('E1', 'Saman Perera', 'saman@example.com', 'password123', '1990-05-15', '123, Galle Road, Colombo', '901234567V', 'A1'),
    ('E2', 'Nimali Silva', 'nimali@example.com', 'pass456', '1985-08-20', '456, Kandy Road, Kandy', '871234567V', 'A2'),
    ('E3', 'Lakshan Fernando', 'lakshan@example.com', 'lakshanpass', '1992-12-10', '789, Negombo Road, Negombo', '931234567V', 'A3'),
    ('E4', 'Thilani Rajapaksa', 'thilani@example.com', 'thilanipass', '1988-03-25', '321, Gampaha Road, Gampaha', '951234567V', 'A4'),
    ('E5', 'Kamal Jayawardena', 'kamal@example.com', 'kamalpass', '1995-07-08', '654, Matara Road, Matara', '981234567V', 'A5');

/* Insert data Employee Contact Table */
INSERT INTO employeeContact (employeeId, phoneNo)
VALUES
    ('E1', '0712345678'),
    ('E2', '0776543210'),
    ('E3', '0765432109'),
    ('E4', '0754321098'),
    ('E5', '0723456789');

/* Insert data User Table */
INSERT INTO user (userId, firstName, lastName, dob, email, password, gender, planId, adminId, houseNo, street, city, postalCode)
VALUES
    ('U1', 'Samantha', 'Perera', '1990-05-15', 'samantha@example.com', 'password123', 'Female', 'P1', 'A1', '123', 'Galle Road', 'Colombo', '00100'),
    ('U2', 'Nimal', 'Silva', '1985-08-20', 'nimal@example.com', 'pass456', 'Male', 'P2', 'A2', '456', 'Kandy Road', 'Kandy', '20000'),
    ('U3', 'Lakshan', 'Fernando', '1992-12-10', 'lakshan@example.com', 'lakshanpass', 'Male', 'P1', 'A3', '789', 'Negombo Road', 'Negombo', '00300'),
    ('U4', 'Thilani', 'Rajapaksa', '1988-03-25', 'thilani@example.com', 'thilanipass', 'Female', 'P3', 'A4', '321', 'Gampaha Road', 'Gampaha', '00400'),
    ('U5', 'Kamal', 'Jayawardena', '1995-07-08', 'kamal@example.com', 'kamalpass', 'Male', 'P2', 'A5', '654', 'Matara Road', 'Matara', '00500');

/* Insert data User Contact Table */
INSERT INTO userContact (userId, phoneNo)
VALUES
    ('U1', '0712345678'),
    ('U2', '0776543210'),
    ('U3', '0765432109'),
    ('U4', '0754321098'),
    ('U5', '0723456789'),
	('U3', '0714589652');

/* Insert data Annual Fee Table */
INSERT INTO annualFee (feeId, userId, amount, paymentDate, expireDate)
VALUES
    ('AF1', 'U1', 100000.00, '2024-01-01', '2024-12-31'),
    ('AF2', 'U2', 150000.00, '2024-02-15', '2024-12-31'),
    ('AF3', 'U3', 200000.00, '2024-03-20', '2024-12-31'),
    ('AF4', 'U4', 180000.00, '2024-04-10', '2024-12-31'),
    ('AF5', 'U5', 120000.00, '2024-05-05', '2024-12-31');

/* Insert data Plan Update Table */
INSERT INTO planUpdate (planId, managerId, date)
VALUES
    ('P1', 'M1', '2024-01-15'),
    ('P2', 'M2', '2024-02-20'),
    ('P3', 'M3', '2024-03-25'),
    ('P4', 'M4', '2024-04-30'),
    ('P5', 'M5', '2024-05-05');

/* Insert data Complaint Table */
INSERT INTO complaint (complaintId, userId, date, complaintType, status)
VALUES
    ('CP1', 'U1', '2024-05-10', 'Service Quality', 'Open'),
    ('CP2', 'U2', '2024-05-12', 'Billing Issue', 'Resolved'),
    ('CP3', 'U3', '2024-05-15', 'Technical Support', 'In Progress'),
    ('CP4', 'U4', '2024-05-18', 'Delivery Delay', 'Open'),
    ('CP5', 'U5', '2024-05-20', 'Product Defect', 'Open');

/* Insert data Dependent Table */
INSERT INTO Dependent (userId, name, gender, dob)
VALUES
    ('U1', 'Samantha Perera Jr.', 'Female', '2020-03-10'),
    ('U2', 'Nimal Silva Jr.', 'Male', '2018-07-20'),
    ('U3', 'Lakshan Fernando Jr.', 'Male', '2021-12-05'),
    ('U4', 'Thilani Rajapaksa Jr.', 'Female', '2019-05-15'),
    ('U5', 'Kamal Jayawardena Jr.', 'Male', '2022-08-30');

/* Insert data Claim Table */
INSERT INTO Claim (claimId, userId, amount, claimDescription, date, status, adminId)
VALUES
    ('CL1', 'U1', 50000.00, 'Vehicle Accident', '2024-05-10', 'Pending', 'A1'),
    ('CL2', 'U2', 30000.00, 'Medical Expense', '2024-05-12', 'Approved', 'A2'),
    ('CL3', 'U3', 70000.00, 'Home Damage', '2024-05-15', 'Pending', 'A3'),
    ('CL4', 'U4', 20000.00, 'Theft Incident', '2024-05-18', 'Denied', 'A4'),
    ('CL5', 'U5', 40000.00, 'Natural Disaster', '2024-05-20', 'Pending', 'A5');

/* Insert data Feedback Table */
INSERT INTO feedback (feedbackId, rating, comment, date, userId)
VALUES
    ('FB1', 4, 'Great service!', '2024-05-11', 'U1'),
    ('FB2', 5, 'Very satisfied with the product.', '2024-05-13', 'U2'),
    ('FB3', 3, 'Could improve delivery time.', '2024-05-16', 'U3'),
    ('FB4', 4, 'Responsive customer support.', '2024-05-19', 'U4'),
    ('FB5', 2, 'Disappointed with the quality.', '2024-05-21', 'U5');

/* Insert data Feedback Approve Table */
INSERT INTO feedbackApprove (feedbackId, employeeId, date)
VALUES
    ('FB1', 'E1', '2024-05-12'),
    ('FB2', 'E2', '2024-05-14'),
    ('FB3', 'E3', '2024-05-17'),
    ('FB4', 'E4', '2024-05-20'),
    ('FB5', 'E5', '2024-05-22');

/* Insert data Complaint Resolve Table */
INSERT INTO complaintResolve (complaintId, employeeId, date)
VALUES
    ('CP1', 'E1', '2024-05-11'),
    ('CP2', 'E2', '2024-05-13'),
    ('CP3', 'E3', '2024-05-16'),
    ('CP4', 'E4', '2024-05-19'),
    ('CP5', 'E5', '2024-05-21');




