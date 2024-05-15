//
//  LoginViewModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 9/5/2024.
//
import Foundation
import FirebaseCore
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginSuccessful = false
    @Published var loginFailed = false
    private var db = Firestore.firestore()
    
    // Add a closure to handle view dismissal
    var handleDismissal: (() -> Void)?
    // Add a closure to handle successful login
    var handleSuccessfulLogin: ((String) -> Void)?
        
    func login() {
        let usersRef = db.collection("user_info")// grab data from user database
        usersRef.whereField("userName", isEqualTo: self.username).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                DispatchQueue.main.async {// trigger error messege
                    self.loginFailed = true
                }
            } else {
                for document in querySnapshot!.documents {
                    if let storedPassword = document.data()["password"] as? String {
                        if self.password == storedPassword {
                            print("Login successful")
                            DispatchQueue.main.async {
                                self.loginSuccessful = true
                                // Call the successful login handler
                                self.handleSuccessfulLogin?(self.username)
                                // Call the dismissal handler
                                self.handleDismissal?()
                            }
                            UserSettings.shared.username = self.username // assign user name as session data
                            if let storedAdmin = document.data()["admin"] as? Bool{
                                UserSettings.shared.admin = storedAdmin // make sure entering admin mode or not
                            }
                            
                            return
                        } else {
                            print("Incorrect password")
                            DispatchQueue.main.async { // trigger error messege
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
