//
//  ProfileView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 12/5/2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Text(viewModel.username)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Email:\(viewModel.email)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Address:\(viewModel.address)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Phone:\(viewModel.phone)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        
                        
                        HStack {
                            Spacer()
                            
                            NavigationLink(destination: ProfileEditView()) {
                                Text("Edit")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .background(Color.blue)
                            .cornerRadius(8)
                            Spacer()
                            Button(action: viewModel.logout, label: {
                                Text("LogOut")
                                    .foregroundColor(.white)
                                    .padding()
                            })
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
                .onAppear{
                    viewModel.fetchUserDetails()
                    // Set the dismissal handler
                    viewModel.handleDismissal = {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
