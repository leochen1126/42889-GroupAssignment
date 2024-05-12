import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                
                
                VStack {
                    Text("Register")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .onChange(of: viewModel.username){
                               viewModel.isUsernameValid = viewModel.isValidUsername()
                        }
                        .foregroundColor(viewModel.isUsernameValid ? .black : .red)
                    
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
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .onChange(of: viewModel.password) {
                            viewModel.isPasswordValid = viewModel.isValidPassword()
                        }
                        .foregroundColor(viewModel.isPasswordValid ? .black : .red)
                    
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .onChange(of: viewModel.confirmPassword) {
                            viewModel.isConfirmPasswordValid = viewModel.isValidConfirmPassword()
                        }
                        .foregroundColor(viewModel.isConfirmPasswordValid ? .black : .red)
                    
                    Button("Register", action: {
                                viewModel.register()
                                if viewModel.registrationSuccessful {
                                    presentationMode.wrappedValue.dismiss() // Navigate back to the previous view
                                }
                    })
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                        .disabled(!viewModel.isFormValid())
                        .alert(isPresented: $viewModel.showAlert) {
                            Alert(
                                title: Text("Registration Successful"),
                                message: Text("You are now registered!"),
                                dismissButton: .default(Text("OK")) {
                                    // Navigate back to the previous page (e.g., using a presentation mode)
                                    // You can customize this part based on your navigation setup
                                }
                            )
                        }
                }
                .padding()
                .background(Color.gray.opacity(0.8))
                .cornerRadius(16)
                .padding()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
