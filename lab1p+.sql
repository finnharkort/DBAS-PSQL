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
    phoneNr VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE worksAt(
    employeeID INT,
    departmentName VARCHAR(255),
    startDate DATE,
    PRIMARY KEY(employeeID,departmentName),
    CONSTRAINT fk_employee
        FOREIGN KEY (employeeID)
            REFERENCES employee (ID),
    CONSTRAINT fk_department
        FOREIGN KEY (departmentName)
            REFERENCES department (departmentName)
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
    ID INT PRIMARY KEY,
    roomNr INT NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    CONSTRAINT fk_employee  
        FOREIGN KEY (ID)
            REFERENCES employee (ID)
);

CREATE TABLE nurse(
    ID INT PRIMARY KEY,
    degree VARCHAR(255),
    CONSTRAINT fk_employee  
        FOREIGN KEY (ID)
            REFERENCES employee (ID)
);

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
    CONSTRAINT fk_doctor
        FOREIGN KEY (doctorID)
            REFERENCES employee (ID),
    CONSTRAINT fk_patient
        FOREIGN KEY (patientID)
            REFERENCES patient (ID)
);


GRANT ALL PRIVILEGES ON TABLE department TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE employee TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE doctor TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE nurse TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE patient TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE worksAt TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE treating TO nikolajg;
GRANT ALL PRIVILEGES ON TABLE mentor TO nikolajg;