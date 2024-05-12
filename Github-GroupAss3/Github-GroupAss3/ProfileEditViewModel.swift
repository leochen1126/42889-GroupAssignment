//
//  ProfileEditViewModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 12/5/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore



class ProfileEditViewModel: ObservableObject {
    @Published var username = UserSettings.shared.username
    @Published var email = ""
    @Published var phoneNumber = ""
    @Published var address = ""
    var onSuccessfulUpdate: (() -> Void)?
    
    // Validation states
    @Published var isEmailValid = false
    @Published var isPhoneNumberValid = false
    @Published var isAddressValid = false
    @Published var showAlert = false
    @Published var updateSuccessful = false
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
    
    func isFormValid() -> Bool {
        // Check if all fields are valid
        return isEmailValid && isPhoneNumberValid && isAddressValid
    }
    func update() {
        // Check if form is valid
        if isFormValid() {
            let db = Firestore.firestore()
            
            // Get a reference to the "user_info" collection
            let userCollection = db.collection("user_info")
            
            // Create a dictionary with the user's data
            let userData: [String: Any] = [
                "userName": username,
                "email": email,
                "phoneNumber": phoneNumber,
                "address": address
            ]
            
            // Query the collection for the document with the matching username
            userCollection.whereField("userName", isEqualTo: username).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    self.showAlert = true
                    self.updateSuccessful = false
                } else {
                    for document in querySnapshot!.documents {
                        // Update the document with the user's data
                        document.reference.updateData(userData) { error in
                            if let error = error {
                                print("Error updating document: \(error)")
                                self.showAlert = true
                                self.updateSuccessful = false
                            } else {
                                print("Document successfully updated")
                                self.showAlert = true
                                self.updateSuccessful = true
                                DispatchQueue.main.async {
                                    self.onSuccessfulUpdate?()
                                }
                            }
                        }
                    }
                }
            }
        } else {
            print("Form is not valid")
            self.showAlert = true
            self.updateSuccessful = false
        }
    }
}
