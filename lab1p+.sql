CREATE TABLE department(
    departmentName VARCHAR(255) PRIMARY KEY,
    buildingNr INT NOT NULL
);

CREATE TABLE employee(
    iD INT PRIMARY KEY,
    phoneNr INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    mentor INT --another employees id
);

CREATE TABLE doctor(
    iD INT PRIMARY KEY,
    roomNr INT NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    patient INT[] --patient id
);

CREATE TABLE nurse(
    iD INT PRIMARY KEY,
    degree VARCHAR(255)
);

CREATE TABLE patient(
    iD INT PRIMARY KEY,
    diagnosis VARCHAR(255), --Nullable
    name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    doctors[] INT
);