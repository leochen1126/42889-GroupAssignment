//
//  UserSettingModel.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 9/5/2024.
//
// This file for saving user session
import Foundation
class UserSettings: ObservableObject {
    static let shared = UserSettings()
    @Published var username: String = "Login"
    @Published var admin: Bool = false
    private init() {} // This prevents others from using the default '()' initializer
}
