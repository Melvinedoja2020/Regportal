-- Create database
CREATE DATABASE IF NOT EXISTS silicon_delta;
USE silicon_delta;

-- Create students table
CREATE TABLE IF NOT EXISTS students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    address TEXT NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create registrations table
CREATE TABLE IF NOT EXISTS registrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    academic_level VARCHAR(50) NOT NULL,
    program_type VARCHAR(50) NOT NULL,
    course_category VARCHAR(50) NOT NULL,
    specific_course VARCHAR(50) NOT NULL,
    campus VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    registration_date DATETIME NOT NULL,
    status ENUM('pending', 'approved', 'rejected', 'completed') DEFAULT 'pending',
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- Create courses table
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_id VARCHAR(50) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT,
    duration VARCHAR(50),
    fee DECIMAL(10, 2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample course data
INSERT INTO courses (course_id, course_name, category, description, duration, fee) VALUES
-- Web Development
('html_css', 'HTML & CSS Fundamentals', 'web_development', 'Learn the basics of web development with HTML and CSS', '4 weeks', 299.99),
('javascript', 'JavaScript Programming', 'web_development', 'Master JavaScript programming for dynamic web applications', '6 weeks', 399.99),
('react', 'React.js Development', 'web_development', 'Build modern user interfaces with React.js', '8 weeks', 499.99),
('node', 'Node.js Backend Development', 'web_development', 'Create server-side applications with Node.js', '8 weeks', 499.99),
('php', 'PHP Web Development', 'web_development', 'Develop dynamic websites with PHP', '6 weeks', 399.99),
('full_stack', 'Full Stack Web Development', 'web_development', 'Comprehensive training in both frontend and backend development', '12 weeks', 999.99),

-- Data Science
('python', 'Python for Data Science', 'data_science', 'Learn Python programming for data analysis', '6 weeks', 449.99),
('data_analysis', 'Data Analysis & Visualization', 'data_science', 'Master data analysis techniques and visualization tools', '8 weeks', 549.99),
('machine_learning', 'Introduction to Machine Learning', 'data_science', 'Learn the fundamentals of machine learning algorithms', '10 weeks', 699.99),
('big_data', 'Big Data Processing', 'data_science', 'Process and analyze large datasets with modern tools', '8 weeks', 599.99),
('statistics', 'Statistical Methods for Data Science', 'data_science', 'Apply statistical methods to data analysis', '6 weeks', 449.99),

-- Cybersecurity
('network_security', 'Network Security Fundamentals', 'cybersecurity', 'Learn the basics of securing computer networks', '6 weeks', 499.99),
('ethical_hacking', 'Ethical Hacking', 'cybersecurity', 'Master ethical hacking techniques and penetration testing', '8 weeks', 699.99),
('security_analyst', 'Security Analyst Training', 'cybersecurity', 'Comprehensive training for security analyst roles', '10 weeks', 799.99),
('cryptography', 'Cryptography & Secure Communications', 'cybersecurity', 'Learn encryption techniques and secure communication protocols', '6 weeks', 549.99),

-- AI & Machine Learning
('ml_fundamentals', 'Machine Learning Fundamentals', 'ai_ml', 'Introduction to machine learning concepts and algorithms', '8 weeks', 599.99),
('deep_learning', 'Deep Learning with TensorFlow', 'ai_ml', 'Build neural networks with TensorFlow', '10 weeks', 799.99),
('nlp', 'Natural Language Processing', 'ai_ml', 'Process and analyze human language with AI', '8 weeks', 699.99),
('computer_vision', 'Computer Vision', 'ai_ml', 'Develop applications that can interpret visual information', '8 weeks', 699.99),

-- Cloud Computing
('aws', 'AWS Cloud Practitioner', 'cloud_computing', 'Learn the fundamentals of Amazon Web Services', '6 weeks', 499.99),
('azure', 'Microsoft Azure Fundamentals', 'cloud_computing', 'Master the basics of Microsoft Azure cloud platform', '6 weeks', 499.99),
('gcp', 'Google Cloud Platform', 'cloud_computing', 'Learn to deploy applications on Google Cloud Platform', '6 weeks', 499.99),
('cloud_architecture', 'Cloud Architecture Design', 'cloud_computing', 'Design scalable and resilient cloud architectures', '8 weeks', 699.99),

-- Mobile Development
('android', 'Android App Development', 'mobile_dev', 'Build native Android applications with Kotlin', '8 weeks', 599.99),
('ios', 'iOS App Development with Swift', 'mobile_dev', 'Create iOS applications with Swift programming language', '8 weeks', 599.99),
('react_native', 'Cross-platform with React Native', 'mobile_dev', 'Develop mobile apps for multiple platforms with React Native', '8 weeks', 649.99),
('flutter', 'Flutter Development', 'mobile_dev', 'Build beautiful cross-platform applications with Flutter', '8 weeks', 649.99);