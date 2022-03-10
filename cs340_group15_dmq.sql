-- Queries containing : denote variables that will have data from the backend programming language
-- similar to the example for the project step page

-- Classes --

-- Get all Classes IDs, Teachers IDs, and names to populate the Classes page
SELECT classId, teacherId, name FROM classes
-- Insert a new Classes entity (Note: classId is autoincremental)
INSERT INTO classes (teacherId, name) VALUES (:teacherIdInput, :nameInput)
-- Delete a Classes entity
DELETE FROM classes WHERE classId = :class_id_from_dropdown_Input

-- Students --

-- Get Students info to populate the Students page
SELECT studentId, firstName, lastName, email FROM students
-- Insert a new Students entity
INSERT INTO students (firstName, lastName, email) VALUES (:firstNameInput, :lastNameInput, :emailInput)

-- Teachers --

-- Get Teachers info to populate the Teachers page
SELECT teacherId, firstName, lastName, email FROM teachers
-- Search for a specific teacher by first and last name
SELECT teacherId, firstName, lastName, email FROM teachers WHERE firstName = :first_name_entry_Input, lastName = :last_name_entry_Input
-- Insert a new Teachers entity
INSERT INTO teachers (firstName, lastName, email) VALUES (:firstNameInput, :lastNameInput, :emailInput)

-- Reviews --

-- Get Reviews info to populate the Reviews page
SELECT reviewId, reviewYear, reviewTerm, studentId, teacherId FROM reviews
-- Insert a new Reviews entity
INSERT INTO reviews (reviewYear, reviewTerm, studentId, teacherId) VALUES (:yearInput, :termInput, :studentIdInput, :teacherIdInput)
-- Update a currently existing review
UPDATE reviews SET reviewYear = :yearInput, reviewTerm = :termInput, studentId = :studentIdInput, teacherId = :teacherIdInput WHERE reviewId = :review_id_entry_Input

-- classesStudentsDetails --

-- classesStudentsDetails intersection for a M-M relationship --
INSERT INTO classesStudentsDetails (classId, studentId) VALUES (:class_id_from_dropdown_Input, :student_id_from_dropdown_Input)