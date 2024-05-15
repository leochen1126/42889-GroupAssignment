//
//  ProfileEditView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 11/5/2024.
//
//similar with registerView
import SwiftUI

struct ProfileEditView: View {
    @ObservedObject var viewModel = ProfileEditViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                updateHeader
                inputFields
                updateButton
            }
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(16)
            .padding()
        }
    }
    
    var updateHeader: some View {
        Text("Update")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }
    
    var inputFields: some View {//error format prevention
        VStack {
            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.email) {
                    viewModel.isEmailValid = viewModel.isValidEmail()
                }
                .foregroundColor(viewModel.isEmailValid ? .black : .red)
            
            TextField("Phone Number", text: $viewModel.phoneNumber)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.phoneNumber) {
                    viewModel.isPhoneNumberValid = viewModel.isValidPhoneNumber()
                }
                .foregroundColor(viewModel.isPhoneNumberValid ? .black : .red)
            
            TextField("Address", text: $viewModel.address)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal)
                .onChange(of: viewModel.address) {
                    viewModel.isAddressValid = viewModel.isValidAddress()
                }
                .foregroundColor(viewModel.isAddressValid ? .black : .red)
        }
    }
    
    var updateButton: some View {
        Button("Update") {
            viewModel.onSuccessfulUpdate = {
                presentationMode.wrappedValue.dismiss()
            }
            viewModel.update()
        }
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(8)
        .padding()
        .disabled(!viewModel.isFormValid())
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Update Successful"),
                message: Text("You have been updated!"),
                dismissButton: .default(Text("OK")) {}
            )
        }
    }
}


#Preview {
    ProfileEditView()
}
