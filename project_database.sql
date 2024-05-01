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

	CONSTRAINT userContact_pk PRIMARY KEY(userId),
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
/*executed until now*/































