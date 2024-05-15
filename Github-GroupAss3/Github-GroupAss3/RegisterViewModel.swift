//
//  RegisterViewModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 9/5/2024.
//
import Foundation
import FirebaseCore
import FirebaseFirestore



class RegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var address = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    // Validation states
    @Published var isUsernameValid = false
    @Published var isEmailValid = false
    @Published var isPhoneNumberValid = false
    @Published var isAddressValid = false
    @Published var isPasswordValid = false
    @Published var isConfirmPasswordValid = true
    @Published var showAlert = false
    @Published var registrationSuccessful = false
    // Validation functions
    func isValidUsername() -> Bool {
        return !username.isEmpty
    }
    
    func isValidEmail() -> Bool {
        // Regular expression for validating email address
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPhoneNumber() -> Bool {
        return phoneNumber.count >= 7
    }
    
    func isValidAddress() -> Bool {
        return !address.isEmpty
    }
    
    func isValidPassword() -> Bool {
        return password.count >= 6
    }
    
    func isValidConfirmPassword() -> Bool {
        return confirmPassword == password
    }
    
    func isFormValid() -> Bool {
        // Check if all fields are valid
        return isUsernameValid && isEmailValid && isPhoneNumberValid && isAddressValid && isPasswordValid && isConfirmPasswordValid
    }
    func register() {
        let db = Firestore.firestore()
        
        // Get a reference to the "user_info" collection
        let userCollection = db.collection("user_info")
        
        // create a new document with an auto-generated ID
        let newDocumentRef = userCollection.document()
        
        // Use the auto-generated ID as the document name
        let documentID = newDocumentRef.documentID
        
        let data: [String: Any] = [
            "userName": username,
            "address": address,
            "phone": phoneNumber,
            "email": email,
            "password": password,
            "admin": false
        ]
        showAlert = true
        registrationSuccessful = true
        // Set the data in the newly created document
        newDocumentRef.setData(data) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written with ID: \(documentID)")
            }
        }
        
    }
}
