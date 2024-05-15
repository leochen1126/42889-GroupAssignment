//
//  LoginView.swift
//  Github-GroupAss3
//
//  Created by Ming-You Chen on 9/5/2024.
//
import SwiftUI
struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode // control viewpage
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    loginHeader
                    inputFields
                    loginButton
                }
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(16)
                .padding()
            }
        }
        .onAppear {
            viewModel.handleDismissal = { //jump back to menu if login successfully
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    var loginHeader: some View {
        Text("Login")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }

    var inputFields: some View {// user input part
        VStack {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal)
    }

    var loginButton: some View {
        HStack {
            Spacer()
            Button("Login") {
                viewModel.login()
            }
            .alert(isPresented: $viewModel.loginFailed) {
                Alert(title: Text("Failed"), message: Text("Login failed. Please try again."), dismissButton: .default(Text("OK")))//jump out error message
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            .padding()
            Spacer()

            NavigationLink(destination: RegisterView()) {// lead to registerview
                Text("Register")
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color.blue)
            .cornerRadius(8)

            Spacer()
        }
        .padding()
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
