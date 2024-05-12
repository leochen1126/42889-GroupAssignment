import Foundation
import FirebaseCore
import FirebaseFirestore
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginSuccessful = false
    @Published var loginFailed = false
    
    private var db = Firestore.firestore()
    
    // Add a closure to handle view dismissal
    var handleDismissal: (() -> Void)?
    
    func login() {
        let usersRef = db.collection("user_info")
        
        usersRef.whereField("userName", isEqualTo: self.username).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                DispatchQueue.main.async {
                    self.loginFailed = true
                }
            } else {
                for document in querySnapshot!.documents {
                    if let storedPassword = document.data()["password"] as? String {
                        if self.password == storedPassword {
                            print("Login successful")
                            DispatchQueue.main.async {
                                self.loginSuccessful = true
                                // Call the dismissal handler
                                self.handleDismissal?()
                            }
                            return
                        } else {
                            print("Incorrect password")
                            DispatchQueue.main.async {
                                self.loginFailed = true
                            }
                            return
                        }
                    }
                }
                print("Username not found")
                DispatchQueue.main.async {
                    self.loginFailed = true
                }
            }
        }
    }
}
