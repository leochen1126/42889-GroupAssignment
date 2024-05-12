//
//  LoginViewModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 12/5/2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var userName = ""
    @Published var password = ""
    func login(completion: @escaping (Bool) -> Void) {
            Auth.auth().signIn(withEmail: userName, password: password) { result, error in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Login successful")
                    completion(true)
                }
            }
        }
    
}
