document.addEventListener("DOMContentLoaded", () => {
    // Course data - this would typically come from a database via AJAX
    const courseData = {
      web_development: [
        { id: "html_css", name: "HTML & CSS Fundamentals" },
        { id: "javascript", name: "JavaScript Programming" },
        { id: "react", name: "React.js Development" },
        { id: "node", name: "Node.js Backend Development" },
        { id: "php", name: "PHP Web Development" },
        { id: "full_stack", name: "Full Stack Web Development" },
      ],
      data_science: [
        { id: "python", name: "Python for Data Science" },
        { id: "data_analysis", name: "Data Analysis & Visualization" },
        { id: "machine_learning", name: "Introduction to Machine Learning" },
        { id: "big_data", name: "Big Data Processing" },
        { id: "statistics", name: "Statistical Methods for Data Science" },
      ],
      cybersecurity: [
        { id: "network_security", name: "Network Security Fundamentals" },
        { id: "ethical_hacking", name: "Ethical Hacking" },
        { id: "security_analyst", name: "Security Analyst Training" },
        { id: "cryptography", name: "Cryptography & Secure Communications" },
      ],
      ai_ml: [
        { id: "ml_fundamentals", name: "Machine Learning Fundamentals" },
        { id: "deep_learning", name: "Deep Learning with TensorFlow" },
        { id: "nlp", name: "Natural Language Processing" },
        { id: "computer_vision", name: "Computer Vision" },
      ],
      cloud_computing: [
        { id: "aws", name: "AWS Cloud Practitioner" },
        { id: "azure", name: "Microsoft Azure Fundamentals" },
        { id: "gcp", name: "Google Cloud Platform" },
        { id: "cloud_architecture", name: "Cloud Architecture Design" },
      ],
      mobile_dev: [
        { id: "android", name: "Android App Development" },
        { id: "ios", name: "iOS App Development with Swift" },
        { id: "react_native", name: "Cross-platform with React Native" },
        { id: "flutter", name: "Flutter Development" },
      ],
    }
  
    // Get form elements
    const form = document.getElementById("registrationForm")
    const courseCategorySelect = document.getElementById("courseCategory")
    const specificCourseSelect = document.getElementById("specificCourse")
    const passwordInput = document.getElementById("password")
    const confirmPasswordInput = document.getElementById("confirmPassword")
  
    // Populate specific courses based on selected category
    courseCategorySelect.addEventListener("change", function () {
      const selectedCategory = this.value
  
      // Clear current options
      specificCourseSelect.innerHTML = ""
  
      if (!selectedCategory) {
        // Add default option
        const defaultOption = document.createElement("option")
        defaultOption.value = ""
        defaultOption.textContent = "Select a Course Category First"
        specificCourseSelect.appendChild(defaultOption)
        return
      }
  
      // Add default option
      const defaultOption = document.createElement("option")
      defaultOption.value = ""
      defaultOption.textContent = "Select a Specific Course"
      specificCourseSelect.appendChild(defaultOption)
  
      // Add course options for selected category
      const courses = courseData[selectedCategory] || []
      courses.forEach((course) => {
        const option = document.createElement("option")
        option.value = course.id
        option.textContent = course.name
        specificCourseSelect.appendChild(option)
      })
    })
  
    // Form validation
    form.addEventListener("submit", (e) => {
      let isValid = true
      let errorMessage = ""
  
      // Password validation
      if (passwordInput.value.length < 8) {
        isValid = false
        errorMessage += "Password must be at least 8 characters long.\n"
      }
  
      // Check if password contains letters, numbers, and special characters
      const hasLetter = /[a-zA-Z]/.test(passwordInput.value)
      const hasNumber = /\d/.test(passwordInput.value)
      const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(passwordInput.value)
  
      if (!(hasLetter && hasNumber && hasSpecial)) {
        isValid = false
        errorMessage += "Password must contain letters, numbers, and special characters.\n"
      }
  
      // Confirm password
      if (passwordInput.value !== confirmPasswordInput.value) {
        isValid = false
        errorMessage += "Passwords do not match.\n"
      }
  
      // Check if specific course is selected
      if (!specificCourseSelect.value) {
        isValid = false
        errorMessage += "Please select a specific course.\n"
      }
  
      if (!isValid) {
        e.preventDefault()
        alert("Please fix the following errors:\n" + errorMessage)
      }
    })
  
    // Add animation to form submission
    form.addEventListener("submit", (e) => {
      if (e.defaultPrevented) return // If form validation failed
  
      const submitBtn = document.querySelector(".submit-btn")
      submitBtn.textContent = "Processing..."
      submitBtn.disabled = true
  
      // This would normally be handled by the server, but we'll add a small delay for demo purposes
      setTimeout(() => {
        submitBtn.textContent = "Register Now"
        submitBtn.disabled = false
      }, 2000)
    })
  })
  
  