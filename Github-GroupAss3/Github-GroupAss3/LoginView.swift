import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    
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
                        TextField("Username", text: $viewModel.userName)
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
                                                    viewModel.login { success in
                                                        if success {
                                                            // Navigate to the next screen (e.g., home screen)
                                                            // You can customize this part based on your navigation setup
                                                        } else {
                                                            // Show an error message (optional)
                                                        }
                                                    }
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
