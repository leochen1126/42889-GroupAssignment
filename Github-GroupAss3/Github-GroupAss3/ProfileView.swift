//
//  ProfileView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 9/5/2024.
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
                    userInfoSection
                    actionButtons
                }
                .onAppear(perform: viewModel.fetchUserDetails)
            }
        }
    }

    private var userInfoSection: some View {
        VStack {
            userInfoText("Username: \(viewModel.username)", font: .largeTitle)
            userInfoText("Email: \(viewModel.email)")
            userInfoText("Address: \(viewModel.address)")
            userInfoText("Phone: \(viewModel.phone)")
        }
        .padding()
        .background(Color.gray.opacity(0.8))
        .cornerRadius(16)
        .padding()
    }

    private func userInfoText(_ text: String, font: Font = .title) -> some View {
        Text(text)
            .font(font)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }

    private var actionButtons: some View {
        HStack {
            Spacer()
            NavigationLink(destination: ProfileEditView()) {
                actionButtonLabel("Edit")
            }
            Spacer()
            Button(action: viewModel.logout) {
                actionButtonLabel("LogOut")
            }
            Spacer()
        }
        .padding()
    }

    private func actionButtonLabel(_ text: String) -> some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
