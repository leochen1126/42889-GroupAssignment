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
    @Published var username = UserSettings.shared
    @Published var password = ""
    @Published var loginSuccessful = false
    @Published var loginFailed = false
    
    private var db = Firestore.firestore()
        
    
    func login() {
        let usersRef = db.collection("user_info")
        
        usersRef.whereField("userName", isEqualTo: self.username).getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
                DispatchQueue.main.async {
                    self.loginFailed = true
                }
            } else {
                
            }
            print("Username not found")
            DispatchQueue.main.async {
                self.loginFailed = true
            }
        }
    }
}
