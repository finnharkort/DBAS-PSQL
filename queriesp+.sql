-- Sample Queries
-- 1. Get all departments
SELECT * FROM department;

-- 2. Get all employees
SELECT * FROM employee;

-- 3. List all employees working in a specific department
SELECT e.ID, e.name, e.phoneNr
FROM employee e
JOIN worksAt w ON e.ID = w.employeeID
WHERE w.departmentName = 'Cardiology';

-- 4. Get all doctors and their specializations
SELECT e.name, d.specialization
FROM employee e
JOIN doctor d ON e.ID = d.ID;

-- 5. Get all nurses and their degrees
SELECT e.name, n.degree
FROM employee e
JOIN nurse n ON e.ID = n.ID;

-- 6. List all patients being treated by a specific doctor
SELECT p.ID, p.name, p.diagnosises
FROM patient p
JOIN treating t ON p.ID = t.patientID
JOIN doctor d ON t.doctorID = d.ID
WHERE d.ID = 1;

-- 7. Update an employee's phone number
UPDATE employee
SET phoneNr = '555-5678'
WHERE ID = 1;

-- 8. Update a patient’s diagnoses (e.g., adding a new diagnosis)
UPDATE patient
SET diagnosises = ARRAY_APPEND(diagnosises, 'Asthma')
WHERE ID = 1;

-- 9. Remove an employee from a department
DELETE FROM worksAt
WHERE employeeID = 1 AND departmentName = 'Cardiology';

-- 10. Delete a patient record
DELETE FROM patient
WHERE ID = 1;

-- 11. Get a list of all employees with their department names and start dates
SELECT e.ID, e.name, w.departmentName, w.startDate
FROM employee e
LEFT JOIN worksAt w ON e.ID = w.employeeID;

-- 12. List doctors along with their patients’ names and diagnoses
SELECT d.ID AS doctorID, e.name AS doctorName, p.name AS patientName, p.diagnosises
FROM doctor d
JOIN treating t ON d.ID = t.doctorID
JOIN patient p ON t.patientID = p.ID
JOIN employee e ON d.ID = e.ID;

-- 13. List mentors and their apprentices
SELECT mentor.name AS mentorName, apprentice.name AS apprenticeName
FROM mentor m
JOIN employee mentor ON m.mentorID = mentor.ID
JOIN employee apprentice ON m.apprenticeID = apprentice.ID;

-- 14. Count the number of employees in each department
SELECT w.departmentName, COUNT(w.employeeID) AS employeeCount
FROM worksAt w
GROUP BY w.departmentName;

-- 15. Count the number of patients per doctor
SELECT d.ID AS doctorID, e.name AS doctorName, COUNT(t.patientID) AS patientCount
FROM doctor d
JOIN treating t ON d.ID = t.doctorID
JOIN employee e ON d.ID = e.ID
GROUP BY d.ID, e.name;