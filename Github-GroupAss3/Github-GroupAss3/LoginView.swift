import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        TextField("Username", text: $viewModel.username)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                        HStack {
                            Spacer()
                                Button("Login") {
                                    viewModel.login()
                                }
                                .alert(isPresented: $viewModel.loginSuccessful) {
                                    Alert(title: Text("Success"), message: Text("Login successful!"), dismissButton: .default(Text("OK")) )
                                }
                                .alert(isPresented: $viewModel.loginFailed) {
                                    Alert(title: Text("Failed"), message: Text("Login failed. Please try again."), dismissButton: .default(Text("OK")))
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding()
                            Spacer()
                            
                            NavigationLink(destination: RegisterView()) {
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
                    .padding()
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(16)
                    .padding()
                }
            }
        }
        .onAppear {
                    // Set the dismissal handler
                    viewModel.handleDismissal = {
                        presentationMode.wrappedValue.dismiss()
                    }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
