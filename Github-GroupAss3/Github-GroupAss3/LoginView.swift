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
                Color(red: 28/255, green: 28/255, blue: 38/255).edgesIgnoringSafeArea(.all)
                VStack {
                    loginHeader
                    inputFields
                    loginButton
                }
                .padding()
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
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
    }

    var inputFields: some View {// user input part
        VStack {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(Color(red: 184/255, green: 49/255, blue: 115/255))
                
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .foregroundColor(Color(red: 184/255, green: 49/255, blue: 115/255))
                
        }
        .cornerRadius(8)
        .padding(.horizontal)
    }

    var loginButton: some View {
        HStack {
            Spacer()
            Button("Login    ") {
                viewModel.login()
            }
            .alert(isPresented: $viewModel.loginFailed) {
                Alert(title: Text("Failed"), message: Text("Login failed. Please try again."), dismissButton: .default(Text("OK")))//jump out error message
            }
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 237/255, green: 49/255, blue: 140/255))
            .cornerRadius(8)
            .padding()
            Spacer()

            NavigationLink(destination: RegisterView()) {// lead to registerview
                Text("Register")
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


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
