-- Insert sample data into department table
INSERT INTO department (departmentName, buildingNr) 
VALUES 
    ('Cardiology', 101),
    ('Neurology', 102),
    ('Orthopedics', 103);

-- Insert sample data into employee table
INSERT INTO employee (ID, phoneNr, name) 
VALUES 
    (1, '1234567890', 'Dr. John Smith'),  -- Doctor 1
    (2, '2345678901', 'Dr. Emily Johnson'), -- Doctor 2
    (3, '3456789012', 'Nurse Sarah Davis'), -- Nurse 1
    (4, '4567890123', 'Nurse Michael Brown'); -- Nurse 2

-- Insert sample data into worksAt table (assigning employees to departments)
INSERT INTO worksAt (employeeID, departmentName, startDate) 
VALUES 
    (1, 'Cardiology', '2024-01-01'),  -- Dr. John Smith works in Cardiology
    (2, 'Neurology', '2024-02-01'),   -- Dr. Emily Johnson works in Neurology
    (3, 'Cardiology', '2024-03-01'),   -- Nurse Sarah Davis works in Cardiology
    (4, 'Orthopedics', '2024-04-01');  -- Nurse Michael Brown works in Orthopedics

-- Insert sample data into mentor table (mentor-apprentice relationships)
INSERT INTO mentor (apprenticeID, mentorID)
VALUES 
    (3, 1), -- Nurse Sarah Davis (apprentice) is mentored by Dr. John Smith
    (4, 2); -- Nurse Michael Brown (apprentice) is mentored by Dr. Emily Johnson

-- Insert sample data into doctor table
INSERT INTO doctor (ID, phoneNr, name, roomNr, specialization) 
VALUES 
    (1, '1234567890', 'Dr. John Smith', 101, 'Cardiologist'),
    (2, '2345678901', 'Dr. Emily Johnson', 102, 'Neurologist');

-- Insert sample data into nurse table
INSERT INTO nurse (ID, phoneNr, name, degree) 
VALUES 
    (3, '3456789012', 'Nurse Sarah Davis', 'Registered Nurse'),
    (4, '4567890123', 'Nurse Michael Brown', 'Licensed Practical Nurse');

-- Insert sample data into patient table
INSERT INTO patient (ID, diagnosises, name, age) 
VALUES 
    (1, '{"Hypertension", "Arrhythmia"}', 'Alice Thompson', 65),
    (2, '{"Alzheimers Disease"}', 'Bob Martin', 72),
    (3, '{"Fracture"}', 'Charlie Davis', 50);

-- Insert sample data into treating table (assigning doctors to treat patients)
INSERT INTO treating (doctorID, patientID) 
VALUES 
    (1, 1), -- Dr. John Smith treats Alice Thompson
    (2, 2), -- Dr. Emily Johnson treats Bob Martin
    (2, 3); -- Dr. Emily Johnson treats Charlie Davis