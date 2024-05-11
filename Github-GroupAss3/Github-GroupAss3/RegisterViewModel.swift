import Foundation

class RegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var address = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    // Validation states
    @Published var isUsernameValid = true
    @Published var isEmailValid = true
    @Published var isPhoneNumberValid = true
    @Published var isAddressValid = true
    @Published var isPasswordValid = true
    @Published var isConfirmPasswordValid = true
    
    // Validation functions
    func isValidUsername() -> Bool {
        // Add your validation logic for username
        return !username.isEmpty
    }
    
    func isValidEmail() -> Bool {
        // Regular expression for validating email address
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPhoneNumber() -> Bool {
        // Add your validation logic for phone number
        return phoneNumber.count >= 7
    }
    
    func isValidAddress() -> Bool {
        // Add your validation logic for address
        return !address.isEmpty
    }
    
    func isValidPassword() -> Bool {
        // Add your validation logic for password
        return password.count >= 6
    }
    
    func isValidConfirmPassword() -> Bool {
        // Add your validation logic for confirm password
        return confirmPassword == password
    }
    
    func isFormValid() -> Bool {
        // Check if all fields are valid
        return isUsernameValid && isEmailValid && isPhoneNumberValid && isAddressValid && isPasswordValid && isConfirmPasswordValid
    }
    func register(){
        
    }
}
