DROP TABLE IF EXISTS worksAt;
DROP TABLE IF EXISTS treating;
DROP TABLE IF EXISTS mentor;
DROP TABLE IF EXISTS doctor;
DROP TABLE IF EXISTS nurse;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS patient;


CREATE TABLE department(
    departmentName VARCHAR(255) PRIMARY KEY,
    buildingNr INT NOT NULL
);

CREATE TABLE employee(
    ID INT PRIMARY KEY,
    phoneNr INT NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE worksAt(
    employeeID INT,
    departmentName,
    startDate DATE,
    PRIMARY KEY(employeeID,departmentName),
    CONSTRAINT fk_employee
        FOREIGN KEY (employeeID)
            REFERENCES employee (ID)
);

CREATE TABLE mentor(
    apprenticeID INT PRIMARY KEY,
    mentorID INT,
    CONSTRAINT fk_employee1
        FOREIGN KEY (apprenticeID)
            REFERENCES employee (ID),
    CONSTRAINT fk_employee2
        FOREIGN KEY (mentorID)
            REFERENCES employee (ID)
);

CREATE TABLE doctor(
    roomNr INT NOT NULL,
    specialization VARCHAR(255) NOT NULL
) INHERITS (employee);

CREATE TABLE nurse(
    degree VARCHAR(255)
) INHERITS (employee);

CREATE TABLE patient(
    ID INT PRIMARY KEY,
    diagnosises VARCHAR(255)[], --Nullable
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE treating(
    doctorID INT,
    patientID INT,
    PRIMARY KEY (doctorID, patientID),
    CONSTRAINT
        FOREIGN KEY (doctorID)
            REFERENCES doctor (ID),
    CONSTRAINT
        FOREIGN KEY (patientID)
            REFERENCES patient (ID),
);


GRANT ALL PRIVILEGES ON TABLE department TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE employee TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE doctor TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE nurse TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE patient TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE worksAt TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE treating TO nikolajg;
