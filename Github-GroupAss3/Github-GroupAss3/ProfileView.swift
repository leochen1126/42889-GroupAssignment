//
//  ProfileView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 12/5/2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @ObservedObject var userModel = UserSettings.shared
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Text("Username")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Email:")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Address:")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Phone:")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: RegisterView()) {
                                Text("Edit my Profile")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .background(Color.blue)
                            .cornerRadius(8)
                            Spacer()
                            NavigationLink(destination: RegisterView()) {
                                Text("Logout")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(16)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
