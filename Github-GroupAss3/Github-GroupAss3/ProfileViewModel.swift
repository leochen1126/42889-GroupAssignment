//
//  ProfileViewModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 12/5/2024.
//


import Foundation
import FirebaseCore
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var username = UserSettings.shared.username
    @Published var password = ""
    @Published var loginSuccessful = false
    @Published var loginFailed = false
    @Published var email = ""
    @Published var address = ""
    @Published var phone = ""
    
    // Add a closure to handle view dismissal
    var handleDismissal: (() -> Void)?
    
    private var db = Firestore.firestore()
    func fetchUserDetails() {
        let usersRef = db.collection("user_info")
        
        usersRef.whereField("userName", isEqualTo: self.username).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                self.loginFailed = true
            } else {
                for document in querySnapshot!.documents {
                    self.email = document.get("email") as? String ?? ""
                    self.address = document.get("address") as? String ?? ""
                    self.phone = document.get("phone") as? String ?? ""
                }
            }
        }
    }
    func logout(){
        UserSettings.shared.username = "Login"
        // Call the dismissal handler
        self.handleDismissal?()
    }
}
