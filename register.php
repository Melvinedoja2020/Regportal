<?php
// Database connection parameters
$host = "localhost";
$dbname = "silicon_delta";
$username = "root";
$password = ""; // Set your database password here

// Create connection
try {
    $conn = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    // Set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

// Function to sanitize input data
function sanitize_input($data) {
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}

// Process form submission
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Collect and sanitize form data
    $fullName = sanitize_input($_POST["fullName"]);
    $email = sanitize_input($_POST["email"]);
    $phone = sanitize_input($_POST["phone"]);
    $dob = sanitize_input($_POST["dob"]);
    $academicLevel = sanitize_input($_POST["academicLevel"]);
    $programType = sanitize_input($_POST["programType"]);
    $courseCategory = sanitize_input($_POST["courseCategory"]);
    $specificCourse = sanitize_input($_POST["specificCourse"]);
    $campus = sanitize_input($_POST["campus"]);
    $startDate = sanitize_input($_POST["startDate"]);
    $address = sanitize_input($_POST["address"]);
    $password = $_POST["password"]; // Will be hashed
    
    // Validate email format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("Invalid email format");
    }
    
    // Check if email already exists
    $stmt = $conn->prepare("SELECT id FROM students WHERE email = :email");
    $stmt->bindParam(':email', $email);
    $stmt->execute();
    
    if ($stmt->rowCount() > 0) {
        die("Email already registered. Please use a different email or login to your account.");
    }
    
    // Hash password
    $hashedPassword = password_hash($password, PASSWORD_DEFAULT);
    
    try {
        // Begin transaction
        $conn->beginTransaction();
        
        // Insert into students table
        $stmt = $conn->prepare("INSERT INTO students (full_name, email, phone, dob, address, password, created_at) 
                               VALUES (:fullName, :email, :phone, :dob, :address, :password, NOW())");
        
        $stmt->bindParam(':fullName', $fullName);
        $stmt->bindParam(':email', $email);
        $stmt->bindParam(':phone', $phone);
        $stmt->bindParam(':dob', $dob);
        $stmt->bindParam(':address', $address);
        $stmt->bindParam(':password', $hashedPassword);
        $stmt->execute();
        
        // Get the student ID
        $studentId = $conn->lastInsertId();
        
        // Insert into registrations table
        $stmt = $conn->prepare("INSERT INTO registrations (student_id, academic_level, program_type, course_category, 
                               specific_course, campus, start_date, registration_date) 
                               VALUES (:studentId, :academicLevel, :programType, :courseCategory, 
                               :specificCourse, :campus, :startDate, NOW())");
        
        $stmt->bindParam(':studentId', $studentId);
        $stmt->bindParam(':academicLevel', $academicLevel);
        $stmt->bindParam(':programType', $programType);
        $stmt->bindParam(':courseCategory', $courseCategory);
        $stmt->bindParam(':specificCourse', $specificCourse);
        $stmt->bindParam(':campus', $campus);
        $stmt->bindParam(':startDate', $startDate);
        $stmt->execute();
        
        // Commit transaction
        $conn->commit();
        
        // Send confirmation email (in a production environment)
        // mail($email, "Registration Confirmation", "Thank you for registering with Silicon Delta...");
        
        // Redirect to success page
        header("Location: registration_success.php?id=" . $studentId);
        exit();
        
    } catch(PDOException $e) {
        // Roll back transaction on error
        $conn->rollBack();
        die("Registration failed: " . $e->getMessage());
    }
}
?>

