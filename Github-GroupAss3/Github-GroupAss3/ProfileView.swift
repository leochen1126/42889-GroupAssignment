//
//  ProfileView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 10/5/2024.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 28/255, green: 28/255, blue: 38/255).edgesIgnoringSafeArea(.all)
                VStack {
                    profileDetails
                    actionButtons
                }
                .padding()
                .cornerRadius(16)
                .padding()
            }
            .onAppear {
                viewModel.fetchUserDetails()//fetch user data from db
                viewModel.handleDismissal = {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    var profileDetails: some View {
        VStack {
            Text(viewModel.username)//show session data
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Text("Email: \(viewModel.email)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Text("Address: \(viewModel.address)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
            Text("Phone: \(viewModel.phone)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
    }
    
    var actionButtons: some View {
        HStack {
            Spacer()
            //Go to edit personall data
            NavigationLink(destination: ProfileEditView()) {
                Text("Edit     ")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color(red: 237/255, green: 49/255, blue: 140/255))
            .cornerRadius(8)
            Spacer()
            Button(action: viewModel.logout) {//Erase session data
                Text("LogOut")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color(red: 237/255, green: 49/255, blue: 140/255))
            .cornerRadius(8)
            Spacer()
        }
        .padding()
    }
}


#Preview {
    ProfileView()
}
