/**
 * JavaScript functions for supplier management
 */

document.addEventListener('DOMContentLoaded', function() {
    // Form validation
    const supplierForm = document.getElementById('supplierForm');
    if (supplierForm) {
        supplierForm.addEventListener('submit', function(event) {
            // Get form fields
            const nameField = document.getElementById('name');
            const companyField = document.getElementById('company');
            const phoneField = document.getElementById('phone');

            // Check if required fields are filled
            let isValid = true;

            if (!nameField.value.trim()) {
                markInvalid(nameField, 'Name is required');
                isValid = false;
            } else {
                markValid(nameField);
            }

            if (!companyField.value.trim()) {
                markInvalid(companyField, 'Company is required');
                isValid = false;
            } else {
                markValid(companyField);
            }

            if (!phoneField.value.trim()) {
                markInvalid(phoneField, 'Phone is required');
                isValid = false;
            } else {
                markValid(phoneField);
            }

            // Validate phone format (optional)
            if (phoneField.value.trim() && !isValidPhone(phoneField.value.trim())) {
                markInvalid(phoneField, 'Please enter a valid phone number');
                isValid = false;
            }

            // Validate email format (if provided)
            const emailField = document.getElementById('email');
            if (emailField.value.trim() && !isValidEmail(emailField.value.trim())) {
                markInvalid(emailField, 'Please enter a valid email address');
                isValid = false;
            } else if (emailField.value.trim()) {
                markValid(emailField);
            }

            // Prevent form submission if validation fails
            if (!isValid) {
                event.preventDefault();
            }
        });
    }

    // Function to mark field as invalid
    function markInvalid(field, message) {
        field.style.borderColor = '#e74c3c';

        // Create or update error message
        let errorMsg = field.nextElementSibling;
        if (!errorMsg || !errorMsg.classList.contains('error-message')) {
            errorMsg = document.createElement('div');
            errorMsg.className = 'error-message';
            errorMsg.style.color = '#e74c3c';
            errorMsg.style.fontSize = '14px';
            errorMsg.style.marginTop = '5px';
            field.parentNode.insertBefore(errorMsg, field.nextElementSibling);
        }
        errorMsg.textContent = message;
    }

    // Function to mark field as valid
    function markValid(field) {
        field.style.borderColor = '#2ecc71';

        // Remove error message if exists
        const errorMsg = field.nextElementSibling;
        if (errorMsg && errorMsg.classList.contains('error-message')) {
            errorMsg.remove();
        }
    }

    // Validate email format
    function isValidEmail(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    // Validate phone format (basic validation)
    function isValidPhone(phone) {
        // Allow digits, spaces, dashes, and parentheses
        const regex = /^[0-9\s\-\(\)]+$/;
        return regex.test(phone);
    }

    // Add event listeners to clear validation on input
    const formFields = document.querySelectorAll('#supplierForm input, #supplierForm textarea');
    formFields.forEach(field => {
        field.addEventListener('input', function() {
            this.style.borderColor = '';
            const errorMsg = this.nextElementSibling;
            if (errorMsg && errorMsg.classList.contains('error-message')) {
                errorMsg.remove();
            }
        });
    });

    // Alert dismissal
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        // Create close button
        const closeBtn = document.createElement('span');
        closeBtn.innerHTML = '&times;';
        closeBtn.className = 'close-btn';
        closeBtn.style.float = 'right';
        closeBtn.style.cursor = 'pointer';
        closeBtn.style.fontSize = '20px';

        // Add click event to close
        closeBtn.addEventListener('click', function() {
            alert.style.display = 'none';
        });

        // Append to alert
        alert.prepend(closeBtn);

        // Auto-hide after 5 seconds
        setTimeout(() => {
            alert.style.display = 'none';
        }, 5000);
    });
});