-- Query 1: Get all employees and their associated department
SELECT e.name AS employee_name, d.departmentName, w.startDate
FROM employee e
JOIN worksAt w ON e.ID = w.employeeID
JOIN department d ON w.departmentName = d.departmentName;

-- Query 2: Get all doctors and their specialization
SELECT e.name AS doctor_name, d.specialization
FROM doctor d
JOIN employee e ON d.ID = e.ID;

-- Query 3: Get all nurses and their degree
SELECT e.name AS nurse_name, n.degree
FROM nurse n
JOIN employee e ON n.ID = e.ID;

-- Query 4: Get all patients and their associated diagnoses
SELECT p.name AS patient_name, p.diagnosises
FROM patient p;

-- Query 5: Get a list of doctors and the patients they treat
SELECT d.name AS doctor_name, p.name AS patient_name
FROM doctor d
JOIN treating t ON d.ID = t.doctorID
JOIN patient p ON t.patientID = p.ID;

-- Query 6: Get all mentors and their apprentices
SELECT e1.name AS mentor_name, e2.name AS apprentice_name
FROM mentor m
JOIN employee e1 ON m.mentorID = e1.ID
JOIN employee e2 ON m.apprenticeID = e2.ID;

-- Query 7: Get all employees working in the 'Cardiology' department
SELECT e.name AS employee_name
FROM employee e
JOIN worksAt w ON e.ID = w.employeeID
WHERE w.departmentName = 'Cardiology';

-- Query 8: Find the doctor who is treating a patient named 'Alice Thompson'
SELECT d.name AS doctor_name
FROM doctor d
JOIN treating t ON d.ID = t.doctorID
JOIN patient p ON t.patientID = p.ID
WHERE p.name = 'Alice Thompson';

-- Query 9: Get all patients treated by Dr. John Smith
SELECT p.name AS patient_name
FROM patient p
JOIN treating t ON p.ID = t.patientID
JOIN doctor d ON t.doctorID = d.ID
WHERE d.name = 'Dr. John Smith';

-- Query 10: List all employees who are mentors (have at least one apprentice)
SELECT DISTINCT e.name AS mentor_name
FROM mentor m
JOIN employee e ON m.mentorID = e.ID;

-- Query 11: List all employees who have been mentored (apprentices)
SELECT DISTINCT e.name AS apprentice_name
FROM mentor m
JOIN employee e ON m.apprenticeID = e.ID;

-- Query 12: Find all doctors who work in the 'Neurology' department
SELECT e.name AS doctor_name
FROM doctor d
JOIN employee e ON d.ID = e.ID
JOIN worksAt w ON e.ID = w.employeeID
WHERE w.departmentName = 'Neurology';

-- Query 13: Get the start date of a specific employee in a department (e.g., 'Dr. John Smith' in 'Cardiology')
SELECT w.startDate
FROM worksAt w
JOIN employee e ON w.employeeID = e.ID
WHERE e.name = 'Dr. John Smith' AND w.departmentName = 'Cardiology';

-- Query 14: Find the department where 'Nurse Sarah Davis' works
SELECT w.departmentName
FROM worksAt w
JOIN employee e ON w.employeeID = e.ID
WHERE e.name = 'Nurse Sarah Davis';

-- Query 15: List all doctors and their phone numbers
SELECT e.name AS doctor_name, e.phoneNr
FROM doctor d
JOIN employee e ON d.ID = e.ID;

-- Query 16: Get all patients who have a diagnosis of 'Fracture'
SELECT p.name AS patient_name
FROM patient p
WHERE 'Fracture' = ANY(p.diagnosises);

-- Query 17: Get all employees who work in the same department as 'Dr. John Smith'
SELECT e.name AS employee_name
FROM worksAt w
JOIN employee e ON w.employeeID = e.ID
WHERE w.departmentName = (
    SELECT w.departmentName
    FROM worksAt w
    JOIN employee e ON w.employeeID = e.ID
    WHERE e.name = 'Dr. John Smith'
);

-- Query 18: List all employees with their mentors and apprentices
SELECT e1.name AS mentor_name, e2.name AS apprentice_name
FROM mentor m
JOIN employee e1 ON m.mentorID = e1.ID
JOIN employee e2 ON m.apprenticeID = e2.ID;

-- Query 19: Find which department each nurse works in
SELECT e.name AS nurse_name, w.departmentName
FROM nurse n
JOIN employee e ON n.ID = e.ID
JOIN worksAt w ON e.ID = w.employeeID;

-- Query 20: Find all doctors who are currently treating patients
SELECT DISTINCT e.name AS doctor_name
FROM treating t
JOIN doctor d ON t.doctorID = d.ID
JOIN employee e ON d.ID = e.ID;
