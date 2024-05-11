//
//  Github_GroupAss3App.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 7/5/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    //let db = Firestore.firestore()
              // [END default_firestore]
    //print(db) // silence warning
    return true
  }
}
   
@main
struct Github_GroupAss3App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationView{
                MenuView()
            }
        }
    }
}
